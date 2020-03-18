//
//  SavedMatchesViewController.swift
//  slideMenu_Komal
//
//  Created by Komal Barde on 26/02/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import UIKit
import CoreData
class SavedMatchesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    @IBOutlet weak var barBtn: UIBarButtonItem!
    @IBOutlet weak var savedTableView: UITableView!
    let context = AppDelegate().persistentContainer.viewContext
    var tablearray = [VenueEntity]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSFetchRequest<VenueEntity>.init(entityName: "VenueEntity")
        let result = try!context.fetch(request)
        tablearray = result
        savedTableView.register(UINib(nibName: "AllMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllMatchesTableViewCell")
        savedTableView.delegate = self
        savedTableView.dataSource = self
    }
    
    @IBAction func barBtnAction(_ sender: Any) {
        if let vc = self.revealViewController(){
            vc.revealToggle(barBtn)
            vc.panGestureRecognizer()
            vc.rearViewRevealWidth = 300
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablearray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllMatchesTableViewCell", for: indexPath) as! AllMatchesTableViewCell
        cell.nameLbl.text = tablearray[indexPath.row].name
        cell.addressLbl.text = tablearray[indexPath.row].address
        cell.saveBtn.isHidden = true
        return cell
       }
    
}
