//
//  WelcomeViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 9/3/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var howToPlayLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var viewFCButton: UIButton!
    @IBOutlet weak var howToPlayButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    var buttons: [UIButton] = []
    var dataPersistantFlashcards: [Flashcard] = []
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        navigationController?.setNavigationBarHidden(true, animated: true)
        howToPlayLabel.isHidden = true
        howToPlayLabel.text = K.Descriptions.howToPlay
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [playButton, viewFCButton, howToPlayButton, aboutButton]
        for button in buttons {
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        howToPlayLabel.isHidden = true
    }

    @IBAction func playPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.advanceToModeSelect, sender: self)
    }
    
    @IBAction func aboutPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.advanceToAbout, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CumulativeFCViewController {
            vc.dataPersistantFlashcards = self.dataPersistantFlashcards
        }
    }
    
    @IBAction func viewFlashcardsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.advanceStraightToFC, sender: self)
    }
    
    @IBAction func howToPlayPressed(_ sender: UIButton) {
        howToPlayLabel.isHidden = !howToPlayLabel.isHidden
    }
    
    
}
