//
//  CustomSegmnetControl.swift
//  Drinkit
//
//  Created by Александр Николаевич on 18.01.2023.
//

import UIKit

class CustomSegmnetControl: UIView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private property
    var collectionView: UICollectionView!
    let items = ["💙мой дринкит", "зима","кофе","не кофе","еда","сладкое","забери с собой"]
}

private extension CustomSegmnetControl {
    func initialize() {
        let layot = TagFlowLayout()
        layot.scrollDirection = .horizontal
        layot.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SegmentControlCollectionCell.self, forCellWithReuseIdentifier: String(describing: SegmentControlCollectionCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension CustomSegmnetControl: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SegmentControlCollectionCell.self), for: indexPath) as? SegmentControlCollectionCell else {return UICollectionViewCell()}
        cell.config(item: items[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CustomSegmnetControl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TAPED - \(indexPath.item)")
    }
}
