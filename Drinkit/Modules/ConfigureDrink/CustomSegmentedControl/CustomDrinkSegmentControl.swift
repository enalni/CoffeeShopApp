//
//  CustomDrinkSegmentControl.swift
//  Drinkit
//
//  Created by Александр Николаевич on 13.03.2023.
//

import UIKit

final class CustomDrinkSegmentControl: UISegmentedControl {
    
    // MARK: Private property
    private(set) lazy var radius: CGFloat = bounds.height / 2
    private var segmentInset: CGFloat = 0.1 {
        didSet{
            segmentInset == 0 ? segmentInset = 0.1 : nil
        }
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        configSegmentControl()
    }
}

// MARK: - Private methods
private extension CustomDrinkSegmentControl {
    func initialize() {
        selectedSegmentIndex = 0
    }
    
    func configSegmentControl() {
        
        backgroundColor = UIColor(named: "colorDrinkSegmentControl")
        
        self.layer.cornerRadius = self.radius
        self.layer.masksToBounds = true
        
        let selectedImageViewIndex = numberOfSegments
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView
        {
            selectedImageView.backgroundColor = .white
            selectedImageView.image = nil
            selectedImageView.addBlurredBackground(style: .systemChromeMaterialLight)
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = self.radius
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
        }
    }
}
