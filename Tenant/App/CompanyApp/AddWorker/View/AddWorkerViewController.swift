//
//  AddNewWorkerViewController.swift
//  Raabt2
//
//  Created by Ngc on 19/07/2024.
//

import UIKit
import Dispatch
class AddWorkerViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tradeView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tradeLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(UINib(nibName: "AddWorkerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AddWorkerCollectionViewCell.cellReuseIdentifier())
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    private var selectedIndexes: Set<IndexPath> = []
    var pickerView = UIPickerView()
    private var viewModel = AddWorkerViewModel()
    var dispatchGroup: DispatchGroup?
    var branchID = 0
    
    var image: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = false
        reloadData()
        titlLabel.text = LocalizationKeys.addNewWorker.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.workerName.rawValue.localizeString()
        numberLabel.text = LocalizationKeys.contactNumber.rawValue.localizeString()
        categoryLabel.text = LocalizationKeys.selectBranch.rawValue.localizeString()
        tradeLabel.text = LocalizationKeys.selectTrade.rawValue.localizeString()
        addButton.setTitle(LocalizationKeys.addWorker.rawValue.localizeString(), for: .normal)
        cancelButton.setTitle(LocalizationKeys.cancel.rawValue.localizeString(), for: .normal)
        categoryTextField.placeholder = LocalizationKeys.selectBranch.rawValue.localizeString()
        
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        numberTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        categoryTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        type = .company
        
        self.animateSpinner()
        networkingCall()
        
        viewModel.workerAdded.bind { [unowned self] worker in
            guard let worker = worker else {return}
            self.stopAnimation()
            if worker.success == true{
                self.showAlertWithbutttons(message: worker.message ?? "") {
                    NotificationCenter.default.post(name: Notification.Name(Constants.reloadWorkers), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                showAlert(message: worker.message ?? "")
            }
        }
    }
    
    private func networkingCall(){
        dispatchGroup = DispatchGroup()
        dispatchGroup?.enter()
        viewModel.getSkillcategories()
        dispatchGroup?.enter()
        viewModel.getBranches()
        
        viewModel.branches.bind { [weak self] branches in
            guard let _ = branches else {return}
            self?.dispatchGroup?.leave()
        }
        
        viewModel.skill.bind { [weak self] skill in
            guard let _ = skill else {return}
            self?.dispatchGroup?.leave()
        }
        
        dispatchGroup?.notify(queue: .main) {
            self.stopAnimation()
            self.collectionView.reloadData()
            self.pickerView.reloadAllComponents()
        }
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        var ids = [String]()
        for indexPath in selectedIndexes {
            let id = viewModel.getSkillID(at: indexPath.row)
            ids.append(String(id))
        }
        let worker = AddWorkerInputModel(name: nameTextField.text ?? "", contact: numberTextField.text ?? "", branchID: branchID, skillIDs: ids.joined(separator: ","))
        let validationResponse = viewModel.isFormValid(worker: worker)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.addWorker(image: self.imageView.image ?? UIImage())
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        updateCollectionViewHeight()
    }
    
//    func updateCollectionViewHeight() {
//        collectionViewHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
//        tradeView.frame = CGRect(origin: CGPoint(x: collectionView.frame.origin.x, y: collectionView.frame.origin.y), size: CGSize(width: collectionView.frame.size.width, height: collectionViewHeight.constant))
//    }
    
    func reloadData() {
        collectionView.reloadData()
//        updateCollectionViewHeight()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getSkillCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddWorkerCollectionViewCell.cellReuseIdentifier(), for: indexPath)as! AddWorkerCollectionViewCell
        cell.isChecked = selectedIndexes.contains(indexPath)
        cell.tradesTitleLbl.text = viewModel.getSkillName(at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath) {
            selectedIndexes.remove(indexPath)
        } else {
            selectedIndexes.insert(indexPath)
        }
        collectionView.reloadItems(at: [indexPath])
    }
}

extension AddWorkerViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 105, height: 50)
    }
}

extension AddWorkerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getBranchesCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getBranchName(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = viewModel.getBranchName(at: row)
        branchID = viewModel.getBranchID(at: row)
    }
}

extension AddWorkerViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.image = image
            self.imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

