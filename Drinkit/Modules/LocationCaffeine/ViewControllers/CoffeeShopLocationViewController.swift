import UIKit
import MapKit

final class CoffeeShopLocationViewController: UIViewController {
    
    // MARK: - Private constraint
    private enum UIConstants {
        static let sizeButtonHeightAndWidth: CGFloat = 30
        static let trailingButtonSet: CGFloat = -10
        static let leadingButtonSet: CGFloat = 10
    }
    
    // MARK: Private property
    private var coffeeShopLocations: [CoffeeShop] = .init()
    weak var delegate: ViewControllerCancelDelegate?
    
    private let coffeeShopMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let dismissViewControllerButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliaze()
    }
}

// MARK: - Private methods
private extension CoffeeShopLocationViewController {
    func initiliaze() {
        
        loadInitialData()
        configureMapView()
        
        view.addSubviews(coffeeShopMapView)
        view.addSubview(dismissViewControllerButton)
        
        dismissViewControllerButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dismissViewControllerButton.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.leadingButtonSet),
            dismissViewControllerButton.heightAnchor.constraint(equalToConstant: UIConstants.sizeButtonHeightAndWidth),
            dismissViewControllerButton.widthAnchor.constraint(equalToConstant: UIConstants.sizeButtonHeightAndWidth),
            dismissViewControllerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.trailingButtonSet),
            
            coffeeShopMapView.topAnchor.constraint(equalTo: view.topAnchor),
            coffeeShopMapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coffeeShopMapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coffeeShopMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func loadInitialData() {
        guard let fileName = Bundle.main.url(forResource: "CoffeeShopLocation", withExtension: "geojson"),
              let coffeeShopLocation = try? Data(contentsOf: fileName)
        else { return }
        
        do {
            let feature = try MKGeoJSONDecoder()
                .decode(coffeeShopLocation)
                .compactMap{$0 as? MKGeoJSONFeature}
            let validLocation = feature.compactMap(CoffeeShop.init)
            coffeeShopLocations.append(contentsOf: validLocation)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func configureMapView() {
        coffeeShopMapView.addAnnotations(coffeeShopLocations)
        coffeeShopMapView.delegate = self
        coffeeShopMapView.showsCompass = false
        coffeeShopMapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let initialLocation = CLLocation(latitude: 55.773721, longitude: 37.585222)
        coffeeShopMapView.centerLocation(initialLocation)
    }
    
    @objc func closeVC() {
        delegate?.viewControllerDidCancel(_controller: self)
        print("TAPPED dismissViewControllerButton")
    }
}

// MARK: - MKMapViewDelegate
extension CoffeeShopLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? CustomAnnotationView else {return nil}
        customAnnotationView.annotation = annotation
        return customAnnotationView
    }
}
