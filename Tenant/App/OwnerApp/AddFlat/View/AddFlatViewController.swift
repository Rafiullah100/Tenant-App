//
//  AddFlatViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/1/24.
//

import UIKit

class AddFlatViewController: BaseViewController {

    @IBOutlet weak var flatNoTextField: UITextField!
    var propertyID: Int?
    var viewModel = AddFlatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.add.bind { add in
            guard let add = add else{return}
            DispatchQueue.main.async {
                self.stopAnimation()
                if add.success == true{
                    self.showAlertWithbutttons(message: add.message ?? "") {
                        NotificationCenter.default.post(name: Notification.Name(Constants.reloadFlats), object: nil)
                        self.dismiss(animated: true)
                    }
                }
                else{
                    self.showAlert(message: add.message ?? "")
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
  
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func addFlatBtnAction(_ sender: Any) {
        let flat = AddFlatInputModel(flatNo: flatNoTextField.text ?? "", propertyID: propertyID ?? 0)
        let validationResponse = viewModel.isFormValid(flat: flat)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.addFlat()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }

}
