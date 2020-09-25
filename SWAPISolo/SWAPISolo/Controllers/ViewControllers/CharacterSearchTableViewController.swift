//
//  CharacterSearchTableViewController.swift
//  SWAPISolo
//
//  Created by Austin Goetz on 9/25/20.
//

import UIKit

class CharacterSearchTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var characterIDSearchBar: UISearchBar!
    
    // MARK: - Properties
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Star Wars"
        characterIDSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        let characterToDisplay = characters[indexPath.row]
        cell.textLabel?.text = characterToDisplay.name
        cell.detailTextLabel?.text = characterToDisplay.gender
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        // I: Identifier
        if segue.identifier == "toDetailVC" {
            // I: Index
            if let index = tableView.indexPathForSelectedRow {
                // D: Destination
                guard let destinationVC = segue.destination as? CharacterDetailViewController else { return }
                // O: Object to send
                let characterToSend = characters[index.row]
                // O: receive Object
                destinationVC.character = characterToSend
            }
        }
    }
    
    
    // MARK: - Helpers
    func fetch(name: String) {
        CharacterController.fetchCharacterWith(name: name) { (result) in
            switch result {
            case .success(let characters):
                self.characters = characters
                DispatchQueue.main.async {
                    self.tableView.reloadData()                    
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
}

// MARK: - Extensions
extension CharacterSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let characterName = characterIDSearchBar.text, !characterName.isEmpty else { return }
        
        fetch(name: characterName)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
}
