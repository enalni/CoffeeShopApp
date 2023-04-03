import UIKit
import MapKit

final class CustomAnnotationView: MKAnnotationView {
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let cornerRadiusSet: CGFloat = 25
        static let sizeFontlocationCoffeeShoplabel: CGFloat = 18
    }
    
    // MARK: Private property
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 50, height: 50))
        imageView.contentMode = .center
        imageView.layer.cornerRadius = UIConstants.cornerRadiusSet
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let locationCoffeeShoplabel: UILabel = {
        let label = UILabel(frame: CGRect(x: -25, y: 55, width: 140, height: 30))
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontlocationCoffeeShoplabel)
        label.backgroundColor = .white
        return label
    }()
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let coffeeShop = newValue as? CoffeeShop else { return }
            logoImageView.image = coffeeShop.image
            locationCoffeeShoplabel.text = coffeeShop.title
        }
    }
    
    // MARK: - Init
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private methods
private extension CustomAnnotationView {
    func initialize() {
        addSubview(logoImageView)
        addSubview(locationCoffeeShoplabel)
    }
}

