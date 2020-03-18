//
//  MainViewController.swift
//  slideMenu_Komal
//
//  Created by Komal Barde on 26/02/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hii")


       
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
       }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        if let vc = self.revealViewController(){
            vc.revealToggle(menuButton)
            vc.panGestureRecognizer()
            vc.rearViewRevealWidth = 300
            print("more tab is clicked")
            
        }
        
    }
    
    
}


extension UIStoryboard {
    
    //Main
    static func Main() -> UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
    static func CustomPopup() -> UIStoryboard {
        return UIStoryboard(name:"CustomPopup", bundle: Bundle.main)
    }
    // ReportSettings
    
    
    static func ReportSettings() -> UIStoryboard {
        return UIStoryboard(name:"ReportSettings", bundle: Bundle.main)
    }
    
    static func BackupSettings() -> UIStoryboard {
        return UIStoryboard(name:"Backup", bundle: Bundle.main)
    }
}



