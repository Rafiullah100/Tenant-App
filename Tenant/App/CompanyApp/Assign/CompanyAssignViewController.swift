//
//  AssignViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/10/24.
//

import UIKit

class CompanyAssignViewController: BaseViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        workerTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        skillTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        categoryTextField.textAlignment = Helper.shared.isRTL() ? .right : .left

        propertyLabel.text = LocalizationKeys.property.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        titlLabel.text = LocalizationKeys.titlle.rawValue.localizeString()
        categoryLabel.text = LocalizationKeys.category.rawValue.localizeString()
        skillLabel.text = LocalizationKeys.skill.rawValue.localizeString()
        workerLabel.text = LocalizationKeys.workers.rawValue.localizeString()
        dateLabel.text = LocalizationKeys.selectDate.rawValue.localizeString()
        assignButton.setTitle(LocalizationKeys.assignToWorker.rawValue.localizeString(), for: .normal)
        
        dateButton.setTitle(LocalizationKeys.chooseDate.rawValue.localizeString(), for: .normal)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    @IBAction func dateBtnAction(_ sender: Any) {
        Switcher.gotoDatePicker(delegate: self)
    }
}

extension CompanyAssignViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPickerView {
            return "category name"
        }
        else if pickerView == skillPickerView{
            return "skill name"
        }
        else if pickerView == workerPickerView{
            return "worker name"
        }
        else {
            return "9am-12pm"
        }
    }
}

