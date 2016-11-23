//
//  DetailsVC.swift
//  PokeDex
//
//  Created by Darshan Gowda on 17/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    var pokemon : Pokemon!

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if pokemon != nil{
            
            mainLabel.text = pokemon.name.capitalized
            mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
            currentEvoImage.image = UIImage(named: "\(pokemon.pokedexId)")
            
            pokemon.downloadPokemonDetail {
                
                self.updateUI()
            }
        }
        
    }
    
    func updateUI() {
        
        
        typeLabel.text = pokemon.type
        defenceLabel.text = pokemon.defence
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        idLabel.text = "\(pokemon.pokedexId)"
        baseAttackLabel.text = pokemon.attack
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvoID == ""{
            evoLabel.text = "No Evolutions"
            nextEvoImage.isHidden = true
        }else{
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvoID)
            let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            
            evoLabel.text = str
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

}
