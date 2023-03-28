//
//  ShoppingCartTableViewCell.swift
//  Drinkit
//
//  Created by Александр Николаевич on 06.03.2023.
//

import UIKit

class ShoppingCartTableViewCell: UITableViewCell {
    
    // MARK: Public func
    func configure(drink: Drink) {
        self.imageOfDrink.image = imageOfDrink.image
        self.nameOfDrink.text = drink.nameDrink
//        self.descriptionOfDrink.text = drink.nameDrink
        self.priceOfDrink.text = drink.priceDrink
    }
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let sizeFontNameOfDrink: CGFloat = 20
        static let sizeFontDescriptionOfDrink: CGFloat = 15
        static let sizeFontPriceOfDrink: CGFloat = 20
        static let spacingSet: CGFloat = 10
        
        static let sizeImageOfDrink: CGFloat = 70
        static let widthPriceOfDrink: CGFloat = 70
        
        static let topAnchorxStack: CGFloat = 6
        static let leadingAnchorXStack: CGFloat = 16
        static let trailingAnchorXStack: CGFloat = -16
        
        
    }
    
    // MARK: Private property
    private let imageOfDrink: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "americano")
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameOfDrink: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontNameOfDrink)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let descriptionOfDrink: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontDescriptionOfDrink)
        label.textAlignment = .left
        label.text = "250мл"
        label.textColor = .black
        return label
    }()
    
    private let priceOfDrink: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontPriceOfDrink)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yStackNameAndDecriptionOfDrink: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameOfDrink, descriptionOfDrink])
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    lazy var xStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageOfDrink, yStackNameAndDecriptionOfDrink, priceOfDrink])
        stack.axis = .horizontal
        stack.spacing = UIConstants.spacingSet
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ShoppingCartTableViewCell {
    func initialize() {
        
        contentView.addSubview(imageOfDrink)
        contentView.addSubview(xStack)
        
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            
            imageOfDrink.widthAnchor.constraint(equalToConstant: UIConstants.sizeImageOfDrink),
            imageOfDrink.heightAnchor.constraint(equalToConstant: UIConstants.sizeImageOfDrink),
        
            priceOfDrink.widthAnchor.constraint(equalToConstant: UIConstants.widthPriceOfDrink),
            
            xStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.topAnchorxStack),
            xStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.leadingAnchorXStack),
            xStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: UIConstants.trailingAnchorXStack),
        ])
        
    }
}
