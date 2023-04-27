import UIKit

final class DrinkCollectionCell: UICollectionViewCell {

    // MARK: - Public func
    func config(drink: Drink) {
        self.nameCoffeeLabel.text = drink.nameDrink
        self.priceCoffeeLabel.text = drink.priceDrink
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let sizeFontNameCoffeeLabel: CGFloat = 15
        static let sizeFontPriceCoffeeLabel: CGFloat = 25
        static let sizeFontAddDrinkToShoppingCartLabel: CGFloat = 20
        
        static let cornerRadiusSet: CGFloat = 15
        static let spacingXStack: CGFloat = 4
        
        static let yStackTopAndLeadingSet: CGFloat = 16
        static let yStackTrailingAndBottomSet: CGFloat = -16
        
        static let sizeAddDrinkButton: CGFloat = 30
        
        static let mockPriceInpriceCoffeeLabel: Int = Int.random(in: 80...150)
    }
    
    // MARK: - Private Property
    
    weak var delegate: ShoppingCartViewDelegate?
    
    private let coffeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "americano")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameCoffeeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: UIConstants.sizeFontNameCoffeeLabel)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceCoffeeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "colorText")
        label.textAlignment = .natural
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontPriceCoffeeLabel)
        return label
    }()
    
    private let addDrinkToShoppingCart: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontAddDrinkToShoppingCartLabel)
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .natural
        return button
    }()
    
    private lazy var xStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceCoffeeLabel, addDrinkToShoppingCart])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var yStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coffeeImageView, nameCoffeeLabel, xStack])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIConstants.cornerRadiusSet
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.addBlurredBackground(style: .systemChromeMaterialDark)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

// MARK: - Private methods
private extension DrinkCollectionCell {
    func initialize() {
        
        contentView.addSubview(containerView)
        containerView.addSubview(yStack)
        
        addDrinkToShoppingCart.addTarget(self, action: #selector(addDrinkToShoppingCartTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            coffeeImageView.topAnchor.constraint(equalTo: yStack.topAnchor),
            coffeeImageView.leadingAnchor.constraint(equalTo: yStack.leadingAnchor),
            coffeeImageView.trailingAnchor.constraint(equalTo: yStack.trailingAnchor),
            coffeeImageView.heightAnchor.constraint(equalTo: yStack.heightAnchor, multiplier: 1/2),
            
            yStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            yStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: UIConstants.yStackTopAndLeadingSet),
            yStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: UIConstants.yStackTrailingAndBottomSet),
            yStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: UIConstants.yStackTrailingAndBottomSet),
    
            addDrinkToShoppingCart.heightAnchor.constraint(equalToConstant: UIConstants.sizeAddDrinkButton),
            addDrinkToShoppingCart.widthAnchor.constraint(equalToConstant: UIConstants.sizeAddDrinkButton),
        ])
    }
    
    @objc func addDrinkToShoppingCartTapped() {
        guard let price = self.priceCoffeeLabel.text else {return}
        delegate?.updatePriceShoppingCartView(_price: price)
    }
}
