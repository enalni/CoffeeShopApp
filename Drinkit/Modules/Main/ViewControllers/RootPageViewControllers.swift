import UIKit

protocol ViewControllerCancelDelegate: AnyObject {
    func viewControllerDidCancel(_controller: UIViewController)
}

protocol CustomSegmentControlTappedDelegate: AnyObject {
    func collectionViewTapped(_ index: Int)
}

final class RootPageViewControllers: UIPageViewController {
    
    // MARK: Private property
    private let customSegmentControl: CustomSegmentControlView = .init()
    private let shoppingCartView: ShoppingCartView = .init()
    var coffeeHelpers:[CoffeeViewModel] = .init()
    var drinksHelpers:[[Drink]] = .init()
    private var shoppingCartViewBottomConstraint = NSLayoutConstraint()
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let heightShoppingCartView: CGFloat = 60
        static let widthShoppingCartView: CGFloat = 200
        static let hidingConstraintShoppingCartView: CGFloat = 150
        static let showConstraintShoppingCartView: CGFloat = -90
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMockData()
        initialize()
    }
    
    lazy var coffeeViewControllers: [DrinkViewController] = {
        var arrayViewControllers = [DrinkViewController]()
        for (coffee, drink) in zip(coffeeHelpers, drinksHelpers) {
            let viewController = DrinkViewController()
            viewController.contenVC.delegate = self
            viewController.informationOfDrinkView.delegate = self
            viewController.informationOfDrinkView.delegatePresentViewController = self
            viewController.configure(coffee: coffee, drink: drink)
            arrayViewControllers.append(viewController)
        }
        return arrayViewControllers
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        view.addBlurredBackground(style: .systemUltraThinMaterialDark)
        self.dataSource = self
        setViewControllers([coffeeViewControllers[0]], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private extensions
private extension RootPageViewControllers {
    func initialize() {
        
        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
        
        view.addSubview(customSegmentControl)
        view.addSubview(shoppingCartView)
        
        customSegmentControl.delegate = self
        shoppingCartView.delegatePresentViewController = self
        
        customSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        shoppingCartView.translatesAutoresizingMaskIntoConstraints = false
        
        shoppingCartViewBottomConstraint = shoppingCartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: UIConstants.hidingConstraintShoppingCartView)
        
        NSLayoutConstraint.activate([
            customSegmentControl.topAnchor.constraint(equalTo: view.topAnchor),
            customSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customSegmentControl.heightAnchor.constraint(equalToConstant: view.bounds.height/6),
            
            shoppingCartViewBottomConstraint,
            shoppingCartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shoppingCartView.heightAnchor.constraint(equalToConstant: UIConstants.heightShoppingCartView),
            shoppingCartView.widthAnchor.constraint(equalToConstant: UIConstants.widthShoppingCartView),
        ])
        
    }
    
    func getMockData() {
        coffeeHelpers.append(contentsOf: createMockCoffeeViewModel())
        drinksHelpers.append(contentsOf: createMockDrinks())
    }
    
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        let logoBarButtonItem =  UIBarButtonItem(customView: LocationView())
        let tapped = UITapGestureRecognizer(target: self, action: #selector(leftButtonTapped))
        logoBarButtonItem.customView?.addGestureRecognizer(tapped)
        return [logoBarButtonItem]
    }
    
    func makeRightBarButtonItem() -> UIBarButtonItem {
        let loginView = UIBarButtonItem(customView: LoginViewButtonView())
        let tapped = UITapGestureRecognizer(target: self, action: #selector(rightButtonTapped))
        loginView.customView?.addGestureRecognizer(tapped)
        return loginView
    }
    
    @objc func rightButtonTapped(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let vc = AuthorizationViewController()
            vc.delegate = self
            present(vc, animated: true)
            print("TAPPED rightBarButtonItem")
        }
    }
    
    @objc func leftButtonTapped(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let vc = CoffeeShopLocationViewController()
            vc.delegate = self
            present(vc, animated: true)
            print("TAPPED leftBarButtonItem")
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension RootPageViewControllers: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? DrinkViewController else {return nil}
        if let index = coffeeViewControllers.firstIndex(of: viewController) {
            if index > 0 {
                return coffeeViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? DrinkViewController else {return nil}
        if let index = coffeeViewControllers.firstIndex(of: viewController) {
            if index < coffeeViewControllers.count - 1 {
                return coffeeViewControllers[index + 1]
            }
        }
        return nil
    }
}

// MARK: - ViewControllerCancelDelegate
extension RootPageViewControllers: ViewControllerCancelDelegate {
    func viewControllerDidCancel(_controller controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}

// MARK: - ShoppingCartViewControllerDelegate
extension RootPageViewControllers: ViewControllerPresentDelegate {
    func viewControllerPresent(_controller: UIViewController) {
        if let shoppingCartViewcontroller = _controller as? ShoppingCartViewController {
            present(shoppingCartViewcontroller, animated: true)
        }
        else {
            navigationItem.backBarButtonItem = UIBarButtonItem()
            navigationController?.pushViewController(_controller, animated: true)
        }
    }
}

// MARK: - CustomSegmentControlTappedDelegate
extension RootPageViewControllers: CustomSegmentControlTappedDelegate {
    func collectionViewTapped(_ index: Int) {
        setViewControllers([coffeeViewControllers[index]], direction: .forward, animated: true)
    }
}

// MARK: - ShoppingCartViewDelegate
extension RootPageViewControllers: ShoppingCartViewDelegate {
    func updatePriceShoppingCartView(_price: String) {
        shoppingCartViewBottomConstraint.constant = UIConstants.showConstraintShoppingCartView
        self.shoppingCartView.configure(_price)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
