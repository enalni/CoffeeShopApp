//
//  CustomSegmentControl.swift
//  Drinkit
//
//  Created by Александр Николаевич on 18.01.2023.
//

import UIKit


final class CustomSegmentControl: UIView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    //MARK: - Private constraint
    private enum UIConstants {
        static let sizeItemHeight: CGFloat = 40
        static let sizeItemWidth: CGFloat = 50
        static let heightConstraintsCollection: CGFloat = 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private property
    private var collectionView: UICollectionView!
    weak var delegate: CustomSegmentControlTapedDelegate?
    private let items = ["💙мой дринкит", "зима","кофе"]
}

private extension CustomSegmentControl {
    func initialize() {
        let layout = SegmentControlFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: UIConstants.sizeItemWidth,
                                         height: UIConstants.sizeItemHeight)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SegmentControlCollectionCell.self, forCellWithReuseIdentifier: String(describing: SegmentControlCollectionCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addBlurredBackground(style: .systemUltraThinMaterialDark)
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: UIConstants.heightConstraintsCollection)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension CustomSegmentControl: UICollectionViewDataSource{
    
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
extension CustomSegmentControl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewTaped(indexPath.row)
        print("TAPPED")
    }
}
