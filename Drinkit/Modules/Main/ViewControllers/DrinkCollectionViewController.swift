import UIKit

final class DrinkCollectionViewController: UIViewController {
    // MARK: - Public Func
    func configure(drinks: [Drink]) {
        self.drinks = drinks
    }
    
    // MARK: Private property
    var collectionView: UICollectionView!
    private var drinks: [Drink] = .init()
    weak var delegate: ShoppingCartViewDelegate?
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let collectionTopAndLeading: CGFloat = 10
        static let collectionTrailingAndBottom: CGFloat = -10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliaze()
    }
}
// MARK: - Private methods
private extension DrinkCollectionViewController {
    func initiliaze() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(DrinkCollectionCell.self, forCellWithReuseIdentifier: String(describing: DrinkCollectionCell.self))
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.collectionTopAndLeading),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.collectionTopAndLeading),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.collectionTrailingAndBottom),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: UIConstants.collectionTrailingAndBottom),
        ])
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: createSection())
        return layout
    }
    
    func createSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                            heightDimension: .fractionalHeight(1)))
        item.contentInsets.leading = 16
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 16
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .fractionalHeight(0.35)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

// MARK: - UICollectionViewDataSource
extension DrinkCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DrinkCollectionCell.self), for: indexPath) as? DrinkCollectionCell else {return UICollectionViewCell()}
        cell.delegate = self
        cell.config(drink: drinks[indexPath.row])
        return cell
    }
}

// MARK: - ShoppingCartViewDelegate
extension DrinkCollectionViewController: ShoppingCartViewDelegate {
    func updatePriceShoppingCartView(_price: String) {
        delegate?.updatePriceShoppingCartView(_price: _price)
    }
}
