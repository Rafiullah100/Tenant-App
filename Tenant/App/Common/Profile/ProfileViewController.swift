//
//  ProfileViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 9/26/24.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    private var viewModel = ProfileViewModel()

    var pickerView = UIPickerView()
    var userType: UserType?
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .company

        contactLabel.text = LocalizationKeys.contactNumber.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.name.rawValue.localizeString()
        contactTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        updateButton.setTitle(LocalizationKeys.updateInformation.rawValue.localizeString(), for: .normal)
        viewModel.profile.bind { [unowned self] profile in
            guard let _ = profile else {return}
            self.stopAnimation()
            self.updateUI()
        }
        self.animateSpinner()
        viewModel.getProfile(userID: UserDefaults.standard.userID ?? 0, userType: userType ?? .tenant)
        
        viewModel.updateProfile.bind { [unowned self] updated in
            guard let _ = updated else {return}
            self.stopAnimation()
            ToastManager.shared.showToast(message: updated?.message ?? "")
        }
    }
    
    private func updateUI(){
        print(viewModel.getProfileImage())
        nameTextField.text = viewModel.getName()
        contactTextField.text = viewModel.getContact()
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (viewModel.getProfileImage())), placeholderImage: UIImage(named: "User"))
    }
    
    @IBAction func takePhotoBtn(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        let profile = UpdateProfileInputModel(id: UserDefaults.standard.userID ?? 0, name: nameTextField.text ?? "", contact: contactTextField.text ?? "", type: userType?.rawValue ?? "")
        let validationResponse = viewModel.isFormValid(profile: profile)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.updateProfile(image: imageView.image ?? UIImage())
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }

}

extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
