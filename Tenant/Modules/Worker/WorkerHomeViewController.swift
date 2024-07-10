//
//  WorkerHomeViewController.swift
//  Worker
//
//  Created by Ngc on 10/07/2024.
//

import UIKit

struct workDetails{
    let title:String?
    let by:String?
    let maintanance:String?
    let status:String?
    let postedDate:String?
    let assignedDate:String?
}


class WorkerHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var workerHomeTableView: UITableView!
    
    var tasks: [workDetails]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workerHomeTableView.delegate = self
        workerHomeTableView.dataSource = self
        workerHomeTableView.register(UINib(nibName: "WorkerHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tasks = [workDetails(title: "Lounge Repair Work", by: "Flat 234, Building 405, District, City", maintanance: "June 25, 2024  12:25 PM", status: "Work in Progress", postedDate: "June 25, 2024  12:25 PM", assignedDate: "June 25, 2024  12:25 PM"),
                 
            workDetails(title: "Lounge Repair Work", by: "Flat 234, Building 405, District, City", maintanance: "June 25, 2024  12:25 PM", status: "Work in Progress", postedDate: "June 25, 2024  12:25 PM", assignedDate: "June 25, 2024  12:25 PM"),
            
            workDetails(title: "Lounge Repair Work", by: "Flat 234, Building 405, District, City", maintanance: "June 25, 2024  12:25 PM", status: "Work in Progress", postedDate: "June 25, 2024  12:25 PM", assignedDate: "June 25, 2024  12:25 PM"),
                     
            workDetails(title: "Lounge Repair Work", by: "Flat 234, Building 405, District, City", maintanance: "June 25, 2024  12:25 PM", status: "Work in Progress", postedDate: "June 25, 2024  12:25 PM", assignedDate: "June 25, 2024  12:25 PM")
        ]
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkerHomeTableViewCell
        cell.workerHome(WorkerHome: tasks[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
  
}
