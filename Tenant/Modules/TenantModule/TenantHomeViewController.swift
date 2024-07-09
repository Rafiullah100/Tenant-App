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
            historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildingLabel.text = "\(LocalizationKeys.buildingNo.rawValue.localizeString()):   12ADF"
        flatLabel.text = "\(LocalizationKeys.flatNo.rawValue.localizeString()):   14"
        historyLabel.text = LocalizationKeys.history.rawValue.localizeString()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0{
            Switcher.gotoTenantDetailScreen(delegate: self)
        }
        else{
            Switcher.gotoTenantCompletedDetailScreen(delegate: self)
        }
    }
}


