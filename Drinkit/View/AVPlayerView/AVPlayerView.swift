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
        
    }
    
    //MARK: - Private property
    private let playerViewController: AVPlayerViewController = {
        let player = AVPlayerViewController()
        player.view.layer.masksToBounds = false
        player.view.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
}
//MARK: - Private methods
private extension AVPlayerView {
    func initialize() {
        guard let path = Bundle.main.path(forResource: "cof1", ofType:"mp4") else {
             debugPrint("video.m4v not found")
             return
         }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerViewController.player = player
        playerViewController.modalPresentationStyle = .fullScreen
        player.play()
        
        addSubview(playerViewController.view)
        NSLayoutConstraint.activate([
            playerViewController.view.topAnchor.constraint(equalTo: self.topAnchor),
            playerViewController.view.leftAnchor.constraint(equalTo: self.leftAnchor),
            playerViewController.view.rightAnchor.constraint(equalTo: self.rightAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
