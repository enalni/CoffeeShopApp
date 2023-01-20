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
}
