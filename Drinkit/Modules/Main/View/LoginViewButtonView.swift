import UIKit

final class LoginViewButtonView: UIView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let sizeFontLabel: CGFloat = 20
        static let spacingSet: CGFloat = 1
        static let xStackTopAndLeading: CGFloat = 10
        static let xStackTrailingAndBottom: CGFloat = -10
        static let cornerRadiusSet: CGFloat = 15
    }
    
    // MARK: - Private property
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontLabel)
        label.textColor = UIColor(named: "colorText")
        label.text = "login".localized(tableName: "MainModule")
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var xStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, imageView])
        stack.axis = .horizontal
        stack.spacing = UIConstants.spacingSet
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}

// MARK: - Private methods
private extension LoginViewButtonView {
    func initialize() {
        
        layer.cornerRadius = UIConstants.cornerRadiusSet
        clipsToBounds = true
        customView.backgroundColor = UIColor(named: "loginButtonColor")
        tintColor = .white
        
        addSubview(customView)
        customView.addSubview(xStack)
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: self.topAnchor),
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            xStack.topAnchor.constraint(equalTo: customView.topAnchor, constant: UIConstants.xStackTopAndLeading),
            xStack.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: UIConstants.xStackTopAndLeading),
            xStack.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: UIConstants.xStackTrailingAndBottom),
            xStack.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: UIConstants.xStackTrailingAndBottom),
        ])
    }
}
