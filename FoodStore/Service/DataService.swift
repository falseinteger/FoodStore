//
//  DataService.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 30/05/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import Foundation

public class DataService {
    
    private static var uniqueInstance: DataService?
    
    lazy var categories: [CategoryInfo] = {
        return [
            CategoryInfo(Id: "Burgers", Name: "Tasty burger"),
            CategoryInfo(Id: "Drinks", Name: "Cold drinks and Coffee")
        ]
    }()
    lazy var products: [String: [Product]?] = {
        return [
            "Burgers" : [
                Product(NameProduct: "Burger Classic", ImageString: nil, Weight: 200, Unit: "gr.", Cost: 250),
                Product(NameProduct: "Burger Cheese Land", ImageString: nil, Weight: 350, Unit: "gr.", Cost: 340),
                Product(NameProduct: "Burger Big Father", ImageString: nil, Weight: 400, Unit: "gr.", Cost: 750),
            ],
            "Drinks" : [
                Product(NameProduct: "Coca-cola", ImageString: nil, Weight: 0.3, Unit: "ml.", Cost: 120),
                Product(NameProduct: "Sprite", ImageString: nil, Weight: 0.3, Unit: "ml.", Cost: 120),
                Product(NameProduct: "Fanta", ImageString: nil, Weight: 0.3, Unit: "ml.", Cost: 120),
                Product(NameProduct: "Evian", ImageString: nil, Weight: 0.25, Unit: "ml.", Cost: 200),
                Product(NameProduct: "Orange juice", ImageString: nil, Weight: 0.25, Unit: "ml.", Cost: 450),
                Product(NameProduct: "Apple juice", ImageString: nil, Weight: 0.25, Unit: "ml.", Cost: 500),
                Product(NameProduct: "Pinapple juice", ImageString: nil, Weight: 0.25, Unit: "ml.", Cost: 550),
                Product(NameProduct: "Tea", ImageString: nil, Weight: 0.25, Unit: "ml.", Cost: 150),
                Product(NameProduct: "Coffee Classic", ImageString: nil, Weight: 0.2, Unit: "ml.", Cost: 200),
                Product(NameProduct: "Coffee Latte", ImageString: nil, Weight: 0.2, Unit: "ml.", Cost: 250),
                Product(NameProduct: "Coffee Cappuccino", ImageString: nil, Weight: 0.2, Unit: "ml.", Cost: 300),
            ]
        ]
    }()
    
    private init() { }
    
    static func shared() -> DataService {
        if uniqueInstance == nil {
            uniqueInstance = DataService()
        }
        return uniqueInstance!
    }
}
