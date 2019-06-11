//
//  ProductCart.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 03/06/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import Foundation

struct ProductCart {
    
    var Id:Int
    var count:Int
    var product: Product? {
        get {
            return DataService.shared().SearchProductBy(Id)
        }
    }
}
