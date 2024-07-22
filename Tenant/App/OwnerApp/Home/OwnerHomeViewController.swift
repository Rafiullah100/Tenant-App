//
//  HomeViewController.swift
//  Raabt2
//
//  Created by Ngc on 04/07/2024.
//

import UIKit


class OwnerHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    var isNew = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        searchView.clipsToBounds = true
        newButton.setTitle(LocalizationKeys.new.rawValue.localizeString(), for: .normal)
        ongoingButton.setTitle(LocalizationKeys.ongoing.rawValue.localizeString(), for: .normal)
        searchTextField.placeholder = LocalizationKeys.search.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        isDone.toggle()
        if isDone {
            doneButton.setImage(UIImage(named: "tick-green"), for: .normal)
        }else{
            doneButton.setImage(UIImage(named: "tick-gray"), for: .normal)
        }
    }
    
    @IBAction func rejectedButtonAction(_ sender: Any) {
        isNew = false
        setupButton()
    }
    
    @IBAction func ongoingBtnAction(_ sender: Any) {
        isNew = false
        setupButton()
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        isNew = true
        setupButton()
    }
    
    private func setupButton(){
        tableView.reloadData()
        if isNew {
            newButton.backgroundColor = CustomColor.appColor.color
            ongoingButton.backgroundColor = CustomColor.grayColor.color
        }
        else{
            ongoingButton.backgroundColor = CustomColor.appColor.color
            newButton.backgroundColor = CustomColor.grayColor.color
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
