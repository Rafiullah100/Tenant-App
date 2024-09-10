//
//  ServicesViewController.swift
//  Raabt2
//
//  Created by Ngc on 10/07/2024.
//

import UIKit
import Dispatch
class CompanyWorkerViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var categoryCollectionView: UICollectionView!{
        didSet{
            categoryCollectionView.register(UINib(nibName: "CompanyWorkerCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CompanyWorkerCategoryCollectionViewCell.identifier)
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var workerCollectionView: UICollectionView!{
        didSet{
            workerCollectionView.register(UINib(nibName: "CompanyWorkerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CompanyWorkerCollectionViewCell.identifier)
            workerCollectionView.delegate = self
            workerCollectionView.dataSource = self
        }
    }
    private var viewModel = CompanyWorkerViewModel()
    var row: IndexPath?
    var pickerView = UIPickerView()
    var branchIndex: Int?
    var skillIndex: Int?
    var dispatchGroup: DispatchGroup?

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.showsVerticalScrollIndicator = false
        workerCollectionView.showsVerticalScrollIndicator = false

        searchView.clipsToBounds = true
        searchButtonView.clipsToBounds = true
        textField.textAlignment = Helper.shared.isRTL() ? .right : .left
        textField.placeholder = LocalizationKeys.selectBranch.rawValue.localizeString()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.inputView = pickerView
        
        nameLabel.text = UserDefaults.standard.name
        contactLabel.text = UserDefaults.standard.mobile
        self.animateSpinner()
        networkingCall()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getWorker), name: Notification.Name(Constants.reloadWorkers), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
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
            self.bindWorkerToView()
            self.categoryCollectionView.reloadData()
            self.pickerView.reloadAllComponents()
//            self.getWorker()
        }
    }
    
    @objc private func getWorker(){
        if branchIndex != nil && skillIndex != nil{
            self.animateSpinner()
            viewModel.getWorkers(branchID: viewModel.getBranchID(at: branchIndex ?? 0), skillID: viewModel.getSkillID(at: skillIndex ?? 0))
        }
        else if branchIndex != nil && skillIndex == nil{
            self.animateSpinner()
            viewModel.getWorkers(branchID: viewModel.getBranchID(at: branchIndex ?? 0))
        }
    }
    
    func bindWorkerToView(){
        viewModel.workers.bind { [weak self] workers in
            self?.stopAnimation()
            guard let _ = workers else {return}
            self?.workerCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return viewModel.getSkillCount()
        }
        else{
            return viewModel.getWorkerCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CompanyWorkerCategoryCollectionViewCell.identifier, for: indexPath) as! CompanyWorkerCategoryCollectionViewCell
            cell.skill = viewModel.getSkill(at: indexPath.row)
            if row == indexPath{
                cell.servicesBgView.backgroundColor = .black
                cell.titleLbl.textColor = .black
            }else{
                cell.servicesBgView.backgroundColor = .white
                cell.titleLbl.textColor = CustomColor.categoryGrayColor.color
            }
            return cell
        }else{
            let cell = workerCollectionView.dequeueReusableCell(withReuseIdentifier: CompanyWorkerCollectionViewCell.identifier, for: indexPath)as! CompanyWorkerCollectionViewCell
            cell.worker = viewModel.getWorker(at: indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            row = indexPath
            collectionView.reloadData()
            skillIndex = indexPath.row
            self.getWorker()
        }
        else{
//            Switcher.gotoWorkerListScreen(delegate: self)
            
        }
    }
}

extension CompanyWorkerViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: 65, height: 75)
        }
        else{
            let cellsAcross: CGFloat = 2
            let spaceBetweenCells: CGFloat = 10
            let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
            return CGSize(width: width, height: 170)
        }
    }
}

extension CompanyWorkerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
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
        textField.text = viewModel.getBranchName(at: row)
        branchIndex = row
        self.getWorker()
    }
}



