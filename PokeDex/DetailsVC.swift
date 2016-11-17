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

    @IBOutlet weak var labelView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if pokemon != nil{
            print(pokemon.name)
            labelView.text = pokemon.name
        }
        
    }

}
