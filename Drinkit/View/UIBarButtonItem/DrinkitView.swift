//
//  DrinkitView.swift
//  Drinkit
//
//  Created by Александр Николаевич on 18.01.2023.
//

import UIKit
import SnapKit

class DrinkitView: UIView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private constraint
    private enum UIConstants {
        static let logoHeight: CGFloat = 45
        static let logoWidth: CGFloat = 45
        static let yStackSpacing: CGFloat = 3
        static let xStackSpacing: CGFloat = 3
        static let xStackWidth: CGFloat = 150
        static let xStackHeight: CGFloat = 50
    }
    
    //MARK: - Private property
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "drinkitLogo")
        imageView.layer.cornerRadius = UIConstants.logoWidth/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "colorText")
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Москва"
        return label
    }()
    
    private let openingHoursLabel: UILabel = {
        let label = UILabel()
        label.text = "до 22:00"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(named: "colorOpenTime")
        return label
    }()
    
    private lazy var yStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityLabel,openingHoursLabel])
        stack.axis = .vertical
        stack.spacing = UIConstants.yStackSpacing
        return stack
    }()
    
    private lazy var xStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, yStackView])
        stack.axis = .horizontal
        stack.spacing = UIConstants.xStackSpacing
        return stack
    }()
}

//MARK: - Private methods
private extension DrinkitView {
    func initialize() {
        
        addSubviews(xStackView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.logoWidth)
        }
        
        xStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
