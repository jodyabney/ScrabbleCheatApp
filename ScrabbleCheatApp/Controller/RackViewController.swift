//
//  RackViewController.swift
//  ScrabbleCheatApp
//
//  Created by Jody Abney on 6/5/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class RackViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    

    
    //MARK: - Properties
    
    // the brain of the Scrabble game
    var scrabbleBrain = ScrabbleBrain()

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // set the scrabble brain and pick the player tiles
        scrabbleBrain.setup()
    }
    
    //MARK: - Instance Methods
    
    func restart() {
        // pick the player tiles from the bag
        scrabbleBrain.getPlayerTiles()
    }
    
    //MARK: - IBActions
    
    @IBAction func restartTapped(_ sender: RoundButton) {
        restart()
        tableView.reloadData()
    }
    
    @IBAction func cheatTapped(_ sender: RoundButton) {
        scrabbleBrain.createSearchGroup()
        scrabbleBrain.findWordMatches()
    }
    
    

    //MARK: - Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scrabbleBrain.playerTiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTileCell", for: indexPath)

        cell.textLabel?.text = scrabbleBrain.playerTiles[indexPath.row].letter
        cell.detailTextLabel?.text = String(scrabbleBrain.playerTiles[indexPath.row].pointValue)

        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let matchedWordTVC = segue.destination as? MatchedWordsViewController {
            matchedWordTVC.matchedWords = scrabbleBrain.matchedWords
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

