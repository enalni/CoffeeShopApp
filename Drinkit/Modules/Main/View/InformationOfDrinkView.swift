import UIKit

final class InformationOfDrinkView: UIView {
    // MARK: - Public func
    func configure(with coffeHelpers: CoffeeViewModel) {
        self.nameCoffeeLabel.text = coffeHelpers.coffeeName
        configPriceButton(price: coffeHelpers.coffeePrice)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private constraint
    private enum Constants {
        enum UIConstants {
            static let cornerRadiusSet: CGFloat =  25
            static let leadingSet: CGFloat = 16
            static let trailingSet: CGFloat = -16
            static let sizeFontNameCoffeeLabel: CGFloat = 32
            static let sizeFontPriceCoffeeButton: CGFloat = 30
            static let sizeFontAddFlavorButton: CGFloat = 30
            static let sizeFontShoppingCardSummaLabel: CGFloat = 25
            static let spacingXStackButtons: CGFloat = 15
            static let countNumberOfLines: Int = 0
            static let heightNameCoffeeLabel: CGFloat = 60
            static let heightXStackButtons: CGFloat = 60
            static let bottomNameCoffeeLabel: CGFloat = -220
            static let bottomXStackButtons: CGFloat = -160
        }
         enum SetNameButtons {
            static let en: String = " flavor"
            static let ru: String = " вкус"
            static let arab: String = " نكهة"
        }
         enum Language {
             static let en: String = "en"
             static let ru: String = "ru"
             static let arabic: String = "ar"
        }
    }

    // MARK: - Private property
    
    weak var delegate: ShoppingCartViewDelegate?
    weak var delegatePresentViewController: ViewControllerPresentDelegate?
    
    private var nameCoffeeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "nameCoffeeColorForLabel")
        label.font = UIFont(name: "Roboto-Medium", size: Constants.UIConstants.sizeFontNameCoffeeLabel)
        label.contentMode = .center
        label.numberOfLines = Constants.UIConstants.countNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceCoffeeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Constants.UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "colorPriceCoffeeButton")
        button.setTitleColor(UIColor(named: "colorText"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: Constants.UIConstants.sizeFontPriceCoffeeButton)
        return button
    }()
    
    private let gradienLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.2, y: 0.9)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        let colors = [UIColor.purple.cgColor, UIColor.magenta.cgColor]
        gradient.colors = colors
        return gradient
    }()
    
    private let configDrinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Constants.UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        let color = UIColor(named: "colorAddFlavorButton")?.cgColor
        button.setTitle(" вкус", for: .normal)
        button.tintColor = .white
        let image = UIImage(systemName: "wand.and.stars")
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: Constants.UIConstants.sizeFontAddFlavorButton)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var xStackButtons: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceCoffeeButton, configDrinkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Constants.UIConstants.spacingXStackButtons
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func layoutSubviews() {
        configGradient()
    }
    
}
// MARK: - Private methods
private extension InformationOfDrinkView {
    func initialize() {
        configLanguage()
        backgroundColor = .clear
        addSubview(nameCoffeeLabel)
        addSubview(xStackButtons)
        
        configDrinkButton.addTarget(self, action: #selector(tappedConfigDrinkButton), for: .touchUpInside)
        priceCoffeeButton.addTarget(self, action: #selector(tappedPriceCoffeeButton(sender:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nameCoffeeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.UIConstants.bottomNameCoffeeLabel),
            nameCoffeeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.UIConstants.leadingSet),
            nameCoffeeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.UIConstants.trailingSet),
            nameCoffeeLabel.heightAnchor.constraint(equalToConstant: Constants.UIConstants.heightNameCoffeeLabel),
            
            xStackButtons.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.UIConstants.bottomXStackButtons),
            xStackButtons.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.UIConstants.leadingSet),
            xStackButtons.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.UIConstants.trailingSet),
            xStackButtons.heightAnchor.constraint(equalToConstant: Constants.UIConstants.heightXStackButtons),
        ])
    }
    
    func configPriceButton(price: String) {
        let price = " + \(price)"
        self.priceCoffeeButton.setTitle(price, for: .normal)
    }
    
    func configLanguage() {
        if Locale.current.languageCode == Constants.Language.en {
            configDrinkButton.setTitle(Constants.SetNameButtons.en, for: .normal)
        } else if Locale.current.languageCode == Constants.Language.ru {
            configDrinkButton.setTitle(Constants.SetNameButtons.ru, for: .normal)
        } else if Locale.current.languageCode == Constants.Language.arabic {
            configDrinkButton.setTitle(Constants.SetNameButtons.arab, for: .normal)
        }
    }
    
    func configGradient() {
        gradienLayer.frame = configDrinkButton.bounds
        configDrinkButton.layer.insertSublayer(gradienLayer, at: 0)
    }
    
    @objc
    func tappedConfigDrinkButton(sender: UIButton) {
        sender.addVibrationResponse()
        let vc = ConfigureDrinkViewController()
        delegatePresentViewController?.viewControllerPresent(_controller: vc)
    }
    
    @objc
    func tappedPriceCoffeeButton (sender: UIButton) {
        sender.addVibrationResponse()
        guard let price = self.priceCoffeeButton.titleLabel?.text else {return}
        delegate?.updatePriceShoppingCartView(_price: price)
        print("TAPPED priceCoffeeButton")
    }
}
