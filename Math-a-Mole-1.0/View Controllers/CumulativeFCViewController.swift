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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func homePressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var trashPressed: UIImageView!
    
}
