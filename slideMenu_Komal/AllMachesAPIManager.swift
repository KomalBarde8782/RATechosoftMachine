//
//  AllMachesAPIManager.swift
//  slideMenu_Komal
//
//  Created by Komal Barde on 27/02/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import Foundation
import Alamofire
//class AllMatchesAPiManager : AllMatches {
//    func getAllMatches(completion: @escaping (Bool, String?, AllMatchesBase?) -> ()) {
//        let url = "https://api.foursquare.com/v2/venues/search?ll=40.7484,-73.9857&oauth_token=NPKYZ3WZ1VYMNAZ2FLX1WLECAWSMUVOQZOIDBN53F3LVZBPQ&v=20180616"
//        Alamofire.request(url).responseJSON { (response) in
//            
//            switch response.result {
//            case .success(let Json):
//                let res = Json as! NSDictionary
//                
////                if((response.result) != nil) {
////                    let dataJson = response.data
////
////                    do{
////                        let root = try JSONDecoder().decode(AllMatchesBase.self, from: dataJson!)
////                        let user = root.response
////                        print("root is :\(root.response)")
////                        completion(true,nil,root)
////
////                    }catch {
////                        print("Error: \(error)")
////                        completion(false,"Something Went Wrong",nil)
////                    }
////
////                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    
//    
//    
//    
//}

