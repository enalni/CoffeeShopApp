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
    
    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = self.view.bounds
        scroll.contentSize = contentSize
        scroll.backgroundColor = .clear
        scroll.alpha = 0.4
        scroll.showsVerticalScrollIndicator = false
//        scroll.contentInset = UIEdgeInsets(top: 0, left: 13, bottom: 13, right: 13)
        return scroll
    }()
    
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width,
               height: view.frame.height)
    }
    
    private var collectionView: UICollectionView!
    
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
        
        let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionView.register(CoffeeCollectionCell.self, forCellWithReuseIdentifier: String(describing: CoffeeCollectionCell.self))
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemYellow
        
        view.addSubviews(avPlayerView)
        avPlayerView.addSubview(customSegmnetControl)
        
//        view.addSubview(scroll)
//        scroll.addSubview(contentView)
//        contentView.addSubview(collectionView)
        
        customSegmnetControl.translatesAutoresizingMaskIntoConstraints = false
        avPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customSegmnetControl.topAnchor.constraint(equalTo: avPlayerView.topAnchor),
            customSegmnetControl.leftAnchor.constraint(equalTo: avPlayerView.leftAnchor),
            customSegmnetControl.rightAnchor.constraint(equalTo: avPlayerView.rightAnchor),
            customSegmnetControl.heightAnchor.constraint(equalToConstant: view.bounds.height/6),
            
            avPlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            avPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            avPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            avPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            contentView.topAnchor.constraint(equalTo: scroll.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
//
//            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.bounds.height/3),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
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

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CoffeeCollectionCell.self), for: indexPath) as? CoffeeCollectionCell else {return UICollectionViewCell()}
        //        cell.config()
        return cell
    }
    
    
}

