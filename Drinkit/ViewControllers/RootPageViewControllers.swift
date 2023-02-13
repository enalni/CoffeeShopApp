//
//  RootPageViewControllers.swift
//  Drinkit
//
//  Created by Александр Николаевич on 28.01.2023.
//

import UIKit
import FloatingPanel

final class RootPageViewControllers: UIPageViewController {
    
    //MARK: Private property
    private let customSegmentControl: CustomSegmentControl = .init()
    private let shoppingCartView: ShoppingCartView = .init()
    var coffeeHelpers = [CoffeeViewModel]()
    private var shoppingCart = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        createMockCoffee()
        makeFloatingPanelController()
    }
    
    lazy var coffeeViewControllers: [AVPlayerViewViewController] = {
        var arrayViewControllers = [AVPlayerViewViewController]()
        for coffee in coffeeHelpers {
            let vc = AVPlayerViewViewController(with: coffee)
            arrayViewControllers.append(AVPlayerViewViewController(with: coffee))
        }
        return arrayViewControllers
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        self.delegate = self
        view.addBlurredBackground(style: .systemUltraThinMaterialDark)
        self.dataSource = self
        setViewControllers([coffeeViewControllers[0]], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extensions
private extension RootPageViewControllers {
    func initialize() {
        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
        
        view.addSubview(customSegmentControl)
        view.addSubview(shoppingCartView)
        
        
        customSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        shoppingCartView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            customSegmentControl.topAnchor.constraint(equalTo: view.topAnchor),
            customSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customSegmentControl.heightAnchor.constraint(equalToConstant: view.bounds.height/6),
            
            shoppingCartView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            shoppingCartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shoppingCartView.heightAnchor.constraint(equalToConstant: 60),
            shoppingCartView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    func createMockCoffee() {
        let coffeeOne = CoffeeViewModel(coffeeName: "Дрип-пакет Эфиопия", coffeePrice: "120", videoFileName: "drip")
        let coffeeTwo = CoffeeViewModel(coffeeName: "Фильтр кофе", coffeePrice: "150", videoFileName: "drip2")
        let coffeeThree = CoffeeViewModel(coffeeName: "Заваренная с любовью дрипка", coffeePrice: "99", videoFileName: "coffee3")
        coffeeHelpers.append(contentsOf: [coffeeOne,coffeeTwo,coffeeThree])
    }
    
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        let logoBarButtonItem =  UIBarButtonItem(customView: DrinkitView())
        let tapped = UITapGestureRecognizer(target: self, action: #selector(leftButtonTapped))
        logoBarButtonItem.customView?.addGestureRecognizer(tapped)
        return [logoBarButtonItem]
    }
    
    func makeRightBarButtonItem() -> UIBarButtonItem {
        let loginView = UIBarButtonItem(customView: LoginViewButton())
        let tapped = UITapGestureRecognizer(target: self, action: #selector(rightButtonTapped))
        loginView.customView?.addGestureRecognizer(tapped)
        return loginView
    }
    
    @objc func rightButtonTapped(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let vc = AuthorizationViewController()
            vc.modalPresentationStyle = .popover
            present(vc, animated: true)
            debugPrint("DEBUG: TAPPED rightBarButtonItem ")
        }
    }
    
    @objc func leftButtonTapped(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let vc = CoffeeShopLocationViewController()
            vc.modalPresentationStyle = .popover
            present(vc, animated: true)
            debugPrint("DEBUG: TAPPED leftBarButtonItem")
        }
    }
    
    //MARK: - makeFloatingPanelController
    func makeFloatingPanelController(){
        let floatPanel = FloatingPanelController()
        floatPanel.delegate = self
        let contenVC = CoffeeCollectionViewController()
        floatPanel.set(contentViewController: contenVC)
        floatPanel.surfaceView.backgroundColor = .clear
        floatPanel.track(scrollView: contenVC.collectionView)
        floatPanel.surfaceView.grabberHandle.isHidden = true
        floatPanel.surfaceView.addBlurredBackground(style: .systemUltraThinMaterialDark)
        floatPanel.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        floatPanel.addPanel(toParent: self)
    }
}



// MARK: FloatingPanelControllerDelegate
extension RootPageViewControllers: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return FloatingPanelStocksLayout()
    }
}


//MARK: - UIPageViewControllerDataSource
extension RootPageViewControllers: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? AVPlayerViewViewController else {return nil}
        if let index = coffeeViewControllers.firstIndex(of: viewController) {
            if index > 0 {
                return coffeeViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? AVPlayerViewViewController else {return nil}
        if let index = coffeeViewControllers.firstIndex(of: viewController) {
            if index < coffeeViewControllers.count - 1 {
                return coffeeViewControllers[index + 1]
            }
        }
        return nil
    }
}

//MARK: - UIPageViewControllerDelegate
extension RootPageViewControllers: UIPageViewControllerDelegate {
    
}
