//
//  WelcomeViewConntroller.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 8/5/21.
//

import UIKit

class WelcomeViewConntroller: UIViewController {
    
    @IBOutlet weak var beginnerButton: UIButton!
    @IBOutlet weak var intermediateButton: UIButton!
    @IBOutlet weak var advancedButton: UIButton!
    @IBOutlet weak var expertButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var difficultyButtons: [UIButton] = []
    var views: [UIView] = []
    
    var activeDifficultySelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemTeal
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.brown]
        nextButton.alpha = 0.0
        difficultyButtons = [beginnerButton, intermediateButton, advancedButton, expertButton]
        views = [topView, middleView, bottomView]
        for view in views {
            view.backgroundColor = UIColor.clear
        }
        descriptionLabel.text = ""
    }
    
    @IBAction func difficultySelected(_ sender: UIButton) {
        nextButton.alpha = 1.0
        for button in difficultyButtons {
            button.alpha = 0.33
        }
        sender.alpha = 1.0
        activeDifficultySelected = sender.currentTitle!
        self.updateDescriptionLabel()
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "AdvanceToGameplay", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameViewController
        vc.gameDifficulty = self.activeDifficultySelected
    }
    
    func updateDescriptionLabel() {
        if self.activeDifficultySelected == "Beginner" {
            self.descriptionLabel.text = "Whack some moles with some small addition and subtraction! Just 30 seconds."
        } else if self.activeDifficultySelected == "Intermediate" {
            self.descriptionLabel.text = "Step it up with some larger numbers. A full minute of mole-whacking fun!"
        } else if self.activeDifficultySelected == "Advanced" {
            self.descriptionLabel.text = "Switch it up to some multiplication and division mole-whacking. A full minute of mole-whacking fun!"
        } else if self.activeDifficultySelected == "Expert" {
            self.descriptionLabel.text = "Additon. Subtraction. Multiplication. Division. How many moles can you whack in 90 seconds?"
        }
    }
    
}
