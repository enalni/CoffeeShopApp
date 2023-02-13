//
//  AVPlayerView.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.01.2023.
//

import UIKit
import AVKit

final class AVPlayerView: UIView {
    //MARK: - Public func
    func configure(with coffeHelpers: CoffeeViewModel) {
        self.nameCoffeeLabel.text = coffeHelpers.coffeeName
        configPriceButton(price: coffeHelpers.coffeePrice)
        configPlayer(nameVideo: coffeHelpers.videoFileName)
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
        
        static let cornerRadiusSet: CGFloat =  25
        static let leadingSet: CGFloat = 16
        static let trailingSet: CGFloat = -16
        
        static let sizeFontNameCoffeeLabel: CGFloat = 32
        static let sizeFontPriceCoffeeButton: CGFloat = 30
        static let sizeFontAddFlavorButton: CGFloat = 30
        static let sizeFontShoppingCardSummaLabel: CGFloat = 25
        
        static let spacingXStackButtons: CGFloat = 15
        
        static let countNumberOfLines: Int = 0
        
        static let heightNameCoffeeLabel: CGFloat = 60
        static let heightXStackButtons: CGFloat = 60
        
        static let bottomNameCoffeeLabel: CGFloat = -220
        static let bottomXStackButtons: CGFloat = -160
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
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontNameCoffeeLabel)
        label.contentMode = .center
        label.numberOfLines = UIConstants.countNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceCoffeeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "colorPriceCoffeeButton")
        button.setTitleColor(UIColor(named: "colorText"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontPriceCoffeeButton)
        return button
    }()
    
    private let gradienLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let colors = [UIColor.purple.cgColor, UIColor.systemYellow.cgColor]
        gradient.colors = colors
        return gradient
    }()
        
    private let addFlavorButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        let color = UIColor(named: "colorAddFlavorButton")?.cgColor
        button.setTitle(" вкус", for: .normal)
        button.tintColor = .white
        let image = UIImage(systemName: "wand.and.stars")
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontAddFlavorButton)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var xStackButtons: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceCoffeeButton, addFlavorButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = UIConstants.spacingXStackButtons
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func layoutSubviews() {
        configGradient()
    }
    
}
//MARK: - Private methods
private extension AVPlayerView {
    func initialize() {
        
        configInfiniteLoopVideo()
        
        addSubview(playerViewController.view)
        addSubview(nameCoffeeLabel)
        addSubview(xStackButtons)
        
        addFlavorButton.addTarget(self, action: #selector(tappedAddFlavorButton), for: .touchUpInside)
        priceCoffeeButton.addTarget(self, action: #selector(tappedPriceCoffeeButton(sender:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            playerViewController.view.topAnchor.constraint(equalTo: self.topAnchor),
            playerViewController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameCoffeeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: UIConstants.bottomNameCoffeeLabel),
            nameCoffeeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.leadingSet),
            nameCoffeeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.trailingSet),
            nameCoffeeLabel.heightAnchor.constraint(equalToConstant: UIConstants.heightNameCoffeeLabel),
            
            xStackButtons.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: UIConstants.bottomXStackButtons),
            xStackButtons.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.leadingSet),
            xStackButtons.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.trailingSet),
            xStackButtons.heightAnchor.constraint(equalToConstant: UIConstants.heightXStackButtons),
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
    
    func configGradient() {
        gradienLayer.frame = addFlavorButton.bounds
        addFlavorButton.layer.insertSublayer(gradienLayer, at: 0)
    }
    
    @objc
    func tappedAddFlavorButton () {
        print("TAPPED AddFlavorButton ")
    }
    
    @objc
    func tappedPriceCoffeeButton (sender: UIButton) {
        print("TAPPED priceCoffeeButton ")
    }
}
