//
//  CharacterDetailViewController.swift
//  SWAPISolo
//
//  Created by Austin Goetz on 9/25/20.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    
    // MARK: - Properties
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - Helpers
    func updateViews() {
        if let character = character {
            heightLabel.text = character.height
            weightLabel.text = character.mass
            hairColorLabel.text = character.hairColor
            self.title = character.name
        } else {
            presentErrorAlert()
        }
    }
    
    func presentErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Something Went Wrong \nPlease Try Again", preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}
