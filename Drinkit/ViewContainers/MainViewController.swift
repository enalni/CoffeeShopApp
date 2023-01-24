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
        
        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
        
        view.addSubviews(avPlayerView)
        avPlayerView.addSubview(customSegmnetControl)
        
        customSegmnetControl.translatesAutoresizingMaskIntoConstraints = false
        avPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customSegmnetControl.topAnchor.constraint(equalTo: avPlayerView.topAnchor),
            customSegmnetControl.leftAnchor.constraint(equalTo: avPlayerView.leftAnchor),
            customSegmnetControl.rightAnchor.constraint(equalTo: avPlayerView.rightAnchor),
            customSegmnetControl.heightAnchor.constraint(equalToConstant: view.bounds.height/6),
            
            avPlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            avPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -50),
            avPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 50),
            avPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

    }
    
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        let logoBarButtonItem =  UIBarButtonItem(customView: DrinkitView())
        return [logoBarButtonItem]
    }
    
    func makeRightBarButtonItem() -> UIBarButtonItem {
        let loginView = UIBarButtonItem(customView: LoginViewButton())
        let taped = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        loginView.customView?.addGestureRecognizer(taped)
        return loginView
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let vc = AutorizationViewController()
            vc.modalPresentationStyle = .popover
            present(vc, animated: true)
            dismiss(animated: true)
        }
   }
}

