//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Muhammad Moaz on 23/01/16.
//  Copyright © 2016 Moaz All rights reserved.
//

import UIKit
import SwiftSpinner

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var pokeNameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        SwiftSpinner.show("loading details...")
        
        pokeNameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
            SwiftSpinner.hide()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.pokemonDescription
        typeLbl.text = pokemon.pokemonType
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        attackLbl.text = pokemon.attack
        pokedexLbl.text = "\(pokemon.pokedexId)"
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            
            if pokemon.nextEvolutionLevel != "" {
                str += " - LVL \(pokemon.nextEvolutionLevel)"
            }
            evoLbl.text = str
        }  
    }

    @IBAction func backBtnTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
