//
//  ConfigureDrinkCollectionCell.swift
//  Drinkit
//
//  Created by Александр Николаевич on 13.03.2023.
//

import UIKit

final class ConfigureDrinkCollectionCell: UICollectionViewCell {
    
    // MARK: Public func
    func configure(drink: Drink){
        self.nameDrinkLabel.text = drink.nameDrink
    }
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let sizeFontNameDrinkLabel: CGFloat = 30
        static let sizeFontDescriptionDrinkLabel: CGFloat = 20
        static let sizeFontDrinkSegmentedControl: CGFloat = 26
        static let sizeFontAddDrinkToShoppingCartButton: CGFloat = 30
        
        static let spacingSet: CGFloat = 5
        static let cornerRadiusSet: CGFloat = 20
        
        static let topAnchorSet: CGFloat = 10
        static let leadingAnchorSet: CGFloat = 16
        static let trailingAnchorSet: CGFloat = -16
        static let heightAnchorSet: CGFloat = 60
    }
    
    // MARK: Private property

    weak var delegateOpen: ViewControllerPresentDelegate?
    
    let drinkImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "americano")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var sizeDrinkSegmentedControl: CustomDrinkSegmentControl = {
        let segment = CustomDrinkSegmentControl(items: ["200мл", "300мл", "400мл"])
        segment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIConstants.sizeFontDrinkSegmentedControl)], for: .normal)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private let nameDrinkLabel: UILabel = {
        let label = UILabel()
        label.text = "Американо"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontNameDrinkLabel)
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionDrinkLabel: UILabel = {
        let label = UILabel()
        label.text = "Чёрный кофе на основе эспрессо"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: UIConstants.sizeFontDescriptionDrinkLabel)
        return label
    }()
    
    lazy var yStackNameAndDescriptionDrinkLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameDrinkLabel, descriptionDrinkLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIConstants.spacingSet
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let additiviesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыть добавки", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontAddDrinkToShoppingCartButton)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addDrinkToShoppingCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontAddDrinkToShoppingCartButton)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var allElementsStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [drinkImageView,
                                                       yStackNameAndDescriptionDrinkLabelsStackView,
                                                       additiviesButton,
                                                       addDrinkToShoppingCartButton])
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = UIConstants.spacingSet
        stackview.alignment = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: Private methods
private extension ConfigureDrinkCollectionCell {
    func initialize() {
        
        additiviesButton.addTarget(self, action: #selector(tappedAdditiviesButton), for: .touchUpInside)

        contentView.addSubview(allElementsStackView)
        
        NSLayoutConstraint.activate([
            allElementsStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            allElementsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  UIConstants.leadingAnchorSet),
            allElementsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: UIConstants.trailingAnchorSet),
            
            // sizes element
            drinkImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2),
            sizeDrinkSegmentedControl.heightAnchor.constraint(equalToConstant: UIConstants.heightAnchorSet),
            yStackNameAndDescriptionDrinkLabelsStackView.heightAnchor.constraint(equalToConstant: UIConstants.heightAnchorSet),
            additiviesButton.heightAnchor.constraint(equalToConstant: UIConstants.heightAnchorSet),
            addDrinkToShoppingCartButton.heightAnchor.constraint(equalToConstant: UIConstants.heightAnchorSet),
        ])
    }
    
    @objc func tappedAdditiviesButton() {
        let vc = ConfigDrinkAdditivesViewController()
        delegateOpen?.viewControllerPresent(_controller: vc)
    }
}
