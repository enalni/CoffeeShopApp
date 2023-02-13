//
//  CoffeeShopLocationViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 26.01.2023.
//

import UIKit

final class CoffeeShopLocationViewController: UIViewController {
    
    //MARK: Private property
    private let mockImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "drinKitMockImageLocation")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliaze()
    }
}

//MARK: - Private methods
private extension CoffeeShopLocationViewController {
    func initiliaze() {
    
        view.addSubviews(mockImageView)
        
        NSLayoutConstraint.activate([
            mockImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mockImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mockImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mockImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

