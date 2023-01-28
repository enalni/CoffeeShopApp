//
//  CoffeeCollectionCell.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.01.2023.
//

import UIKit
import SnapKit

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
        label.font = .boldSystemFont(ofSize: UIConstants.sizeFontnameCoffeeLabel)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceCoffeeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UIConstants.mockPriceInpriceCoffeeLabel) ₽"
        label.textColor = UIColor(named: "colorText")
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let fullInformationChevronButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private lazy var xStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceCoffeeLabel, fullInformationChevronButton])
        stackView.axis = .horizontal
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = 2
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var yStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coffeeImageView, nameCoffeeLabel, xStack])
        stackView.axis = .vertical
        return stackView
    }()
    
    private let conteinerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.addBlurredBackground(style: .systemChromeMaterialDark)
        return view
    }()
}

//MARK: - Private methods
private extension CoffeeCollectionCell {
    func initialize() {
        
        conteinerView.addSubview(yStack)
        contentView.addSubview(conteinerView)
        
        yStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        conteinerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
