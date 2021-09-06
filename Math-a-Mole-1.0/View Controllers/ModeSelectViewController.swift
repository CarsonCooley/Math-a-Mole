//
//  WelcomeViewConntroller.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 8/5/21.
//

import UIKit

class ModeSelectViewController: UIViewController {
    
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
    
    var activeDifficultySelected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.alpha = 0.0
        
        difficultyButtons = [beginnerButton, intermediateButton, advancedButton, expertButton]
        for button in difficultyButtons {
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
        }
        
        nextButton.layer.cornerRadius = 10
        nextButton.clipsToBounds = true
        navigationController?.navigationBar.tintColor = UIColor.white
        
        views = [topView, middleView, bottomView]
        for view in views {
            view.backgroundColor = UIColor.clear
        }
        
        descriptionLabel.text = ""
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        nextButton.isHidden = true
        descriptionLabel.text = ""
        for button in difficultyButtons {
            button.alpha = 1.0
        }
    }
    
    @IBAction func difficultySelected(_ sender: UIButton) {
        nextButton.isHidden = false
        nextButton.alpha = 1.0
        for button in difficultyButtons {
            button.alpha = 0.33
        }
        sender.alpha = 1.0
        activeDifficultySelected = sender.currentTitle!
        self.updateDescriptionLabel()
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.advanceToGamePlay, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameplayViewController
        vc.gameDifficulty = self.activeDifficultySelected
    }
    
    func updateDescriptionLabel() {
        if self.activeDifficultySelected == "Beginner" {
            self.descriptionLabel.text = K.Descriptions.beginner
        } else if self.activeDifficultySelected == "Intermediate" {
            self.descriptionLabel.text = K.Descriptions.intermediate
        } else if self.activeDifficultySelected == "Advanced" {
            self.descriptionLabel.text = K.Descriptions.advanced
        } else if self.activeDifficultySelected == "Expert" {
            self.descriptionLabel.text = K.Descriptions.expert
        }
    }
    
}
