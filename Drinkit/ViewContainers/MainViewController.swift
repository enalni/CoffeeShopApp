//
//  ViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 18.01.2023.
//

import UIKit
import SnapKit
import AVKit

class MainViewController: UIViewController {
    
    //MARK: Private property
    let customSegmnetControl = CustomSegmnetControl()
    let avPlayerView = AVPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliaze()
    }
}

//MARK: - Private methods

private extension MainViewController {
    func initiliaze() {
        
        view.backgroundColor = UIColor(named: "backroundColor")
        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
//        navigationController?.navigationBar.backgroundColor = .systemGray2
        navigationController?.navigationBar.alpha = 0.5
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
        
        view.addSubviews(avPlayerView)
        avPlayerView.addSubview(customSegmnetControl)
        
        customSegmnetControl.translatesAutoresizingMaskIntoConstraints = false
        avPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customSegmnetControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            customSegmnetControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            customSegmnetControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            customSegmnetControl.heightAnchor.constraint(equalToConstant: 50),
            
            avPlayerView.topAnchor.constraint(equalTo: customSegmnetControl.bottomAnchor, constant: 5),
            avPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            avPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            avPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

    }
    
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        let logoBarButtonItem =  UIBarButtonItem(customView: DrinkitView())
        return [logoBarButtonItem]
    }
    
    func makeRightBarButtonItem() -> UIBarButtonItem {
        let loginView = UIBarButtonItem(customView: LoginViewButton())
        return loginView
    }
}

