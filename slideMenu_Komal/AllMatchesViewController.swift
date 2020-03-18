//
//  AllMatchesViewController.swift
//  slideMenu_Komal
//
//  Created by Komal Barde on 26/02/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class AllMatchesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 

    @IBOutlet weak var menuItem: UIBarButtonItem!
    @IBOutlet weak var allMatchesTableView: UITableView!
    
    //var allMtchesProtocol : AllMatches
    //var venues = [Venues]()
    var parentDecodedArray = [Categories]()
    var childDecodedDta = [childrenData]()
    let context = AppDelegate().persistentContainer.viewContext
    var boolVal : Bool = true
    var tableArray = [VenueEntity]()
    
   
//    init?(coder aDecoder: NSCoder,allamatchesProtocol :AllMatches ) {
//           self.allMtchesProtocol = allamatchesProtocol
//           super.init(coder: aDecoder)
//       }
//
//       required init?(coder aDecoder: NSCoder) {
//          // self.allMtchesProtocol = AllMatchesAPiManager()
//           super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allMatchesTableView.delegate = self
        allMatchesTableView.dataSource = self
        allMatchesTableView.register(UINib(nibName: "AllMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllMatchesTableViewCell")
        self.fetchDecodedChildParentJson()
        //self.makeAllMathesApiCall()
        //self.getAllMatchee()
        
    }
    

    @IBAction func menuTapped(_ sender: Any) {
        if let vc = self.revealViewController(){
            vc.revealToggle(menuItem)
            vc.panGestureRecognizer()
            vc.rearViewRevealWidth = 300
            
        }
    }
    
 func fetchDecodedChildParentJson(){
    var childParentUrl = "https://www.emaxme.com/api1/category.php?lang=s001"
          Alamofire.request(childParentUrl).responseJSON { (response) in

                 switch response.result {
                 case .success:
                     if((response.result) != nil) {
                         let dataJson = response.data

                         do{
                         let root = try JSONDecoder().decode(NewRootModel.self, from: dataJson!)
                          print("root is :\(root.categories)")
                          var cat = root.categories
                          for category in cat{
                              self.parentDecodedArray.append(category)
                            self.allMatchesTableView.reloadData()
                              
                              for child in category.children_data{
                                  self.childDecodedDta.append(child)
                                self.allMatchesTableView.reloadData()

                              }
                          }
                         self.allMatchesTableView.reloadData()

                          print("parent array count :\(self.parentDecodedArray.count)")
                          print("child decode data count is :\(self.childDecodedDta.count)")
                         }catch {
                             print("Error: \(error)")
                         }

                     }
                 case .failure(let error):
                     print(error)
                 }
             }
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentDecodedArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllMatchesTableViewCell", for: indexPath) as! AllMatchesTableViewCell
           var venueObj = parentDecodedArray[indexPath.row]
           cell.nameLbl.text = venueObj.name
          cell.addressLbl.text = String(venueObj.parent_id)
        if self.checkVenueExists(name: venueObj.name) == true{
            cell.saveBtn.setTitle("Unsave", for: .normal)
        }else{
             cell.saveBtn.setTitle("Save", for: .normal)
        }
           cell.saveBtn.addTarget(self, action: #selector(didTappedDeleteBun(sender:)), for: .touchUpInside)
        return cell
     }
    
    @objc private func didTappedDeleteBun(sender:UIButton){
        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: self.allMatchesTableView)
        if let index = self.allMatchesTableView.indexPathForRow(at: buttonPosition){
            print("button tapped index = \(index)")
            let name = parentDecodedArray[index.row].name ?? ""
            if checkVenueExists(name: name) == true{
                self.deleteFeed(name: name)
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
            }else{
                //MARK: save code
                parentDecodedArray[index.row].isSaved = true
                let venuresObj = parentDecodedArray[index.row]
                let e1 = NSEntityDescription.insertNewObject(forEntityName: "VenueEntity", into: self.context) as! VenueEntity
                e1.name = venuresObj.name
                e1.address = String(venuresObj.parent_id)
                e1.savedUnsaved = true
                sender.setTitle("Unsave", for: .normal)
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Error While inserting Note: \(error.userInfo)")
                }
            }
            self.allMatchesTableView.reloadRows(at: [index], with: .automatic)
            
        }
    }
    
    func deleteFeed(name:String){
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext
        let contxt = managedObjectContext
        let managedContext = contxt
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"VenueEntity")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "\(name)")
        do{
            let fetchedResults =  try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            for entity in fetchedResults! {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                context.delete(entity)
                do{
                    try context.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
            }
        }
        catch _ {
            print("Could not delete")
        }
    }
    
    func checkVenueExists(name:String) -> Bool{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "VenueEntity")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        var results: [NSManagedObject] = []
        do {
            results = try context.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }

}


class NewRootModel : Decodable {
    var success : String
    var categories : [Categories]
}

class Categories:Decodable {
    var id : Int = 0
    var parent_id : Int = 0
    var name : String = ""
    var is_active : Bool = false
    var position : Int = 0
    var level : Int = 0
    var product_count : Int = 0
    var children_data : [childrenData]
    var isSaved : Bool?
    
}
class childrenData: Decodable{
    var id : Int = 0
    var parent_id : Int = 0
    var name : String = ""
    var is_active : Bool = false
    var position : Int = 0
    var level : Int = 0
    var product_count : Int = 0
}

