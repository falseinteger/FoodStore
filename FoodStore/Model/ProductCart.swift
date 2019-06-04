//
//  ProductCart.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 03/06/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import Foundation

struct ProductCart {
    
    var nameProduct:String
    var count:Int
    lazy var productInfo: Product? = {
        return DataService.shared().SearchProductByNameProduct(nameProduct)
    }()
}
