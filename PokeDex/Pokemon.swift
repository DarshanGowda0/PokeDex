//
//  Pokemon.swift
//  PokeDex
//
//  Created by Darshan Gowda on 17/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{

    private var _name : String!
    private var _pokedexId : Int!
    private var _description:String!
    private var _type:String!
    private var _defence:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvo:String!
    private var _nextEvoID:String!
    private var _nextEvoLevel:String!
    private var _nextEvoName:String!
    private var _pokemonURL:String!
    
    var name:String{
        return _name
    }
    
    var pokedexId:Int{
        return _pokedexId
    }
    
    var description : String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type : String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defence : String{
        if _defence == nil{
            _defence = ""
        }
        return _defence
    }
    
    var height : String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight : String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }

    var attack : String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvo : String{
        if _nextEvo == nil{
            _nextEvo = ""
        }
        return _nextEvo
    }
    
    var nextEvoName : String{
        if _nextEvoName == nil{
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoLevel : String{
        if _nextEvoLevel == nil{
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    var nextEvoID : String{
        if _nextEvoID == nil{
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    
    
    init(name : String,pokedexID : Int){
        self._name = name
        self._pokedexId = pokedexID
        self._pokemonURL = "\(BASE_URL)\(POKE_URL)\(self._pokedexId!)/"
        
    }
    
    func downloadPokemonDetail(completed : @escaping DownloadComplete) {

        Alamofire.request(self._pokemonURL).responseJSON { (response) in

            if let dict = response.result.value as? Dictionary<String,AnyObject>{
            
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defence = dict["defense"] as? Int{
                    self._defence = "\(defence)"
                }
                
                if let types = dict["types"] as? [Dictionary<String,String>] , types.count > 0{
                    
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1{
                        for x in 1..<types.count{
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalized)"
                            }
                            
                        }
                    }
                    
                }else{
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>], descArr.count > 0{
                    
                    if let url = descArr[0]["resource_uri"]{
                        let descURL = "\(BASE_URL)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String,AnyObject>{
                                if let description = descDict["description"] as? String{
                                    let newDesc = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDesc
                                }
                            }
                            completed()
                        })
                        
                    }
                    
                }else{
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>],evolutions.count > 0{
                    
                    if let nextEvo = evolutions[0]["to"] as? String{
                        
                        if nextEvo.range(of: "mega") == nil{
                            self._nextEvoName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newString = uri.replacingOccurrences(of: "api/v1/pokemon", with: "")
                                let nextEvoID = newString.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoID = nextEvoID
                                
                                if let lvlExist = evolutions[0]["level"]{
                                    if let lvl = lvlExist as? Int{
                                        self._nextEvoLevel = "\(lvl)"
                                    }
                                }else{
                                    self._nextEvoLevel = ""
                                }
                            }
                        }
                        
                    }
                    
                }
                
            }
            
            completed()
        
        }
        
    }
}
