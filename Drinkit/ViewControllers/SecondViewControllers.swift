//
//  SecondViewControllers.swift
//  Drinkit
//
//  Created by Александр Николаевич on 28.01.2023.


import UIKit
import FloatingPanel

class SecondViewControllers: UIViewController {
    
    //MARK: Private property
    private let customSegmnetControl = CustomSegmnetControl()
    private let avPlayerView = AVPlayerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliaze()
    }
}

//MARK: - Private methods
private extension SecondViewControllers {
    func initiliaze() {
        
        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
        
        view.addSubview(avPlayerView)
        view.addSubview(customSegmnetControl)
        
        customSegmnetControl.translatesAutoresizingMaskIntoConstraints = false
        avPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customSegmnetControl.topAnchor.constraint(equalTo: view.topAnchor),
            customSegmnetControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            customSegmnetControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            customSegmnetControl.heightAnchor.constraint(equalToConstant: 150),
            
            avPlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            avPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            avPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            avPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
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
}

