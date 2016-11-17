//
//  ViewController.swift
//  PokeDex
//
//  Created by Darshan Gowda on 02/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var serachView: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    
    var isSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        serachView.delegate = self
        serachView.returnKeyType = UIReturnKeyType.done
        
        parseCSV()
        initAudio()
    }
    
    func initAudio(){
        
        do{
        
            let path = Bundle.main.path(forResource: "music", ofType: "mp3")
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            
            musicPlayer.prepareToPlay();
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        
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
        
        if(isSearchMode){
            return filteredPokemons.count
        }
        
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            if isSearchMode{
                cell.configureCell(filteredPokemons[indexPath.row])
            }else{
                cell.configureCell(pokemons[indexPath.row])
            }
            
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying{
            sender.alpha = 0.2
            musicPlayer.pause()
        }else{
            sender.alpha = 1.0
            musicPlayer.play()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if serachView.text == nil || serachView.text == ""{
            isSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        }else{
            isSearchMode = true
            
            
            let typedString = serachView.text?.lowercased()
            filteredPokemons = pokemons.filter({($0.name.range(of: typedString!) != nil)})
            
            collectionView.reloadData()
            
        }
        
    }
    
    
}

