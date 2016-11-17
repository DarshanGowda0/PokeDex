//
//  ViewController.swift
//  PokeDex
//
//  Created by Darshan Gowda on 02/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        parseCSV()
        
    }
    
    func parseCSV(){
    
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
        
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                
                let pokeId = Int(row["id"]!)
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexID: pokeId!)
                pokemons.append(poke)
                
            }
            
            
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            cell.configureCell(pokemons[indexPath.row])
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    
}

