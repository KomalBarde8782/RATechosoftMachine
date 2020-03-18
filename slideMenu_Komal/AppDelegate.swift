//
//  AppDelegate.swift
//  slideMenu_Komal
//
//  Created by Komal Barde on 26/02/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,SWRevealViewControllerDelegate {


     var window: UIWindow?
    var revealViewController:SWRevealViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
               self.revealViewController = SWRevealViewController();
               self.revealViewController?.rearViewRevealWidth = UIScreen.main.bounds.size.width - 100;
        let menuVC = UIStoryboard.Main().instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let frontVc = UIStoryboard.Main().instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
               let navigationController = UINavigationController(rootViewController: frontVc)







               navigationController.navigationBar.isHidden = true
               self.revealViewController?.frontViewController = navigationController //tababar
               self.revealViewController?.rearViewController = menuVC
               self.revealViewController?.delegate = self
               self.revealViewController?.rearViewRevealDisplacement = 0
               self.revealViewController?.bounceBackOnLeftOverdraw = false
               self.revealViewController?.bounceBackOnOverdraw = false
               self.revealViewController?.rearViewRevealOverdraw = 0
              // self.rearViewRevealOverdraw = 0.0f; // how much of an overdraw can occur when dragging further than 'rearViewRevealWidth' (default 60.0)
             //  self.bounceBackOnOverdraw = NO; // If YES the controller will bounce to the Left position when dragging further than 'rearViewRevealWidth' (default YES)

              // self.revealViewController?.toggleAnimationType = .spring
        self.window?.rootViewController = self.revealViewController
               self.window?.makeKeyAndVisible()
        
        

        return true
    }
    
   func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
          if(position == FrontViewPosition.left){
               revealViewController?.frontViewController.view.isUserInteractionEnabled = true
               revealViewController?.frontViewController.revealViewController()?.tapGestureRecognizer()
              //[revealController.frontViewController.view setUserInteractionEnabled:YES];
              //[revealController.frontViewController.revealViewController tapGestureRecognizer];
          }else{
              //[revealController.frontViewController.view setUserInteractionEnabled:NO];
               revealViewController?.frontViewController.view.isUserInteractionEnabled = true
          }
          
      }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "slideMenu_Komal")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

