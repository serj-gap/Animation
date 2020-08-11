//
//  ViewController.swift
//  CAnimation
//
//  Created by Sergey Titov on 8/10/20.
//  Copyright © 2020 Sergey Titov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let userProfile = UserProfile()
    
    var startLoginCenter: CGPoint!
    var startPasswordCenter: CGPoint!
    
    
    @IBOutlet weak var userImage: UserImageView!
   
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var nameFiled: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLoginCenter = nameFiled.center
        startPasswordCenter = passwordField.center
        userProfile.loadNextImage(to: userImage, with: imageName, buttons: [nextButton])

    }


    @IBAction func loginButton(_ sender: UIButton) {
    
    let imageNamesArray = ["star1", "star2"]
           KEmitter().emitParticles(superView: view, imageNamesArray: imageNamesArray, stopAfterSeconds: 2.0, type: 3)
    

        let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            UIView.animate(withDuration: 2, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: [.curveEaseInOut], animations: {
                self.loginButton.backgroundColor = .gray
                self.loginButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.nameFiled.center.x += self.view.bounds.width
                self.passwordField.center.x -= self.view.bounds.width
                self.nameFiled.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.passwordField.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: { _ in
                UIView.animate(withDuration: 1, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.loginButton.backgroundColor = .white
                    self.loginButton.transform = .identity
                    self.nameFiled.transform = .identity
                    self.passwordField.transform = .identity
                    self.nameFiled.center = self.startLoginCenter
                    self.passwordField.center = self.startPasswordCenter
                })
            })
    }

   
    
    @IBAction func previousImageButton(_ sender: UIButton) {
        
    let pulse = PulseAnimation.init(numberOfPulses: 2, radius: 50, position: sender.center)
        pulse.animationDuration = 2.0
        pulse.backgroundColor = #colorLiteral(red: 0.4023996256, green: 0.6935422367, blue: 0.7313793215, alpha: 1)
        self.view.layer.insertSublayer(pulse, below:  self.view.layer)
        
        userProfile.getPreviousImage(to: userImage, with: imageName)
               
    }
    
    
    @IBAction func nextImageButton(_ sender: UIButton) {
    let pulse = PulseAnimation.init(numberOfPulses: 2, radius: 50, position: sender.center)
          pulse.animationDuration = 2.0
          pulse.backgroundColor = #colorLiteral(red: 0.4023996256, green: 0.6935422367, blue: 0.7313793215, alpha: 1)
          self.view.layer.insertSublayer(pulse, above:  self.view.layer)

        userProfile.loadNextImage(to: userImage, with: imageName, buttons: [backButton, nextButton])
    
    }

}


