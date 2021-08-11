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
        nextButton.alpha = 0.0
        difficultyButtons = [beginnerButton, intermediateButton, advancedButton, expertButton]
        views = [topView, middleView, bottomView]
        for view in views {
            view.backgroundColor = UIColor.clear
        }
        descriptionLabel.text = "what in the fuck is even happening right now I have no idea if this app is even going to publish now"
    }
    
    @IBAction func difficultySelected(_ sender: UIButton) {
        nextButton.alpha = 1.0
        for button in difficultyButtons {
            button.alpha = 0.33
        }
        sender.alpha = 1.0
        activeDifficultySelected = sender.currentTitle!
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "AdvanceToGameplay", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameViewController
        vc.gameDifficulty = self.activeDifficultySelected
    }
    
}
