//
//  MatchedWordsViewController.swift
//  ScrabbleCheatApp
//
//  Created by Jody Abney on 6/5/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class MatchedWordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Properties
    var matchedWords: [(String, Int)] = []
    

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        // sort: points descending. word ascending
        matchedWords.sort { (lhsWord: (String, Int), rhsWord: (String, Int)) in
            // if points aren't equal then just sort on points
            if lhsWord.1 != rhsWord.1 {
                return lhsWord.1 > rhsWord.1
            } else { // sort on words ascending if points are equal
                return lhsWord.0 < rhsWord.0
            }
        }
    }
    
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matchedWords.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchedWordCell", for: indexPath)
        // configure the cell contents
        let matchedWord = matchedWords[indexPath.row]
        cell.textLabel?.text = matchedWord.0
        cell.detailTextLabel?.text = String(matchedWord.1)
        return cell
    }
}
