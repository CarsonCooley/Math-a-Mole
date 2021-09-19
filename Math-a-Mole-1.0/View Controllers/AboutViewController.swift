//
//  AboutViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 9/18/21.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var logoLabel: UIImageView!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        aboutLabel.text = K.About.aboutLabel
        emailLabel.text = K.About.emailLabel
        
        privacyButton.layer.cornerRadius = 10
        privacyButton.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
