import UIKit
import FloatingPanel

final class DrinkViewController: UIViewController {
    // MARK: Public Func
    func configure(coffee:CoffeeViewModel, drink: [Drink]) {
        self.coffeeViewModel = coffee
        self.drink = drink
    }
    
    // MARK: - Private property
    var informationOfDrinkView: InformationOfDrinkView = .init()
    private var videoPlayerViewController: VideoPlayerViewController = .init()
    var contenVC: DrinkCollectionViewController = .init()
    private var coffeeViewModel: CoffeeViewModel = .init()
    private var drink: [Drink] = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        makeFloatingPanelController()
    }
}

// MARK: Private methods
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
        videoPlayerVC.configure(nameVideo: coffeeViewModel.videoFileName)
        videoPlayerViewController = videoPlayerVC
        add(videoPlayerViewController)
    }
    
    func configPriceAndNamingDrink() {
        informationOfDrinkView.configure(with: coffeeViewModel)
    }
    
    // MARK: - makeFloatingPanelController
    func makeFloatingPanelController(){
        let floatPanel = FloatingPanelController()
        floatPanel.delegate = self
        contenVC.configure(drinks: drink)
        floatPanel.set(contentViewController: contenVC)
        floatPanel.surfaceView.backgroundColor = .clear
        floatPanel.track(scrollView: contenVC.collectionView)
        floatPanel.surfaceView.grabberHandle.isHidden = true
        floatPanel.surfaceView.addBlurredBackground(style: .systemUltraThinMaterialDark)
        floatPanel.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        floatPanel.addPanel(toParent: self)
    }
}

// MARK: FloatingPanelControllerDelegate
extension DrinkViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return FloatingPanelStocksLayout()
    }
}
