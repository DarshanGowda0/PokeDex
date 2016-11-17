//
//  PokeCell.swift
//  PokeDex
//
//  Created by Darshan Gowda on 17/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    
    var pokemon : Pokemon!
    
    func configureCell(pokemon : Pokemon){
        self.pokemon = pokemon;
        
        pokeName.text = pokemon.name
        pokeImage.image = UIImage(named: "\(pokemon.pokedexId)")
    }
}
