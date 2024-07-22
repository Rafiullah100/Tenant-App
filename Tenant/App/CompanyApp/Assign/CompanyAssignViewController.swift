//
//  AssignViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/10/24.
//

import UIKit

class CompanyAssignViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var assignButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var workerLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var workerTextField: UITextField!
    @IBOutlet weak var skillTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setImage(UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en"), for: .normal)

        dateTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        workerTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        skillTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        categoryTextField.textAlignment = Helper.shared.isRTL() ? .right : .left

        propertyLabel.text = LocalizationKeys.property.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        titleLabel.text = LocalizationKeys.titlle.rawValue.localizeString()
        categoryLabel.text = LocalizationKeys.category.rawValue.localizeString()
        skillLabel.text = LocalizationKeys.skill.rawValue.localizeString()
        workerLabel.text = LocalizationKeys.workers.rawValue.localizeString()
        dateLabel.text = LocalizationKeys.selectDate.rawValue.localizeString()
        assignButton.setTitle(LocalizationKeys.assignToWorker.rawValue.localizeString(), for: .normal)
        
        dateTextField.placeholder = LocalizationKeys.chooseDate.rawValue.localizeString()
        workerTextField.placeholder = LocalizationKeys.selectWorkers.rawValue.localizeString()
        skillTextField.placeholder = LocalizationKeys.selectSkills.rawValue.localizeString()
        categoryTextField.placeholder = LocalizationKeys.selectBranch.rawValue.localizeString()

    }
    

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
