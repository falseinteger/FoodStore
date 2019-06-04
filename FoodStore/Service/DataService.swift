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
                Product(NameProduct: "Burger classic", ImageString: nil, Weight: 200, Unit: .g, Cost: 2.0),
                Product(NameProduct: "Burger cheese land", ImageString: nil, Weight: 350, Unit: .g, Cost: 3.5),
                Product(NameProduct: "Burger big father", ImageString: nil, Weight: 400, Unit: .g, Cost: 5.9),
            ],
            "Potato" : [
                Product(NameProduct: "Potato classic", ImageString: nil, Weight: 150, Unit: .g, Cost: 1.0),
                Product(NameProduct: "Potato extra", ImageString: nil, Weight: 250, Unit: .g, Cost: 2.0)
            ],
            "Drinks" : [
                Product(NameProduct: "Coca-cola", ImageString: nil, Weight: 300, Unit: .ml, Cost: 0.89),
                Product(NameProduct: "Sprite", ImageString: nil, Weight: 300, Unit: .ml, Cost: 0.89),
                Product(NameProduct: "Fanta", ImageString: nil, Weight: 300, Unit: .ml, Cost: 0.89),
                Product(NameProduct: "Evian", ImageString: nil, Weight: 250, Unit: .ml, Cost: 1.20),
                Product(NameProduct: "Orange juice", ImageString: nil, Weight: 250, Unit: .ml, Cost: 2.79),
                Product(NameProduct: "Apple juice", ImageString: nil, Weight: 250, Unit: .ml, Cost: 2.99),
                Product(NameProduct: "Pinapple juice", ImageString: nil, Weight: 250, Unit: .ml, Cost: 2.79),
                Product(NameProduct: "Tea", ImageString: nil, Weight: 250, Unit: .ml, Cost: 1.99),
                Product(NameProduct: "Coffee Classic", ImageString: nil, Weight: 200, Unit: .ml, Cost: 1.99),
                Product(NameProduct: "Coffee Latte", ImageString: nil, Weight: 200, Unit: .ml, Cost: 1.99),
                Product(NameProduct: "Coffee Cappuccino", ImageString: nil, Weight: 200, Unit: .ml, Cost: 2.99),
            ],
            "Other" : [
                Product(NameProduct: "wet wipe", ImageString: nil, Weight: 1, Unit: .pieces, Cost: 0)
            ]
        ]
    }()

    // Mark - Search product
    func SearchProductByNameProduct(_ NameProduct:String) -> Product? {
        
        guard let items = Array(products.values)[0] else { return nil }
        return items.first(where: { (product) -> Bool in
            return product.NameProduct == NameProduct
        })
    }
    
    // Mark - Search list products
    func SearchProductsByText(_ searchText:String) -> (newCategory:[CategoryInfo], newProduct:[String: [Product]?]) {
        var cacheSearchProduct: [String: [Product]?] = [:]
        for category in products {
            let values = category.value?.filter({ (product) -> Bool in
                return product.NameProduct.lowercased().contains(searchText.lowercased())
            })
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
