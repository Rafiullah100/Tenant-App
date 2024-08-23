//
//  AssignViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/10/24.
//

import UIKit
import Dispatch

class CompanyAssignViewController: BaseViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var assignButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var workerLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var workerTextField: UITextField!
    @IBOutlet weak var skillTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    var categoryPickerView = UIPickerView()
    var skillPickerView = UIPickerView()
    var workerPickerView = UIPickerView()
    var slotPickerView = UIPickerView()

    var complaintID: Int?
    private var viewModel = AssignViewModel()
    var dispatchGroup: DispatchGroup?
    var workerID: Int?
    var skillID: Int?
    var branchID: Int?
    var time: String?
    var date: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        workerTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        skillTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        categoryTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        dateTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        timeTextField.textAlignment = Helper.shared.isRTL() ? .right : .left

        propertyLabel.text = LocalizationKeys.property.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        titlLabel.text = LocalizationKeys.titlle.rawValue.localizeString()
        categoryLabel.text = LocalizationKeys.category.rawValue.localizeString()
        skillLabel.text = LocalizationKeys.skill.rawValue.localizeString()
        workerLabel.text = LocalizationKeys.workers.rawValue.localizeString()
        dateLabel.text = LocalizationKeys.selectDate.rawValue.localizeString()
        assignButton.setTitle(LocalizationKeys.assignToWorker.rawValue.localizeString(), for: .normal)
        
        dateTextField.text = LocalizationKeys.chooseDate.rawValue.localizeString()
        workerTextField.placeholder = LocalizationKeys.selectWorkers.rawValue.localizeString()
        skillTextField.placeholder = LocalizationKeys.selectSkills.rawValue.localizeString()
        categoryTextField.placeholder = LocalizationKeys.selectBranch.rawValue.localizeString()

        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryTextField.inputView = categoryPickerView
        
        skillPickerView.delegate = self
        skillPickerView.dataSource = self
        skillTextField.inputView = skillPickerView
        
        workerPickerView.delegate = self
        workerPickerView.dataSource = self
        workerTextField.inputView = workerPickerView
        
        slotPickerView.delegate = self
        slotPickerView.dataSource = self
        timeTextField.inputView = slotPickerView
        
        type = .company
        
        self.animateSpinner()
        networkingCall()
    }
    
    private func networkingCall(){
        dispatchGroup = DispatchGroup()
        dispatchGroup?.enter()
        viewModel.getSkillcategories()
        dispatchGroup?.enter()
        viewModel.getBranches()
        dispatchGroup?.enter()
        viewModel.getWorkers()
        
        viewModel.branches.bind { [weak self] branches in
            guard let _ = branches else {return}
            self?.dispatchGroup?.leave()
        }
        
        viewModel.skill.bind { [weak self] skill in
            guard let _ = skill else {return}
            self?.dispatchGroup?.leave()
        }
        
        viewModel.workers.bind { [weak self] workers in
            guard let _ = workers else {return}
            self?.dispatchGroup?.leave()
        }
        
        dispatchGroup?.notify(queue: .main) {
            self.stopAnimation()
            self.workerPickerView.reloadAllComponents()
            self.skillPickerView.reloadAllComponents()
            self.categoryPickerView.reloadAllComponents()
        }
        
        viewModel.assign.bind { [weak self] assign  in
            DispatchQueue.main.async {
                self?.stopAnimation()
                if assign?.success == true{
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func dateBtnAction(_ sender: Any) {
        Switcher.gotoDatePicker(delegate: self)
    }
    
    @IBAction func assignBtnAction(_ sender: Any) {
        let assign = AssignInputModel(complaintID: complaintID ?? 0, branchID: branchID ?? 0, skillID: skillID ?? 0, workerID: workerID ?? 0, date: date ?? "", time: time ?? "")
        print(assign)
        let validationResponse = viewModel.isFormValid(assign: assign)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.assignToWorker()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
}

extension CompanyAssignViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPickerView {
            return viewModel.getBranchesCount()
        }
        else if pickerView == skillPickerView{
            return viewModel.getSkillCount()
        }
        else if pickerView == workerPickerView{
            return viewModel.getWorkerCount()
        }
        else {
            return Constants.timeSlotArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPickerView {
            return viewModel.getBranchName(at: row)
        }
        else if pickerView == skillPickerView{
            return viewModel.getSkillName(at: row)
        }
        else if pickerView == workerPickerView{
            return viewModel.getWorkerName(at: row)
        }
        else {
            return Constants.timeSlotArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPickerView {
            branchID = viewModel.getBranchID(at: row)
            categoryTextField.text = viewModel.getBranchName(at: row)
        }
        else if pickerView == skillPickerView{
            skillID = viewModel.getSkillID(at: row)
            skillTextField.text = viewModel.getSkillName(at: row)
        }
        else if pickerView == workerPickerView{
            workerID = viewModel.getWorkerID(at: row)
            workerTextField.text = viewModel.getWorkerName(at: row)
        }
        else {
            time = Constants.timeSlotArray[row]
            timeTextField.text = Constants.timeSlotArray[row]
        }
    }
}


extension  CompanyAssignViewController: DateProtocol{
    func getDate(date: Date) {
        print(date)
        self.date = Helper.shared.convertDateToString(date: date)
        self.dateTextField.text = self.date
    }
    
}
