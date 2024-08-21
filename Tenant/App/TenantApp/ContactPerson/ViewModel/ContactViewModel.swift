//
//  ContactViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/20/24.
//

import Foundation


class ContactViewModel {
    var errorMessage: Observable<String> = Observable("")
    var contactList: Observable<ContactModel> = Observable(nil)
        
    func getComplaints(id: Int){
        _ = URLSession.shared.request(route: .contactList, method: .post, parameters: ["id": id], model: ContactModel.self) { result in
            switch result {
            case .success(let list):
                self.contactList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getContactCount() -> Int {
        return self.contactList.value?.complaintContacts?.count ?? 0
    }
    
    func getContact(at index: Int) -> ComplaintContact? {
        return self.contactList.value?.complaintContacts?[index]
    }
}
