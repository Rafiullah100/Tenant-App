//
//  DateViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/7/24.
//

import UIKit

protocol DateProtocol {
    func getDate(date: Date)
}

class DateViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var delegate: DateProtocol?
    
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func datePickerAction(_ sender: Any) {
        date = self.datePicker.date
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func okBtnAction(_ sender: Any) {
        delegate?.getDate(date: date ?? Date())
        self.dismiss(animated: true)
    }
}
