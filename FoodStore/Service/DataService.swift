//
//  DataService.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 30/05/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import Foundation

class DataService {
    
    private static var uniqueInstance: DataService?
    
    lazy var categories: [CategoryInfo] = {
        return [
            CategoryInfo(Id: "Burgers", Name: "Tasty burger"),
            CategoryInfo(Id: "Potato", Name: "Hot potato"),
            CategoryInfo(Id: "Drinks", Name: "Cold drinks and Coffee"),
            CategoryInfo(Id: "Other", Name: "It's need take too")
        ]
    }()
    
    lazy var products: [String: [Product]?] = {
        return [
            "Burgers" : [
                Product(Id: 0, NameProduct: "Burger classic", ImageString: nil, Weight: 200, Unit: .g, Cost: 2.0),
                Product(Id: 1, NameProduct: "Burger cheese land", ImageString: nil, Weight: 350, Unit: .g, Cost: 3.5),
                Product(Id: 2, NameProduct: "Burger big father", ImageString: nil, Weight: 400, Unit: .g, Cost: 5.9),
            ],
            "Potato" : [
                Product(Id: 3, NameProduct: "Potato classic", ImageString: nil, Weight: 150, Unit: .g, Cost: 1.0),
                Product(Id: 4, NameProduct: "Potato extra", ImageString: nil, Weight: 250, Unit: .g, Cost: 2.0)
            ],
            "Drinks" : [
                Product(Id: 5, NameProduct: "Coca-cola", ImageString: nil, Weight: 300, Unit: .ml, Cost: 0.89),
                Product(Id: 6, NameProduct: "Sprite", ImageString: nil, Weight: 300, Unit: .ml, Cost: 0.89),
                Product(Id: 7, NameProduct: "Fanta", ImageString: nil, Weight: 300, Unit: .ml, Cost: 0.89),
                Product(Id: 8, NameProduct: "Evian", ImageString: nil, Weight: 250, Unit: .ml, Cost: 1.20),
                Product(Id: 9, NameProduct: "Orange juice", ImageString: nil, Weight: 250, Unit: .ml, Cost: 2.79),
                Product(Id: 10, NameProduct: "Apple juice", ImageString: nil, Weight: 250, Unit: .ml, Cost: 2.99),
                Product(Id: 11, NameProduct: "Pinapple juice", ImageString: nil, Weight: 250, Unit: .ml, Cost: 2.79),
                Product(Id: 12, NameProduct: "Tea", ImageString: nil, Weight: 250, Unit: .ml, Cost: 1.99),
                Product(Id: 13, NameProduct: "Coffee Classic", ImageString: nil, Weight: 200, Unit: .ml, Cost: 1.99),
                Product(Id: 14, NameProduct: "Coffee Latte", ImageString: nil, Weight: 200, Unit: .ml, Cost: 1.99),
                Product(Id: 15, NameProduct: "Coffee Cappuccino", ImageString: nil, Weight: 200, Unit: .ml, Cost: 2.99),
            ],
            "Other" : [
                Product(Id: 16, NameProduct: "wet wipe", ImageString: nil, Weight: 1, Unit: .pieces, Cost: 0)
            ]
        ]
    }()

    // Mark - Search product
    func SearchProductBy(_ Id:Int) -> Product? {
        
        for category in products {
            guard let value = category.value?.first(where: { (product) -> Bool in
                return product.Id == Id
            }) else { continue }
            return value
        }
        
        guard let items = Array(products.values)[0] else { return nil }
        return items.first(where: { (product) -> Bool in
            return product.Id == Id
        })
    }
    
    // Mark - Search list products
    func SearchProductsBy(_ searchText:String) -> (newCategory:[CategoryInfo], newProduct:[String: [Product]?]) {
        var cacheSearchProduct: [String: [Product]?] = [:]
        for category in products {
            guard let values = category.value?.filter({ (product) -> Bool in
                return product.NameProduct.lowercased().contains(searchText.lowercased())
            }) else { continue }
            cacheSearchProduct.updateValue(values, forKey: category.key)
        }
        var cacheSearchCategoryInfo: [CategoryInfo] = []
        for key in cacheSearchProduct.keys {
            guard let newValue = categories.first(where: { (categoryInfo) -> Bool in
                categoryInfo.Id == key
            }) else { continue }
            // double unwrap :/
            guard let data = cacheSearchProduct[key], let values = data else { continue }
            if values.count <= 0 { continue }
            cacheSearchCategoryInfo.append(newValue)
        }
        return  (cacheSearchCategoryInfo , cacheSearchProduct)
    }
    
    private init() { }
    
    static func shared() -> DataService {
        if uniqueInstance == nil {
            uniqueInstance = DataService()
        }
        return uniqueInstance!
    }
}
