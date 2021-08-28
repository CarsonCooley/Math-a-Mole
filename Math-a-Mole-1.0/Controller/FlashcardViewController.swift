//
//  FlashcardViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 8/11/21.
//

import UIKit

class FlashcardViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var views: [UIView] = []
    
    var flashcards: [Flashcard] = []
    var currentFlashcardIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateFlashcard(change: 0)
        views = [topView, bottomView]
    }
    
    @IBAction func flipPressed(_ sender: UIButton) {
        flashcards[currentFlashcardIndex].flip()
        self.updateFlashcard(change: 0)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        print(flashcards[currentFlashcardIndex].textShowing)
        updateFlashcard(change: 1)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        updateFlashcard(change: -1)
    }
    
    func updateFlashcard(change: Int) {
        if flashcards.count == 0 {
            questionLabel.text = "You Mathed ALL the Moles!"
            forwardButton.isHidden = true
            backButton.isHidden = true
            flipButton.isHidden = true
            progressLabel.isHidden = true
        }
        
        if (currentFlashcardIndex + change >= 0) && (currentFlashcardIndex + change < flashcards.count) {
            currentFlashcardIndex += change
            questionLabel.text = flashcards[currentFlashcardIndex].textShowing
            print(flashcards[currentFlashcardIndex].textShowing)
            progressLabel.text = "\(currentFlashcardIndex + 1) / \(flashcards.count)"
        }
    }
    
    @IBAction func homePressed(_ sender: UIButton) {
        flashcards.removeAll()
        performSegue(withIdentifier: "GoBackHome", sender: self)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! WelcomeViewConntroller
//
//    }
}
