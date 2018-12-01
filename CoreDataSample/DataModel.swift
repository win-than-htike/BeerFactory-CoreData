//
//  DataModel.swift
//  CoreDataSample
//
//  Created by Win Than Htike on 11/26/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import Foundation
import CoreData

class DataModel {
    
    private init() {}
    
    private static var sharedDataModel: DataModel = {
        let dataModel = DataModel()
        return dataModel
    }()
    
    public static let shared : DataModel = {
        return sharedDataModel
    }()
    
    func getBeers(success : @escaping ([Beers]) -> Void, context : NSManagedObjectContext) {
        
        NetworkManager.shared.getData(success: { (beerList) in
            
            beerList.forEach({ (beerVO) in
                
                var maltId = [String]()
                
                var hopsId = [String]()
                
                var ingredientId = ""
                
                if let ingredients = beerVO.ingredients {
                    
                    if let malts = ingredients.malt {
                        
                        maltId = MaltsVO.save(maltList: malts, context: context)
                        
                    }
                    
                    if let hops = ingredients.hops {
                        
                        hopsId = HopsVO.save(hopsList: hops, context: context)
                        
                    }
                    
                    ingredientId = IngredientsVO.save(ingredients: ingredients, hopsId: hopsId, maltId: maltId, context: context)
                    
                }
                
                BeerVO.save(beer: beerVO, ingredientId: ingredientId, context: context)
                
                DispatchQueue.main.async {
                
                    let beerList = BeerVO.get(context: context)
                    
                    success(beerList)
                    
//                    beerList.forEach({ (beer) in
//
//                        let beerVO = BeerVO()
//
//                        let ingredient = IngredientsVO.get(ingredientId: beer.ingredient_id ?? "", context: context)
//
//                        let hopsList = HopsVO.get(hopsIdList: ingredient.hops_id ?? [String](), context: context)
//
//
//                        let maltList = MaltsVO.get(maltIdList: maltId, context: context)
//
//                    })
                    
                }
                
                
            })
            
            
            
        }) { (msg) in
            
        }
        
    }
    
    func getIngredientById(ingredientId : String, context : NSManagedObjectContext) -> Ingredients {
        
        return IngredientsVO.get(ingredientId: ingredientId, context: context)
        
    }
    
    func getMaltListById(maltIdList : [String], context : NSManagedObjectContext) -> [Malt] {
        
        return MaltsVO.get(maltIdList: maltIdList, context: context)
        
//        maltListFromDb.forEach { (malt) in
//
//            let maltVO = MaltsVO()
//            maltVO.id = malt.id ?? ""
//            maltVO.name = malt.name
//            maltList.append(maltVO)
//
//        }
//
//        return maltList
        
    }
    
    func getHopsListById(hopIdList : [String], context : NSManagedObjectContext) -> [Hops] {
        
        return HopsVO.get(hopsIdList: hopIdList, context: context)
        
    }
    
}
