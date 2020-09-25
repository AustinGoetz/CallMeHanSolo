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
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Star Wars"
        characterIDSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let characterToDisplay = character else { return UITableViewCell() }
        cell.textLabel?.text = characterToDisplay.name
        cell.detailTextLabel?.text = characterToDisplay.gender
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        // I: Identifier
        if segue.identifier == "toDetailVC" {
            // D: Destination
            guard let destinationVC = segue.destination as? CharacterDetailViewController else { return }
            // O: Object to send
            let characterToSend = character
            // O: receive Object
            destinationVC.character = characterToSend
        }
    }
    
    
    // MARK: - Helpers
    func fetch(_ id: Int) {
        CharacterController.fetchCharacterBy(id: id) { (result) in
            switch result {
            case .success(let character):
                self.character = character
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
        guard let characterID = characterIDSearchBar.text, !characterID.isEmpty else { return }
        let idAsInt = Int(characterID) ?? 0
        fetch(idAsInt)
    }
}
