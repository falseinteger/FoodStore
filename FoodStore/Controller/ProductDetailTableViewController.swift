//
//  ProductDetailTableViewController.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 03/06/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import UIKit

class ProductDetailTableViewController: UITableViewController {

    @IBOutlet weak var ProductImageView: UIImageView! {
        didSet {
            let image = product?.ImageString ?? "no-image"
            ProductImageView?.image = UIImage(named: image)
        }
    }
    @IBOutlet weak var TitleLabel: UILabel!{
        didSet {
            let title = product?.NameProduct ?? "No name"
            self.title = "\(title)"
            TitleLabel?.text = "\(title)"
        }
    }
    @IBOutlet weak var CostLabel: UILabel!{
        didSet {
            let cost = product?.Cost ?? 0
            CostLabel.text = cost <= 0 ? "Free" : String(format: "$ %.02f", cost)
        }
    }
    @IBOutlet weak var WeightTextLabel: UILabel! {
        didSet {
            let unit = product?.Unit ?? .none
            switch unit {
            case .pieces:
                WeightTextLabel?.text = "Pieces"
            case .g, .ml:
                WeightTextLabel?.text = "Weight"
            default:
                WeightTextLabel?.text = "Total"
            }
        }
    }
    @IBOutlet weak var WeightLabel: UILabel!{
        didSet {
            let weight = product?.Weight ?? 0
            let unit = product?.Unit ?? .none
            switch unit {
                case .pieces:
                    WeightLabel?.text = "\(weight)"
                case .g, .ml:
                    WeightLabel?.text = "\(weight)" + (unit == .none ? "" : " \(unit).")
                default:
                    WeightTextLabel?.text = "Total"
                    WeightLabel?.text = "\(weight)"
            }
        }
    }
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var AddToCartButton: UIButton!
    
    public var product:Product?
    
    var currentCount:Int = 1 {
        didSet {
            if currentCount > 99 {
                CountLabel.text = "99+"
            } else {
                CountLabel.text = "\(currentCount)"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        InitButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func InitButton() {
        AddToCartButton.layer.masksToBounds = true
        AddToCartButton.layer.cornerRadius = 8
    }
    
    // MARK: - Action on view
    @IBAction func CountStepping(_ sender: UIStepper) {
        currentCount = Int(sender.value)
    }
    
    @IBAction func AddToCart(_ sender: UIButton) {
        
        guard let addProduct = product else {
            assert(false, "Invalid element data")
            return
        }
        
        let newProductCart = ProductCart(Id: addProduct.Id, count: currentCount)
        CartService.shared().listCart?.append(newProductCart)
        #if DEBUG
        print("[Cart] add new product id: \(addProduct.Id), count: \(currentCount)")
        #endif
        
        let info = newProductCart.GetNotificationOfProduct()
        
        NotificationUIView.NotifiMe(model: info)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
