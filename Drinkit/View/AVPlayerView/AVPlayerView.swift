//
//  AVPlayerView.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.01.2023.
//

import UIKit
import AVKit
import AudioToolbox

class AVPlayerView: UIView {
    //MARK: - Public func
    func configure(with coffeHelpers: CoffeeHelper) {
        self.nameCoffeeLabel.text = coffeHelpers.nameCoffee
        configPriceButton(price: coffeHelpers.priceCoffee)
        configPlayer(nameVideo: coffeHelpers.nameVideo)
    }
    
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
        static let cornerRadiusSet: CGFloat =  30
    }
    
    //MARK: - Private property
    let playerViewController: AVPlayerViewController = {
        let player = AVPlayerViewController()
        player.view.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    private var nameCoffeeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "nameCoffeeColorForLabel")
        label.text = "Дрип-пакет Эфиопия"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.contentMode = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceCoffeeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "colorPriceCoffeeButton")
        button.setTitleColor(UIColor(named: "colorText"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return button
    }()
    
    private let addFlavorButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        let color = UIColor(named: "colorAddFlavorButton")?.cgColor
        button.backgroundColor = UIColor(named: "colorAddFlavorButton")
        button.setTitle(" вкус", for: .normal)
        button.tintColor = .white
        let image = UIImage(systemName: "wand.and.stars")
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return button
    }()
    
    private lazy var xStackButtons: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceCoffeeButton, addFlavorButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
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
    
}
//MARK: - Private methods
private extension AVPlayerView {
    func initialize() {
        
        configShoppingCart()
        configInfiniteLoopVideo()
        
        addSubview(playerViewController.view)
        addSubview(nameCoffeeLabel)
        addSubview(xStackButtons)
        addSubview(shoppingCartView)
        shoppingCartView.addSubview(xStackShoppingCart)
        
        self.addFlavorButton.addTarget(self, action: #selector(tapedAddFlavorButton), for: .touchUpInside)
        self.priceCoffeeButton.addTarget(self, action: #selector(tapedPriceCoffeeButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            playerViewController.view.topAnchor.constraint(equalTo: self.topAnchor),
            playerViewController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameCoffeeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -200),
            nameCoffeeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameCoffeeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameCoffeeLabel.heightAnchor.constraint(equalToConstant: 100),
            
            xStackButtons.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150),
            xStackButtons.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            xStackButtons.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            xStackButtons.heightAnchor.constraint(equalToConstant: 55),
            
            //            shoppingCartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 70),
            shoppingCartView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            shoppingCartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            shoppingCartView.heightAnchor.constraint(equalToConstant: 65),
            
            xStackShoppingCart.topAnchor.constraint(equalTo: shoppingCartView.topAnchor, constant: 5),
            xStackShoppingCart.leadingAnchor.constraint(equalTo: shoppingCartView.leadingAnchor,constant: 10),
            xStackShoppingCart.trailingAnchor.constraint(equalTo: shoppingCartView.trailingAnchor, constant: -5),
            xStackShoppingCart.bottomAnchor.constraint(equalTo: shoppingCartView.bottomAnchor, constant: -5),
        ])
    }
    
    func configPlayer(nameVideo: String) {
        guard let path = Bundle.main.path(forResource: nameVideo, ofType:"MP4") else {
            debugPrint("video.m4v not found")
            return
        }
        let templItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        let player = AVPlayer(playerItem: templItem)
        playerViewController.player = player
        playerViewController.view.isUserInteractionEnabled = false
        player.isMuted = true
        playerViewController.videoGravity = .resize
        player.play()
    }
    
    func configShoppingCart() {
        self.shoppingCartView.addBlurredBackground(style: .prominent)
    }
    
    func configPriceButton(price: String) {
        let price = " + \(price) ₽"
        self.priceCoffeeButton.setTitle(price, for: .normal)
    }
    
    func configInfiniteLoopVideo() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerViewController.player?.currentItem, queue: nil) { (_) in
            self.playerViewController.player?.seek(to: CMTime.zero)
            self.playerViewController.player?.play()
        }
    }
    
    @objc
    func tapedAddFlavorButton () {
        print("TAPED AddFlavorButton ")
    }
    
    @objc
    func tapedPriceCoffeeButton () {
        print("TAPED priceCoffeeButton ")
        let animator = UIViewPropertyAnimator(duration:1, curve: .easeInOut) {
            self.shoppingCartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70).isActive = true
        }
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        animator.startAnimation()
    }
}
