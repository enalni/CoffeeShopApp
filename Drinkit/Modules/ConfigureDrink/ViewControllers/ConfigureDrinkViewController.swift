import UIKit

final class ConfigureDrinkViewController: UIViewController {
    
    // MARK: - Private property
    private var collectionView: UICollectionView!
    private var layout = UICollectionViewFlowLayout()
    private var drinkAdditives: [Additivies] = .init()
    private let transition = PanelTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: Private Methods
private extension ConfigureDrinkViewController {
    func initialize() {
        configureCollectionView()
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureCollectionView() {
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ConfigureDrinkCollectionCell.self, forCellWithReuseIdentifier: String(describing: ConfigureDrinkCollectionCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate
extension ConfigureDrinkViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension ConfigureDrinkViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ConfigureDrinkCollectionCell.self), for: indexPath) as? ConfigureDrinkCollectionCell else {return UICollectionViewCell()}
        cell.delegateOpen = self
        return cell
    }
}

extension ConfigureDrinkViewController: ViewControllerPresentDelegate{
    func viewControllerPresent(_controller: UIViewController) {
        if let configVc = _controller as? ConfigDrinkAdditivesViewController {
            configVc.transitioningDelegate = transition
            configVc.modalPresentationStyle = .custom
            present(configVc, animated: true)
        } else {
            present(_controller, animated: true)
            
        }
    }
}
