//
//  CumulativeFCViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 9/3/21.
//

import UIKit

class CumulativeFCViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var views: [UIView] = []
    
    var dataPersistantFlashcards: [Flashcard] = []
    var currentFlashcardIndex = 0

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Flashcards.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.layer.cornerRadius = 20
        topView.clipsToBounds = true
        views = [topView, bottomView]
        loadFlashcards()
        
        self.updateFlashcard(change: 0)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveFlashcards()
    }
    

    @IBAction func homePressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func shufflePressed(_ sender: UIButton) {
        dataPersistantFlashcards.shuffle()
        currentFlashcardIndex = 0
        updateFlashcard(change: 0)
    }
    
    @IBAction func trashPressed(_ sender: UIButton) {
        dataPersistantFlashcards.remove(at: currentFlashcardIndex)
        updateFlashcard(change: 0)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        if currentFlashcardIndex == 0 {
            currentFlashcardIndex = dataPersistantFlashcards.count - 1
            updateFlashcard(change: 0)
        } else {
            updateFlashcard(change: -1)
        }
    }
    
    @IBAction func flipPressed(_ sender: UIButton) {
        dataPersistantFlashcards[currentFlashcardIndex].flip()
        self.updateFlashcard(change: 0)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        if currentFlashcardIndex == dataPersistantFlashcards.count - 1 {
            currentFlashcardIndex = 0
            updateFlashcard(change: 0)
        } else {
            updateFlashcard(change: 1)
        }
    }
    
    func updateFlashcard(change: Int) {
        if dataPersistantFlashcards.count == 0 {
            questionLabel.text = "No Flashcards"
            forwardButton.isHidden = true
            backButton.isHidden = true
            flipButton.isHidden = true
            progressLabel.isHidden = true
            trashButton.isHidden = true
            shuffleButton.isHidden = true
        } else if currentFlashcardIndex == dataPersistantFlashcards.count {
            currentFlashcardIndex -= 1
        }
        if (currentFlashcardIndex + change >= 0) && (currentFlashcardIndex + change < dataPersistantFlashcards.count) {
            
            if questionLabel.text == "\(dataPersistantFlashcards[currentFlashcardIndex].answer)" && change != 0 {
                dataPersistantFlashcards[currentFlashcardIndex].flip()
            }
            
            currentFlashcardIndex += change
            
            questionLabel.text = dataPersistantFlashcards[currentFlashcardIndex].textShowing
            progressLabel.text = "\(currentFlashcardIndex + 1) / \(dataPersistantFlashcards.count)"
        }
    }
    
    func saveFlashcards() {

        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(dataPersistantFlashcards)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding flashcard array: \(error)")
        }
    }

    func loadFlashcards() {

        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                dataPersistantFlashcards = try decoder.decode([Flashcard].self, from: data)
            } catch {
                print("Error decoding flashcard array \(error)")
            }

        }
    }
    
}
