//
//  ItemCatalogHeaderCollectionReusableView.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 31/05/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import UIKit

class ItemCatalogHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    var categoryInfo: CategoryInfo? {
        didSet {
            TitleLabel.text = categoryInfo?.Name ?? "no category name"
        }
    }
    
}
