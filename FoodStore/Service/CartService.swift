//
//  CartService.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 03/06/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import Foundation

public class CartService {
    
    private static var uniqueInstance: CartService?
    
    private init() { }
    
    
    
    static func shared() -> CartService {
        if uniqueInstance == nil {
            uniqueInstance = CartService()
        }
        return uniqueInstance!
    }
}

