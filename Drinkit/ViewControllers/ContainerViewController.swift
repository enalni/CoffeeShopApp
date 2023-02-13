//
//  ContainerViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 09.02.2023.
//

import UIKit

final class ContainerViewController: UIViewController {
    
    //MARK: - Private property
    private var avVC: UIViewController!
    let viewC = AVPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

}
//MARK: - Private methods
private extension ContainerViewController {
    func initialize() {
        viewC.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewC)
        
        NSLayoutConstraint.activate([
            viewC.topAnchor.constraint(equalTo: view.topAnchor),
            viewC.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewC.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewC.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
//        configAVPlayerViewController()
    }
    
//    func configAVPlayerViewController() {
//        let coffeeOne = CoffeeViewModel(coffeeName: "Дрип-пакет Эфиопия", coffeePrice: "120", videoFileName: "drip")
//        let vc = AVPlayerViewViewController(with: coffeeOne)
//        avVC = vc
//        add(avVC)
//    }
}
