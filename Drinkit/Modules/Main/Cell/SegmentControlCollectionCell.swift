import UIKit

final class SegmentControlCollectionCell: UICollectionViewCell {
    
    // MARK: - Public func
    func config(item: String) {
        self.label.text = item
    }
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let soziFontLabel: CGFloat = 18
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private property
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.soziFontLabel)
        label.textColor = UIColor(named: "colorText")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
// MARK: - Private Methods
private extension SegmentControlCollectionCell {
    func initialize() {
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
