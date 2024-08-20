//
//  HomeViewController.swift
//  Raabt2
//
//  Created by Ngc on 04/07/2024.
//

import UIKit


class CompanyHomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var rejectedButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ongoingButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CompanyNewTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            
            tableView.register(UINib(nibName: "CompanyOngoingTableViewCell", bundle: nil), forCellReuseIdentifier: "ongoing")
        }
    }
    
    var isNew = true
    private var isDone = false
    private var complaintType: CompanyComplaintType = .new

    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.clipsToBounds = true
        newButton.setTitle(LocalizationKeys.new.rawValue.localizeString(), for: .normal)
        ongoingButton.setTitle(LocalizationKeys.ongoing.rawValue.localizeString(), for: .normal)
        searchTextField.placeholder = LocalizationKeys.search.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        isDone.toggle()
        doneButton.setImage(UIImage(named: isDone ? "tick-green" : "tick-gray"), for: .normal)
    }
    
    @IBAction func profileBtnAction(_ sender: Any) {
        Switcher.gotoCompanyProfile(delegate: self)
    }
    
    @IBAction func ongoingBtnAction(_ sender: Any) {
        isNew = false
        setupButton(complaintType: .ongoing)
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        isNew = true
        setupButton(complaintType: .new)
    }
    
    private func setupButton(complaintType: CompanyComplaintType = .new){
        tableView.reloadData()
        newButton.backgroundColor = CustomColor.grayColor.color
        ongoingButton.backgroundColor = CustomColor.grayColor.color
        switch complaintType {
        case .new:
            newButton.backgroundColor = CustomColor.appColor.color
        case .ongoing:
            ongoingButton.backgroundColor = CustomColor.appColor.color
        case .completed:
            print("")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isNew {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompanyNewTableViewCell
            switch Int.random(in: 0..<3) {
            case 0:
                cell.colorView.backgroundColor = CustomColor.greenColor.color
            case 1:
                cell.colorView.backgroundColor = CustomColor.blueColor.color
            case 2:
                cell.colorView.backgroundColor = CustomColor.redColor.color
            default:
                cell.colorView.backgroundColor = CustomColor.greenColor.color
            }

            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ongoing", for: indexPath) as! CompanyOngoingTableViewCell
            switch Int.random(in: 0..<3) {
            case 0:
                cell.colorView.backgroundColor = CustomColor.greenColor.color
            case 1:
                cell.colorView.backgroundColor = CustomColor.blueColor.color
            case 2:
                cell.colorView.backgroundColor = CustomColor.redColor.color
            default:
                cell.colorView.backgroundColor = CustomColor.greenColor.color
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isNew{
            Switcher.gotoPendingDetail(delegate: self)
        }
        else{
            Switcher.gotoCompletedDetail(delegate: self)
        }
    }
}
