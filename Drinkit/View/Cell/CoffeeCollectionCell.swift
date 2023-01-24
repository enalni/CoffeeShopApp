//
//  CoffeeCollectionCell.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.01.2023.
//

import UIKit

class CoffeeCollectionCell: UICollectionViewCell {
    
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
        static let sizeFontnameCoffeeLabel: CGFloat = 20
        static let mockPriceInpriceCoffeeLabel: CGFloat = 150
    }
    
    //MARK: - Private Property
    
    private let coffeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "americano")
        return imageView
    }()
    
    private let nameCoffeeLabel: UILabel = {
        let label = UILabel()
        label.text = "Американо"
        label.font = .boldSystemFont(ofSize: UIConstants.sizeFontnameCoffeeLabel)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceCoffeeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UIConstants.mockPriceInpriceCoffeeLabel) ₽"
        return label
    }()
    
    private let fullInformationChevronButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        return button
    }()
    
    private lazy var xStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceCoffeeLabel, fullInformationChevronButton])
        return stackView
    }()
    
    private lazy var yStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coffeeImageView, nameCoffeeLabel, xStack])
        stackView.axis = .vertical
        return stackView
    }()
}

//MARK: - Private methods
private extension CoffeeCollectionCell {
    func initialize() {
        addSubviews(yStack)
        
        NSLayoutConstraint.activate([
            yStack.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            yStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            yStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            yStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
