//
//  AVPlayerViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 18.01.2023.
//

import UIKit
import FloatingPanel

final class AVPlayerViewViewController: UIViewController {
    
    var avPlayerView = AVPlayerView()
    
    init(with coffeHelper: CoffeeViewModel) {
        super.init(nibName: nil, bundle: nil)
        initiliaze()
        self.avPlayerView.configure(with: coffeHelper)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension AVPlayerViewViewController {
    func initiliaze() {
    
        view.addSubview(avPlayerView)
        
        avPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avPlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            avPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            avPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

