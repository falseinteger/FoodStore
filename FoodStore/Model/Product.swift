//
//  Product.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 30/05/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import Foundation

struct Product {
    
    var Id:Int
    var NameProduct: String
    var ImageString: String?
    
    var Weight: Int
    var Unit: WeightType
    
    var Cost: Double
    
}

extension ProductCart {
    
    func GetNotificationOfProduct() -> NotificationInfo {
        let productName = self.product == nil ? "product" : self.product!.NameProduct
        
        let message =
         self.count <= 1 ?
        "You added \(productName)" :
        "You added \(productName)\nwith pieces count: \(self.count)"
        
        return NotificationInfo(
            Title: message,
            ImageString: "CartAdd"
        )
    }
}
