//
//  ItemDefaultCollectionViewCell.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 30/05/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import UIKit

class ItemCatalogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NameProductLabel: UILabel!
    @IBOutlet weak var CostDisplayLabel: UILabel!
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 4.0
    
    var product: Product? {
        didSet {
            guard let item:Product = product else { return }
            NameProductLabel.text = "\(item.NameProduct)\n\(item.Weight) \(item.Unit)."
            CostDisplayLabel.text = "\(item.Cost) ₽"
            let image = product?.ImageString ?? "no-image"
            ImageView.image = UIImage(named: image)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true;
        
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.2)
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 6.0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
    
}
