//
//  ShoppingCartView.swift
//  Drinkit
//
//  Created by Александр Николаевич on 07.02.2023.
//

import UIKit

final class ShoppingCartView: UIView {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initiliaze()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private constraint
    private enum UIConstants {
        static let cornerRadiusSet: CGFloat = 20
        static let spacingSet: CGFloat = 5
        static let sizeFontShoppingCardSummaLabel: CGFloat = 20
        static let xStackTopAndLeading: CGFloat = 5
        static let xStackBottomAndTrailing: CGFloat = -5
    }
    
     let shoppingCardSummaLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 120 ₽"
         label.contentMode = .scaleAspectFit
        label.textColor = UIColor(named: "colorText")
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontShoppingCardSummaLabel)
        return label
    }()
    
    private let imageViewShoppingCar: UIImageView = {
        let imageView =  UIImageView()
        let image = UIImage(named: "americano")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = UIConstants.cornerRadiusSet
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "colorShoppingCartImageView")
        return imageView
    }()
    
    private lazy var xStackShoppingCart: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shoppingCardSummaLabel, imageViewShoppingCar])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = UIConstants.spacingSet
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private let shoppingCartView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIConstants.cornerRadiusSet
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.addBlurredBackground(style: .systemThinMaterialDark)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}
//MARK: - Private methods
private extension ShoppingCartView {
    func initiliaze() {
        
        configShoppingCart()
        
        addSubview(shoppingCartView)
        shoppingCartView.addSubview(xStackShoppingCart)
        
        NSLayoutConstraint.activate([
            shoppingCartView.topAnchor.constraint(equalTo: self.topAnchor),
            shoppingCartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            shoppingCartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            shoppingCartView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            xStackShoppingCart.topAnchor.constraint(equalTo: shoppingCartView.topAnchor, constant: UIConstants.xStackTopAndLeading),
            xStackShoppingCart.leadingAnchor.constraint(equalTo: shoppingCartView.leadingAnchor, constant: UIConstants.xStackTopAndLeading),
            xStackShoppingCart.trailingAnchor.constraint(equalTo: shoppingCartView.trailingAnchor, constant: UIConstants.xStackBottomAndTrailing),
            xStackShoppingCart.bottomAnchor.constraint(equalTo: shoppingCartView.bottomAnchor, constant: UIConstants.xStackBottomAndTrailing),
        ])
    }
    
    func configShoppingCart() {
        self.shoppingCartView.addBlurredBackground(style: .extraLight)
    }
}
