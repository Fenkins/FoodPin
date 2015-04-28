//
//  Restaurant.swift
//  FoodPin
//
//  Created by Fenkins on 23/04/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import Foundation


class Restaurant {
    var name:String = ""
    var type:String = ""
    var location:String = ""
    var image:String = ""
    var phone:String = ""
    var isVisited:Bool = false
    
    init(name:String, type:String, location:String, image:String, phone:String, isVisited:Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.isVisited = isVisited
    }
}