//
//  AVPlayerView.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.01.2023.
//

import UIKit
import AVKit

class AVPlayerView: UIView {
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private constraint
    private enum UIConstants {
        static let cornerRadiusSet: CGFloat =  35
    }
    
    //MARK: - Private property
    private let playerViewController: AVPlayerViewController = {
        let player = AVPlayerViewController()
        //        player.view.layer.masksToBounds = false
        player.view.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    private let nameCoffeeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "nameCoffeeColorForLabel")
        label.text = "Дрип-пакет Эфиопия"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.contentMode = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceCoffeeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "colorPriceCoffeeButton")
        button.setTitle("+70 ₽", for: .normal)
        button.setTitleColor(UIColor(named: "colorText"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return button
    }()
    
    private let addFlavorButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "colorAddFlavorButton")
        button.setTitle(" вкус", for: .normal)
        let image = UIImageView.init(image: UIImage(named: "wand.and.stars")?.withTintColor(.white, renderingMode: .alwaysTemplate))
        button.setTitleColor(UIColor(named: "colorText"), for: .normal)
        button.setImage(image.image, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return button
    }()
    
    private lazy var xStackButtons: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceCoffeeButton, addFlavorButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let shoppingCartView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = UIConstants.cornerRadiusSet
        view.clipsToBounds = true
        view.addBlurredBackground(style: .systemChromeMaterialDark)
        return view
    }()
    
    private let shoppingCardSummaLabel: UILabel = {
        let label = UILabel()
        label.text = "+70 ₽"
        label.contentMode = .center
        label.textColor = UIColor(named: "colorText")
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageViewShoppingCar: UIImageView = {
        let imageView =  UIImageView()
        let image = UIImage(named: "americano")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "colorShoppingCartImageView")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var xStackShoppingCart: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shoppingCardSummaLabel, imageViewShoppingCar])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var collectionView: UICollectionView!
}
//MARK: - Private methods
private extension AVPlayerView {
    func initialize() {
        
        configPlayer()
        configShoppingCart()
        
        let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionView.register(CoffeeCollectionCell.self, forCellWithReuseIdentifier: String(describing: CoffeeCollectionCell.self))
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemYellow
        
        
        addSubview(playerViewController.view)
        addSubview(nameCoffeeLabel)
        addSubview(xStackButtons)
        addSubview(collectionView)
        addSubview(shoppingCartView)
        shoppingCartView.addSubview(xStackShoppingCart)
        
        NSLayoutConstraint.activate([
            playerViewController.view.topAnchor.constraint(equalTo: self.topAnchor),
            playerViewController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameCoffeeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -200),
            nameCoffeeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            nameCoffeeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            nameCoffeeLabel.heightAnchor.constraint(equalToConstant: 100),
            
            xStackButtons.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150),
            xStackButtons.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            xStackButtons.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            xStackButtons.heightAnchor.constraint(equalToConstant: 65),
            
            shoppingCartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70),
            shoppingCartView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 140),
            shoppingCartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -140),
            shoppingCartView.heightAnchor.constraint(equalToConstant: 65),
            
            xStackShoppingCart.topAnchor.constraint(equalTo: shoppingCartView.topAnchor, constant: 5),
            xStackShoppingCart.leadingAnchor.constraint(equalTo: shoppingCartView.leadingAnchor,constant: 10),
            xStackShoppingCart.trailingAnchor.constraint(equalTo: shoppingCartView.trailingAnchor, constant: -5),
            xStackShoppingCart.bottomAnchor.constraint(equalTo: shoppingCartView.bottomAnchor, constant: -5),
            
            collectionView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
    
    func configPlayer() {
        guard let path = Bundle.main.path(forResource: "drip", ofType:"MP4") else {
            debugPrint("video.m4v not found")
            return
        }
        let templItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        let player = AVPlayer(playerItem: templItem)
        playerViewController.player = player
        playerViewController.videoGravity = .resize
        player.play()
    }
    
    func configShoppingCart() {
        self.shoppingCartView.addBlurredBackground(style: .prominent)
    }
}

//MARK: - UICollectionViewDataSource
extension AVPlayerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CoffeeCollectionCell.self), for: indexPath) as? CoffeeCollectionCell else {return UICollectionViewCell()}
        //        cell.config()
        return cell
    }
    
    
}
