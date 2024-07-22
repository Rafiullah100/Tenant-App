//
//  ViewController.swift
//  Raabt
//
//  Created by Ngc on 27/06/2024.
//

import UIKit



class SelfHomeViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var historyTableView: UITableView!{
        didSet{
            historyTableView.delegate = self
            historyTableView.dataSource = self
            historyTableView.register(UINib(nibName: "SelfHomeTableViewCell", bundle: nil), forCellReuseIdentifier: SelfHomeTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var historyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        historyLabel.text = LocalizationKeys.history.rawValue.localizeString()
        addressLbl.text = LocalizationKeys.currentAddress.rawValue.localizeString()

    }
    
    @IBAction func contactButtonAction(_ sender: Any) {
        Switcher.gotoContactList(delegate: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: SelfHomeTableViewCell.cellReuseIdentifier(), for: indexPath) as! SelfHomeTableViewCell
        if indexPath.row % 2 == 0{
            cell.colorView.backgroundColor = CustomColor.greenColor.color
        }
        else{
            cell.colorView.backgroundColor = CustomColor.blueColor.color
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


