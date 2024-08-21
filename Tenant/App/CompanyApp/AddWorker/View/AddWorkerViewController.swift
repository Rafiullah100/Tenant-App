//
//  AddNewWorkerViewController.swift
//  Raabt2
//
//  Created by Ngc on 19/07/2024.
//

import UIKit

class AddWorkerViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

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

    override func viewDidLoad() {
            super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = false

        reloadData()
        titlLabel.text = LocalizationKeys.addNewWorker.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.workerName.rawValue.localizeString()
        numberLabel.text = LocalizationKeys.contactNumber.rawValue.localizeString()
        categoryLabel.text = LocalizationKeys.selectCategory.rawValue.localizeString()
        tradeLabel.text = LocalizationKeys.selectTrade.rawValue.localizeString()
        addButton.setTitle(LocalizationKeys.addWorker.rawValue.localizeString(), for: .normal)
        cancelButton.setTitle(LocalizationKeys.cancel.rawValue.localizeString(), for: .normal)
        
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        numberTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        categoryTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        type = .company
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewHeight()
    }
    
    func updateCollectionViewHeight() {
        collectionViewHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        tradeView.frame = CGRect(origin: CGPoint(x: collectionView.frame.origin.x, y: collectionView.frame.origin.y), size: CGSize(width: collectionView.frame.size.width, height: collectionViewHeight.constant))
    }
    
    func reloadData() {
        collectionView.reloadData()
        updateCollectionViewHeight()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddWorkerCollectionViewCell.cellReuseIdentifier(), for: indexPath)as! AddWorkerCollectionViewCell
        cell.isChecked = selectedIndexes.contains(indexPath)
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
            return CGSize(width: 105, height: 37)
    }
}

extension AddWorkerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "worker name"
    }
}



