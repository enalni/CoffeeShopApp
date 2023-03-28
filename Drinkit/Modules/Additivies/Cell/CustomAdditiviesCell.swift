//
//  CustomAdditiviesCell.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.03.2023.
//

import UIKit


final class CustomAdditiviesCell: UICollectionViewCell {
    
    // MARK: Public Func
    func configure(additivies: Additivies) {
        self.nameAdditiviesLabel.text = additivies.name
        self.priceAdditiviesLabel.text = additivies.price
    }
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let topAndLeadingSet: CGFloat = 16
        static let trailingAndBottomSet: CGFloat = -16
        static let priceLabelAlpha: CGFloat = 0.5
        static let additiviesImageCornerRadiusSet: CGFloat = 25
        static let yStackSpacing: CGFloat = 3
    }
    
    // MARK: Private property
    
    private let additiviesImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "additiviesImage")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIConstants.additiviesImageCornerRadiusSet
        imageView.backgroundColor = UIColor(named: "colorTexfileld")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameAdditiviesLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить молоко"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceAdditiviesLabel: UILabel = {
        let label = UILabel()
        label.text = "+70 ₽"
        label.textAlignment = .center
        label.alpha = UIConstants.priceLabelAlpha
        return label
    }()
    
    lazy var yStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [additiviesImageView, nameAdditiviesLabel, priceAdditiviesLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = UIConstants.yStackSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomAdditiviesCell {
    func initialize() {
        
        contentView.addSubview(yStack)
                
        NSLayoutConstraint.activate([
            yStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.topAndLeadingSet),
            yStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.topAndLeadingSet),
            yStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: UIConstants.trailingAndBottomSet),
            yStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: UIConstants.trailingAndBottomSet),
        ])
    }
}
