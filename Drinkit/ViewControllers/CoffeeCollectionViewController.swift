//
//  CoffeeCollectionViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 27.01.2023.
//

import UIKit
import SnapKit

class CoffeeCollectionViewController: UIViewController {
    //MARK: Private property
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliaze()
    }
}
//MARK: - Private methods
private extension CoffeeCollectionViewController {
    func initiliaze() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayot())
        collectionView.register(CoffeeCollectionCell.self, forCellWithReuseIdentifier: String(describing: CoffeeCollectionCell.self))
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func createLayot() -> UICollectionViewLayout {
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
