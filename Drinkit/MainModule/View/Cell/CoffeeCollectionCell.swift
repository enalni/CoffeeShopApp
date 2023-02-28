//
//  CoffeeCollectionCell.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.01.2023.
//

import UIKit

final class CoffeeCollectionCell: UICollectionViewCell {
    
    //MARK: - Public func
    func config() {
        
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private constraint
    private enum UIConstants {
        static let sizeFontNameCoffeeLabel: CGFloat = 20
        static let sizeFontPriceCoffeeLabel: CGFloat = 25
        static let sizeFontFullInformationChevronButton: CGFloat = 25
        
        static let cornerRadiusSet: CGFloat = 15
        static let spacingXStack: CGFloat = 4
        
        static let yStackTopAndLeadingSet: CGFloat = 10
        static let yStackTrailingAndBottomSet: CGFloat = -10
        
        static let mockPriceInpriceCoffeeLabel: Int = Int.random(in: 80...150)
    }
    
    //MARK: - Private Property
    
    private let coffeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dripka")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameCoffeeLabel: UILabel = {
        let label = UILabel()
        label.text = "Американо"
        label.font = .boldSystemFont(ofSize: UIConstants.sizeFontNameCoffeeLabel)
        return label
    }()
    
    private let priceCoffeeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UIConstants.mockPriceInpriceCoffeeLabel) ₽"
        label.textColor = UIColor(named: "colorText")
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontPriceCoffeeLabel)
        return label
    }()
    
    private let fullInformationChevronButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontFullInformationChevronButton)
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private lazy var xStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceCoffeeLabel, fullInformationChevronButton])
        stackView.axis = .horizontal
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = UIConstants.spacingXStack
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var yStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coffeeImageView, nameCoffeeLabel, xStack])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIConstants.cornerRadiusSet
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.addBlurredBackground(style: .systemChromeMaterialDark)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: - Private methods
private extension CoffeeCollectionCell {
    func initialize() {
        
        contentView.addSubview(containerView)
        containerView.addSubview(yStack)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            yStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: UIConstants.yStackTopAndLeadingSet),
            yStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: UIConstants.yStackTopAndLeadingSet),
            yStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: UIConstants.yStackTrailingAndBottomSet),
            yStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: UIConstants.yStackTrailingAndBottomSet),
        ])
    }
}
