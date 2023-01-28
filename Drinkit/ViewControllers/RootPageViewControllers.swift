//
//  RootPageViewControllers.swift
//  Drinkit
//
//  Created by Александр Николаевич on 28.01.2023.
//

import UIKit
import FloatingPanel

class RootPageViewControllers: UIPageViewController {
    
    //MARK: Private property
    private let customSegmnetControl = CustomSegmnetControl()
    var coffeeHelpers = [CoffeeHelper]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        createMockCoffee()
        makeFloatingPanelController()
    }
    
    lazy var coffeeViewControllers: [MainViewController] = {
        var arrayViewControllers = [MainViewController]()
        for coffee in coffeeHelpers {
            let vc = MainViewController(with: coffee)
            arrayViewControllers.append(MainViewController(with: coffee))
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
        
        view.addSubview(customSegmnetControl)
        
        customSegmnetControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customSegmnetControl.topAnchor.constraint(equalTo: view.topAnchor),
            customSegmnetControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            customSegmnetControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            customSegmnetControl.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    
    func createMockCoffee() {
        let coffeeOne = CoffeeHelper(nameCoffee: "Дрип-пакет Эфиопия", priceCoffee: "70", nameVideo: "drip")
        let coffeeTwo = CoffeeHelper(nameCoffee: "Пуэр", priceCoffee: "150", nameVideo: "drip2")
        let coffeeThree = CoffeeHelper(nameCoffee: "Аромат кофе", priceCoffee: "99", nameVideo: "coffee1")
        let coffeeFour = CoffeeHelper(nameCoffee: "Американо", priceCoffee: "150", nameVideo: "coffee2")
        let coffeeFive = CoffeeHelper(nameCoffee: "Заваренная с любовью дрипка", priceCoffee: "199", nameVideo: "coffee3")
        coffeeHelpers.append(contentsOf: [coffeeOne,coffeeTwo,coffeeThree,coffeeFour,coffeeFive])
    }
    
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        let logoBarButtonItem =  UIBarButtonItem(customView: DrinkitView())
        let taped = UITapGestureRecognizer(target: self, action: #selector(leftButtonTaped))
        logoBarButtonItem.customView?.addGestureRecognizer(taped)
        return [logoBarButtonItem]
    }
    
    func makeRightBarButtonItem() -> UIBarButtonItem {
        let loginView = UIBarButtonItem(customView: LoginViewButton())
        let taped = UITapGestureRecognizer(target: self, action: #selector(rightButtonTaped))
        loginView.customView?.addGestureRecognizer(taped)
        return loginView
    }
    
    @objc func rightButtonTaped(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let vc = AutorizationViewController()
            vc.modalPresentationStyle = .popover
            present(vc, animated: true)
            print("DEBUG: TAPED rightBarButtonItem ")
        }
    }
    
    @objc func leftButtonTaped(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let vc = CoffeeShopLocationViewController()
            vc.modalPresentationStyle = .popover
            present(vc, animated: true)
            print("DEBUG: TAPED leftBarButtonItem")
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

// MARK: - FloatingPanelLayout
class FloatingPanelStocksLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 50, edge: .top, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 65, edge: .bottom, referenceGuide: .safeArea),
    ]
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}

// MARK: FloatingPanelControllerDelegate
extension RootPageViewControllers: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return FloatingPanelStocksLayout()
    }
}


extension RootPageViewControllers: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MainViewController else {return nil}
        if let index = coffeeViewControllers.firstIndex(of: viewController) {
            if index > 0 {
                return coffeeViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MainViewController else {return nil}
        if let index = coffeeViewControllers.firstIndex(of: viewController) {
            if index < coffeeViewControllers.count - 1 {
                return coffeeViewControllers[index + 1]
            }
        }
        return nil
    }
}
