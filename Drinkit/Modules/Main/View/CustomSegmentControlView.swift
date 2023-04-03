import UIKit


final class CustomSegmentControlView: UIView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLanguage()
        initialize()
    }
    
    // MARK: - Private constraint
    private enum Const {
         enum UIConstants {
            static let sizeItemHeight: CGFloat = 40
            static let sizeItemWidth: CGFloat = 50
            static let heightConstraintsCollection: CGFloat = 40
        }
        enum SetLanguage {
            static let en: String = "en"
            static let ru: String = "ru"
            static let arab: String = "ar"
       }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private property
    private var collectionView: UICollectionView!
    weak var delegate: CustomSegmentControlTappedDelegate?
    private var items: [String] = .init()
}

private extension CustomSegmentControlView {
    func initialize() {
        let layout = SegmentControlFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: Const.UIConstants.sizeItemWidth,
                                          height: Const.UIConstants.sizeItemHeight)
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
            collectionView.heightAnchor.constraint(equalToConstant: Const.UIConstants.heightConstraintsCollection)
        ])
    }
    
    func configLanguage() {
        if Locale.current.languageCode == Const.SetLanguage.en {
              items = ["💙my drinkit", "winter", "coffee"]
        } else if Locale.current.languageCode == Const.SetLanguage.ru {
              items = ["💙мой дринкит", "зима","кофе"]
        } else if Locale.current.languageCode == Const.SetLanguage.arab {
              items = [ "شراب بلدي", "شتاء", "قهوة" ]
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CustomSegmentControlView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SegmentControlCollectionCell.self), for: indexPath) as? SegmentControlCollectionCell else {return UICollectionViewCell()}
        cell.config(item: items[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CustomSegmentControlView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewTapped(indexPath.row)
        print("TAPPED")
    }
}
