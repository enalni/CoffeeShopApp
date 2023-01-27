//
//  CoffeeShopLocationViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 26.01.2023.
//

import UIKit
import SnapKit

class CoffeeShopLocationViewController: UIViewController {
    
    //MARK: Private property
    private let mockImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "drinKitMockImageLocation")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
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
        
        mockImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

