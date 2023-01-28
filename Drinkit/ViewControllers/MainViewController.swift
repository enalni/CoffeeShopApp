//
//  ViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 18.01.2023.
//

import UIKit
import FloatingPanel

class MainViewController: UIViewController {
    
    private var avPlayerView = AVPlayerView()
    
    init(with coffeHelper: CoffeeHelper) {
        super.init(nibName: nil, bundle: nil)
        initiliaze()
        self.avPlayerView.configure(with: coffeHelper)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension MainViewController {
    func initiliaze() {
    
        view.addSubview(avPlayerView)
        
        avPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avPlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            avPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            avPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            avPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

