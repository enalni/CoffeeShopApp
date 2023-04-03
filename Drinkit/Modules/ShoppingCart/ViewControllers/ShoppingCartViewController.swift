import UIKit

final class ShoppingCartViewController: UIViewController {
    
    // MARK: - Private constraint
    private enum UIConstants {
        // Font
        static let sizeFontNamesCoffeineLabel: CGFloat = 20
        static let sizeFontPaymentMethodButton: CGFloat = 25
        static let sizeFontTotalLabel: CGFloat = 25
        static let sizeFontTotalAmountLabel: CGFloat = 30
        static let sizeFontPayButton: CGFloat = 25
        
        static let alphaPaymentMethodButton: CGFloat = 0.4
        static let cornerRadiusPaymentMethodButton: CGFloat = 15
        static let cornerRadiusPayButton: CGFloat = 25
        
        static let topAnchorXStack: CGFloat = 5
        static let leadingAnchorSet: CGFloat = 16
        static let trailingAnchorSet: CGFloat = -16
        static let heightSeparatorSet: CGFloat = 1
        static let heightxStackSet: CGFloat = 50
        static let bottomAnchorPayButton: CGFloat = -30
        static let bottomAnchorXstack: CGFloat = -6
        
        static let heightCell: CGFloat = 80
    }
    
    // MARK: - Private property
    private var drinks: [Drink] = .init()
    
    private let namesCoffeineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontNamesCoffeineLabel)
        label.textColor = .black
        label.text = "Белорусская"
        return label
    }()
    
    private let cleaningShoppingCartButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "trash.fill")
        button.tintColor = .red
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let dismissViewControllerButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var xStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cleaningShoppingCartButton, namesCoffeineLabel, dismissViewControllerButton])
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let shoppingCartTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let paymentMethodButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.clipsToBounds = true
        button.alpha = UIConstants.alphaPaymentMethodButton
        button.layer.cornerRadius = UIConstants.cornerRadiusPaymentMethodButton
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontPaymentMethodButton)
        button.setTitle("Способ оплаты", for: .normal)
        return button
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Итого"
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontTotalLabel)
        return label
    }()
    
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.text = "1239 ₽"
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontTotalAmountLabel)
        return label
    }()
    
    private lazy var yStackTotalAmountLabel: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalLabel, totalAmountLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var xStackPaymentMethodButtonAndTotalAmountLabel: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [paymentMethodButton, yStackTotalAmountLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let payButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = UIConstants.cornerRadiusPayButton
        button.setTitle("Оплатить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontPayButton)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let separatorTop: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorBottom: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}
// MARK: Private methods
private extension ShoppingCartViewController {
    func initialize() {
        
        configureTableView()
        
        view.backgroundColor = .white
        
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
        
        view.addSubview(xStack)
        view.addSubview(separatorTop)
        view.addSubview(shoppingCartTableView)
        view.addSubview(separatorBottom)
        view.addSubview(xStackPaymentMethodButtonAndTotalAmountLabel)
        view.addSubview(payButton)
        
        dismissViewControllerButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        cleaningShoppingCartButton.addTarget(self, action: #selector(cleaningDrinks), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            xStack.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1),
            xStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.leadingAnchorSet),
            xStack.heightAnchor.constraint(equalToConstant: UIConstants.heightxStackSet),
            xStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.trailingAnchorSet),
            
            separatorTop.topAnchor.constraint(equalTo: xStack.bottomAnchor),
            separatorTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorTop.heightAnchor.constraint(equalToConstant: UIConstants.heightSeparatorSet),
            
            shoppingCartTableView.topAnchor.constraint(equalTo: separatorTop.bottomAnchor),
            shoppingCartTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.leadingAnchorSet),
            shoppingCartTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.trailingAnchorSet),
            shoppingCartTableView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.65),
            
            separatorBottom.topAnchor.constraint(equalTo: shoppingCartTableView.bottomAnchor),
            separatorBottom.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorBottom.heightAnchor.constraint(equalToConstant: UIConstants.heightSeparatorSet),
            
            xStackPaymentMethodButtonAndTotalAmountLabel.topAnchor.constraint(equalTo: separatorBottom.bottomAnchor, constant: UIConstants.topAnchorXStack),
            xStackPaymentMethodButtonAndTotalAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: UIConstants.leadingAnchorSet),
            xStackPaymentMethodButtonAndTotalAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.trailingAnchorSet),
            xStackPaymentMethodButtonAndTotalAmountLabel.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: UIConstants.bottomAnchorXstack),
            
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.leadingAnchorSet),
            payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.trailingAnchorSet),
            payButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: UIConstants.bottomAnchorPayButton),
        ])
    }
    
    func configureTableView() {
        
        let drinkOne = Drink(nameDrink: "Американо", priceDrink: "120 ₽")
        let drinkTwo = Drink(nameDrink: "Американо", priceDrink: "300 ₽")
        let drinkThree = Drink(nameDrink: "Американо", priceDrink: "328 ₽")
        let drinkFour = Drink(nameDrink: "Американо", priceDrink: "210 ₽")
        let drinkFive = Drink(nameDrink: "Американо", priceDrink: "190 ₽")
        let drinkSix = Drink(nameDrink: "Американо", priceDrink: "90 ₽")
        let drinkSeven = Drink(nameDrink: "Американо", priceDrink: "80 ₽")
        shoppingCartTableView.backgroundColor = .white
        drinks.append(contentsOf: [drinkOne, drinkTwo, drinkThree, drinkFour, drinkFive, drinkSix, drinkSeven ])
        shoppingCartTableView.showsVerticalScrollIndicator = false
        shoppingCartTableView.allowsSelection = false
        shoppingCartTableView.register(ShoppingCartTableViewCell.self, forCellReuseIdentifier: String(describing: ShoppingCartTableViewCell.self))
    }
    
    @objc func closeVC() {
        dismiss(animated: true)
        print("TAPPED dismissViewControllerButton")
    }
    
    @objc func cleaningDrinks() {
        present(createAlertController(), animated: true)
    }
    
    func createAlertController() -> UIAlertController{
        let alertController = UIAlertController(title: "Все товары из корзины будут удалены", message: nil , preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Все товары из корзины будут удалены", style: .destructive) { action in
            self.drinks.removeAll()
            DispatchQueue.main.async {
                self.shoppingCartTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}

// MARK: - UITableViewDataSource
extension ShoppingCartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ShoppingCartTableViewCell.self), for: indexPath) as? ShoppingCartTableViewCell else {return UITableViewCell()}
        cell.configure(drink: drinks[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ShoppingCartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIConstants.heightCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            drinks.remove(at: indexPath.row)
            shoppingCartTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
