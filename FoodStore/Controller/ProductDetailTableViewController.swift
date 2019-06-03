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
            CostLabel?.text = "\(cost) ₽"
        }
    }
    @IBOutlet weak var WeightLabel: UILabel!{
        didSet {
            let weight = product?.Weight ?? 0.0
            let unit = product?.Unit ?? ""
            WeightLabel?.text = "\(weight) \(unit)"
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
