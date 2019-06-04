//
//  CatalogViewController.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 30/05/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    var categories = DataService.shared().categories
    var products = DataService.shared().products
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var ContentCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ContentCollectionView.dataSource = self
        ContentCollectionView.delegate = self
        SearchBar.delegate = self
    }
    
    // MARK - SearchText
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("[searchBar] searchBarSearchButtonClicked")
        guard let searchText:String = searchBar.text else { return }
        let newFindElements = DataService.shared().SearchProductsByText(searchText)
        self.SetItems(newCategories: newFindElements.newCategory, newProducts: newFindElements.newProduct)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)  {
        print("[searchBar] searchText: \(searchText)")
        let newFindElements = DataService.shared().SearchProductsByText(searchText)
        self.SetItems(newCategories: newFindElements.newCategory, newProducts: newFindElements.newProduct)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("[searchBar] searchBarCancelButtonClicked")
        self.SetItems(newCategories: DataService.shared().categories, newProducts: DataService.shared().products)
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("[searchBar] searchBarTextDidBeginEditing")
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)  {
        print("[searchBar] searchBarTextDidEndEditing")
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // MARK -  Search text controller
    private func SetItems(newCategories:[CategoryInfo], newProducts:[String: [Product]?] ) {
        print("[SetItems] new items")
        if newProducts.values.count <= 0 {
            categories = DataService.shared().categories
            products = DataService.shared().products
        }
        else {
            categories = newCategories
            products = newProducts
        }
        ContentCollectionView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductDetail" {
            if let cell = sender as? ItemCatalogCollectionViewCell {
                if let vc = segue.destination as? ProductDetailTableViewController {
                    vc.product = cell.product
                }
            }
        }
    }
 
    
    // MARK: - CollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let key = categories[section]
        guard let array = products[key.Id]  else { return 0 }
        
        return array?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let cellHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CatalogHeader", for: indexPath) as? ItemCatalogHeaderCollectionReusableView {
            
                let categoryInfo = categories[indexPath.section]
                
                cellHeader.categoryInfo = categoryInfo
                
                return cellHeader
            }
            return UICollectionReusableView();
        default:
             assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cellProduct = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogDefault", for: indexPath) as? ItemCatalogCollectionViewCell {
            
            let key = categories[indexPath.section]
            guard let product = products[key.Id]??[indexPath.row] else { return cellProduct }
            
            cellProduct.product = product
            
            return cellProduct
        }
        
        // no find cell
        return UICollectionViewCell()
    }

}
