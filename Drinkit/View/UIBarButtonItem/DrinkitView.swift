//
//  DrinkitView.swift
//  Drinkit
//
//  Created by Александр Николаевич on 18.01.2023.
//

import UIKit

final class DrinkitView: UIView {
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
        static let sizeCityLabel: CGFloat = 19
        static let sizeOpeningHoursLabel: CGFloat = 15
    }
    
    //MARK: - Private property
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "drinkitLogo")
        imageView.layer.cornerRadius = UIConstants.logoWidth/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "colorText")
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeCityLabel)
        label.text = "Москва"
        return label
    }()
    
    private let openingHoursLabel: UILabel = {
        let label = UILabel()
        label.text = "до 22:00"
        label.font = .systemFont(ofSize: 15)
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeOpeningHoursLabel)
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
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: - Private methods
private extension DrinkitView {
    func initialize() {
        addSubview(customView)
        customView.addSubview(xStackView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: UIConstants.logoWidth),

            customView.topAnchor.constraint(equalTo: self.topAnchor),
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            xStackView.topAnchor.constraint(equalTo: customView.topAnchor),
            xStackView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            xStackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            xStackView.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
        ])
    }
}
