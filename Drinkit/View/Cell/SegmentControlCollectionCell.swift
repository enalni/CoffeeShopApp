//
//  CustomCollectionCell.swift
//  Drinkit
//
//  Created by Александр Николаевич on 19.01.2023.
//

import UIKit

class SegmentControlCollectionCell: UICollectionViewCell {
    
    //MARK: - Public func
    func config(item: String) {
        self.label.text = item
    }

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private property
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = UIColor(named: "colorText")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
//MARK: - Private Methods
private extension SegmentControlCollectionCell {
    func initialize() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
