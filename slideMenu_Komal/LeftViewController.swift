//
//  LeftViewController.swift
//  slideMenu_Komal
//
//  Created by Komal Barde on 26/02/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var menuTableView: UITableView!
    var mainViewController: UIViewController!

    var array = ["HOME","All Matches","Saved Matches"]
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = array[indexPath.row]
        return cell
        
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect")
        // self.performSegue(withIdentifier: array[indexPath.row], sender: self)
        if indexPath.row == 0{
            let homeVc = storyboard?.instantiateViewController(identifier: "MainViewController")as! MainViewController
            self.navigateToSelectedViewContraoller(selectedVC: homeVc)
        }else if indexPath.row == 1{
            let allMatch = storyboard?.instantiateViewController(identifier: "AllMatchesViewController")as! AllMatchesViewController
            self.navigateToSelectedViewContraoller(selectedVC: allMatch)
        }else if indexPath.row == 2{
            let allMatch = storyboard?.instantiateViewController(identifier: "SavedMatchesViewController")as! SavedMatchesViewController
            self.navigateToSelectedViewContraoller(selectedVC: allMatch)
        }
    }

    private func navigateToSelectedViewContraoller(selectedVC:UIViewController){
    
    if let revealViewController:SWRevealViewController = self.revealViewController(){
        let navigationController = UINavigationController(rootViewController: selectedVC)
        revealViewController.pushFrontViewController(navigationController, animated: true)
    }
    }

  

}
