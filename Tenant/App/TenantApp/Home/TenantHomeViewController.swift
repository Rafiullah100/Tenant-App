//
//  ViewController.swift
//  Raabt
//
//  Created by Ngc on 27/06/2024.
//

import UIKit



class TenantHomeViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var historyTableView: UITableView!{
        didSet{
            historyTableView.delegate = self
            historyTableView.dataSource = self
            historyTableView.register(UINib(nibName: "TenantTableViewCell", bundle: nil), forCellReuseIdentifier: TenantTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var historyButton: UIButton!
    
    var isRecent = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildingLabel.text = "\(LocalizationKeys.buildingNo.rawValue.localizeString()):   12ADF"
        flatLabel.text = "\(LocalizationKeys.flatNo.rawValue.localizeString()):   14"
        historyLabel.text = LocalizationKeys.history.rawValue.localizeString()

    }
    @IBAction func historyBtnAction(_ sender: Any) {
        isRecent.toggle()
        if isRecent {
            historyButton.setImage(UIImage(named: "recent"), for: .normal)
            historyLabel.text = LocalizationKeys.recent.rawValue.localizeString()
        }
        else{
            historyButton.setImage(UIImage(named: "history"), for: .normal)
            historyLabel.text = LocalizationKeys.history.rawValue.localizeString()
        }
    }
    
    @IBAction func contactButtonAction(_ sender: Any) {
        Switcher.gotoContactList(delegate: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: TenantTableViewCell.cellReuseIdentifier(), for: indexPath) as! TenantTableViewCell
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
        if indexPath.row % 2 == 0{
            Switcher.gotoTenantCompletedDetailScreen(delegate: self)
        }
        else{
            Switcher.gotoTenantDetailScreen(delegate: self)
        }
    }
}


