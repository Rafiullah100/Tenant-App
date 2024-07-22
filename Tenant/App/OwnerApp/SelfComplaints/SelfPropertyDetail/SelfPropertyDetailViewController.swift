//
//  SelectHomeViewController.swift
//  Raabt2
//
//  Created by Ngc on 22/07/2024.
//

import UIKit


class SelfPropertyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.register(UINib(nibName: "SelfPropertyDetailTableViewCell", bundle: nil), forCellReuseIdentifier: SelfPropertyDetailTableViewCell.cellReuseIdentifier())
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
    }
    
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelfPropertyDetailTableViewCell.cellReuseIdentifier(), for: indexPath) as! SelfPropertyDetailTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
