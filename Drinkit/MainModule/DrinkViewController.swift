//
//  TemPlateVC.swift
//  Drinkit
//
//  Created by Александр Николаевич on 22.02.2023.
//

import UIKit

final class DrinkViewController: UIViewController {
    
    //MARK: Public Func
    func configure(coffee:CoffeeViewModel) {
        self.coffee = coffee
    }
    
    // MARK: - Private property
    private var informationOfDrinkView: InformationOfDrinkView = .init()
    private var videoPlayerViewController: VideoPlayerViewController = .init()
    private var coffee: CoffeeViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

//MARK: Private methods
private extension DrinkViewController {
    func initialize() {
        
        addVideoPlayerViewControllerToHierarchy()
        configPriceAndNamingDrink()
        
        view.addSubview(informationOfDrinkView)
        
        informationOfDrinkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            informationOfDrinkView.topAnchor.constraint(equalTo: view.topAnchor),
            informationOfDrinkView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            informationOfDrinkView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            informationOfDrinkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func addVideoPlayerViewControllerToHierarchy() {
        let videoPlayerVC = VideoPlayerViewController()
        videoPlayerVC.view.frame = view.bounds
        videoPlayerVC.configure(nameVideo: coffee.videoFileName)
        videoPlayerViewController = videoPlayerVC
        add(videoPlayerViewController)
    }
    
    func configPriceAndNamingDrink() {
        informationOfDrinkView.configure(with: coffee)
    }
}
