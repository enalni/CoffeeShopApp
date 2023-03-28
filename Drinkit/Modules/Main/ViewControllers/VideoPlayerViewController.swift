//
//  PlayerVC.swift
//  Drinkit
//
//  Created by Александр Николаевич on 22.02.2023.
//

import AVKit

final class VideoPlayerViewController: AVPlayerViewController {
    
    // MARK: Public func
    func configure(nameVideo: String) {
        configureVideoPlayback(nameVideo: nameVideo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        configInfiniteLoopVideo()
    }
}

// MARK: Private Methods
private extension VideoPlayerViewController {
    
    func initialize() {
        view.backgroundColor = .clear
        showsPlaybackControls = false
        view.isUserInteractionEnabled = false
        videoGravity = .resize
    }
    
    func configureVideoPlayback(nameVideo: String){
        guard let path = Bundle.main.path(forResource: nameVideo, ofType:"MP4") else {
            debugPrint("video.m4v not found")
            return
        }
        let templItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        let player = AVPlayer(playerItem: templItem)
        player.isMuted = true
        self.player = player
        player.play()
    }
    
    func configInfiniteLoopVideo() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: nil) { (_) in
            self.player?.seek(to: CMTime.zero)
            self.player?.play()
        }
    }
}
