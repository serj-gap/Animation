//
//  Profile.swift
//  CAnimation
//
//  Created by Sergey Titov on 8/11/20.
//  Copyright © 2020 Sergey Titov. All rights reserved.
//


import UIKit

class UserProfile {
    private var cities_URL = "https://source.unsplash.com/480x480/?cities"
    
    enum FlipSide {
        case left
        case right
    }
    
    private var userCashedData = [(image: UIImage, title: String)]()
    private var backCounter = 0
    
    private func change(imageView: UIImageView, label: UILabel, to pair: (image: UIImage, title: String), side: FlipSide) {
        let imageFlipSide: UIView.AnimationOptions = (side == .left ? UIView.AnimationOptions.transitionFlipFromLeft : UIView.AnimationOptions.transitionFlipFromRight)
        let labelFlipSide: UIView.AnimationOptions = (side == .left ? UIView.AnimationOptions.transitionFlipFromBottom : UIView.AnimationOptions.transitionFlipFromTop)
        
        UIView.transition(with: imageView, duration: 1.0, options: [imageFlipSide], animations: {
            imageView.image = pair.image
        })
        UIView.transition(with: label, duration: 1, options: [labelFlipSide], animations: {
            label.alpha = 0.0
            label.text = pair.title
        })
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [], animations: {
            label.alpha = 1
        }, completion: nil)
    }
    
    func loadNextImage(to imageView: UIImageView, with label: UILabel, buttons: [UIButton]? = nil) {
        if backCounter == 0 {
            buttons?.forEach { $0.isEnabled.toggle() }
            let newTitle = Cities.getRandomName()
         
            let activityIndicator = imageView.activityIndicator
            
            UIView.transition(with: imageView, duration: 1.0, options: [.transitionFlipFromRight], animations: {
                
                imageView.setImageFrom(self.cities_URL, components: (nil, activityIndicator), completion: { image in
                    self.userCashedData.append((image: image, title: newTitle))
                    buttons?.forEach { $0.isEnabled.toggle() }
                })
            })
            UIView.transition(with: label, duration: 1, options: [.transitionFlipFromTop], animations: {
                label.alpha = 0.0
                label.text = newTitle
            })
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [], animations: {
                label.alpha = 1
            }, completion: nil)
            
        } else {
            backCounter -= 1
            change(imageView: imageView, label: label, to: userCashedData[userCashedData.count - 1 - backCounter], side: .right)
        }
    }
    
    func getPreviousImage(to imageView: UIImageView, with label: UILabel) -> Bool {
        backCounter += 1
        if backCounter != userCashedData.count {
            change(imageView: imageView, label: label, to: userCashedData[userCashedData.count - 1 - backCounter], side: .left)
            
            if backCounter + 1 != userCashedData.count {
                return true
            }
        }
        return false
    }

}

extension UIImageView {
        
    var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.gray
        activityIndicator.style = .large
        self.addSubview(activityIndicator)
        
        activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        return activityIndicator
    }
    
    func setImageFrom(_ stringUrl: String, components: (UIVisualEffectView?, UIActivityIndicatorView), completion: ((UIImage) -> Void)? = nil) {
        guard let url = URL(string: stringUrl) else {
            return
        }

        DispatchQueue.main.async {
            components.1.startAnimating()
        }
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
                components.1.stopAnimating()
                completion?(image)
            }
        })
        dataTask.resume()
        
    }
}
