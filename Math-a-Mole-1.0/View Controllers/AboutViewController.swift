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
    
    @IBAction func privacyPressed(_ sender: UIButton) {
        openUrl(urlStr: "https://www.math-a-mole.com")
    }
    
    func openUrl(urlStr: String!) {
        if let url = URL(string:urlStr), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    

}
