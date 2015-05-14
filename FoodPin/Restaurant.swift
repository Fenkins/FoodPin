//
//  Restaurant.swift
//  FoodPin
//
//  Created by Fenkins on 23/04/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import Foundation
import CoreData


class Restaurant:NSManagedObject {
    @NSManaged var name:String!
    @NSManaged var type:String!
    @NSManaged var location:String!
    @NSManaged var image:NSData!
    @NSManaged var phone:String!
    @NSManaged var isVisited:NSNumber!
}