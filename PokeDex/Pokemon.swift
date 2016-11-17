//
//  Pokemon.swift
//  PokeDex
//
//  Created by Darshan Gowda on 17/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import Foundation

class Pokemon{

    var _name : String!
    var _pokedexId : Int!
    
    var name:String{
        return _name
    }
    
    var pokedexId:Int{
        return _pokedexId
    }
    
    
    init(name : String,pokedexID : Int){
        self._name = name
        self._pokedexId = pokedexID
    }
}
