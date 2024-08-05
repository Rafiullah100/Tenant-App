//
//  HomeViewController.swift
//  Raabt2
//
//  Created by Ngc on 04/07/2024.
//

import UIKit


class OwnerHomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
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
            tableView.register(UINib(nibName: "OwnerHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    
    private var isDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false

        searchView.clipsToBounds = true
        newButton.setTitle(LocalizationKeys.new.rawValue.localizeString(), for: .normal)
        ongoingButton.setTitle(LocalizationKeys.ongoing.rawValue.localizeString(), for: .normal)
        searchTextField.placeholder = LocalizationKeys.search.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        setupButton(complaintType: .new)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        isDone.toggle()
        doneButton.setImage(UIImage(named: isDone ? "tick-green" : "tick-gray"), for: .normal)
    }
    
    @IBAction func rejectedButtonAction(_ sender: Any) {
        setupButton(complaintType: .rejected)
    }
    
    @IBAction func ongoingBtnAction(_ sender: Any) {
        setupButton(complaintType: .ongoing)
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        setupButton(complaintType: .new)
    }
    
    private func setupButton(complaintType: OwnerComplaintType = .new){
        tableView.reloadData()
        newButton.backgroundColor = CustomColor.grayColor.color
        ongoingButton.backgroundColor = CustomColor.grayColor.color
        rejectedButton.backgroundColor = CustomColor.grayColor.color

        switch complaintType {
        case .new:
            newButton.backgroundColor = CustomColor.appColor.color
        case .ongoing:
            ongoingButton.backgroundColor = CustomColor.appColor.color
        case .rejected:
            rejectedButton.backgroundColor = CustomColor.appColor.color
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OwnerHomeTableViewCell
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {            Switcher.gotoOwnerDetail(delegate: self)
    }
}
