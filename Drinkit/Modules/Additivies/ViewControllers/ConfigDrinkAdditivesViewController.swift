//
//  ConfigDrinkAdditives.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.03.2023.
//

import UIKit

final class ConfigDrinkAdditivesViewController: UIViewController {
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let sizeFontNameAdditiviesHeaderLabel: CGFloat = 22
        static let sizeCloseViewControlerButton: CGFloat = 50
    }
    
    // MARK: - Private property
    private var collection: UICollectionView!
    private var additives: [Additivies] = .init()
        
    private let closeViewControlerButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray
        let image = UIImage(systemName: "x.circle")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameAdditiviesHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Молоко"
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontNameAdditiviesHeaderLabel)
        return label
    }()
    
    private lazy var xStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameAdditiviesHeaderLabel, closeViewControlerButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = UIColor(named: "colorDrinkSegmentControl")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private methods
private extension ConfigDrinkAdditivesViewController {
    func initialize() {
        
        configureCollection()
        
        closeViewControlerButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        view.addSubview(xStack)
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            
            closeViewControlerButton.heightAnchor.constraint(equalToConstant: UIConstants.sizeCloseViewControlerButton),
            closeViewControlerButton.widthAnchor.constraint(equalToConstant: UIConstants.sizeCloseViewControlerButton),
            
            xStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            xStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            xStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            xStack.heightAnchor.constraint(equalToConstant: 50),
            
            collection.topAnchor.constraint(equalTo: xStack.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configureCollection() {
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CustomAdditiviesCell.self, forCellWithReuseIdentifier: String(describing: CustomAdditiviesCell.self))
        collection.dataSource = self
        collection.delegate = self
        
        func createLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewCompositionalLayout(section: createSection())
            return layout
        }
        
        func createSection() -> NSCollectionLayoutSection {
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33),
                                                                heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(0.5)),
                                                           subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
// MARK: - UICollectionViewDataSource
extension ConfigDrinkAdditivesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        additives.count
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomAdditiviesCell.self), for: indexPath) as? CustomAdditiviesCell else {return UICollectionViewCell()}
        //        cell.configure(additivies: additives[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ConfigDrinkAdditivesViewController: UICollectionViewDelegate {
 
}
