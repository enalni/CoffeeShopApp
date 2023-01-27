//
//  CoffeeCollectionViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 27.01.2023.
//

import UIKit

class CoffeeCollectionViewController: UIViewController {
    //MARK: Private property
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliaze()
    }
}
//MARK: - Private methods
private extension CoffeeCollectionViewController {
    func initiliaze() {
        let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionView.register(CoffeeCollectionCell.self, forCellWithReuseIdentifier: String(describing: CoffeeCollectionCell.self))
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemYellow
        
    }
}

//MARK: - UICollectionViewDataSource
extension CoffeeCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CoffeeCollectionCell.self), for: indexPath) as? CoffeeCollectionCell else {return UICollectionViewCell()}
        //        cell.config()
        return cell
    }

}
