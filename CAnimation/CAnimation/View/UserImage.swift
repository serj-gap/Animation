//
//  UserImage.swift
//  CAnimation
//
//  Created by Sergey Titov on 8/11/20.
//  Copyright © 2020 Sergey Titov. All rights reserved.
//

import UIKit

class UserImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = bounds.size.width / 2
        clipsToBounds = true
    }
}
