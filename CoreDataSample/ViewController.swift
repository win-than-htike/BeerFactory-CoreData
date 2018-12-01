//
//  ViewController.swift
//  CoreDataSample
//
//  Created by Win Than Htike on 11/25/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var beerListTableView: UITableView!
    
    var beerList : [Beers] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataModel.shared.getBeers(success: { (beerList) in
            
            self.beerList = beerList
            self.beerListTableView.reloadData()
            
        }, context: managedObjectContext)
        
    }


}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath) as! BeerTableViewCell
        
        let beer = self.beerList[indexPath.row]
        
        cell.name.text = beer.name ?? "Unknown"
        
        let ingredient = DataModel.shared.getIngredientById(ingredientId: beer.ingredient_id ?? "", context: managedObjectContext)
        
        cell.ingredient.text = ingredient.yeast ?? "Unknown"
        
        let maltList = DataModel.shared.getMaltListById(maltIdList: ingredient.malt_id ?? [String](), context: managedObjectContext)
        
        var malts = ""
        maltList.forEach { (malt) in
            
            malts.append("\(malt.name ?? "Unknown"),")
            
        }
        
        cell.malts.text = malts
        
        let hopsList = DataModel.shared.getHopsListById(hopIdList: ingredient.hops_id ?? [String](), context: managedObjectContext)
        
        var hops = ""
        hopsList.forEach { (hop) in
            
            hops.append("\(hop.name ?? "Unknown"),")
            
        }
        
        cell.hops.text = hops
        
        return cell
        
    }
    
    
}

extension ViewController : UITableViewDelegate {
    
}



