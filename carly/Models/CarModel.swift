//
//  CarModel.swift
//  carly
//
//  Created by Alexander Murphy on 10/22/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import SwiftyJSON

class CarModel {
    static func getAllCars() -> JSON?  {
        if let path = Bundle.main.path(forResource: "vehicles", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    //print("jsonData:\(jsonObj)")
                    return jsonObj
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
