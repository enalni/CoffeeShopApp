//
//  UIView + Extensions.swift
//  Drinkit
//
//  Created by Александр Николаевич on 18.01.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    func addBlurredBackground(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
        self.sendSubviewToBack(blurView)
    }
}
