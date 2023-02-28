//
//  CoffeeCollectionViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 27.01.2023.
//

import UIKit

final class CoffeeCollectionViewController: UIViewController {
    //MARK: Private property
    var collectionView: UICollectionView!
    
    //MARK: - Private constraint
    private enum UIConstants {
        static let collectionTopAndLeading: CGFloat = 10
        static let collectionTrailingAndBottom: CGFloat = -10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliaze()
    }
}
//MARK: - Private methods
private extension CoffeeCollectionViewController {
    func initiliaze() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(CoffeeCollectionCell.self, forCellWithReuseIdentifier: String(describing: CoffeeCollectionCell.self))
        
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

//MARK: - UICollectionViewDataSource
extension CoffeeCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CoffeeCollectionCell.self), for: indexPath) as? CoffeeCollectionCell else {return UICollectionViewCell()}
        //        cell.config()
        return cell
    }
    
}
