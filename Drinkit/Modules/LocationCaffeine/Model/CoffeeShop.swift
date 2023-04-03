import MapKit

final class CoffeeShop: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    var image: UIImage {
        guard let image = UIImage(named: "kitViewMap") else {
            return UIImage(systemName: "mappin")!
        }
        return image
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
    
    init?(feature: MKGeoJSONFeature) {
        guard
            let point = feature.geometry.first as? MKPointAnnotation,
            let propertyData = feature.properties,
            let json = try? JSONSerialization.jsonObject(with: propertyData),
            let properties = json as? [String: Any]
        else {
            return nil
        }
        title = properties["name"] as? String
        subtitle =  properties["description"] as? String
        coordinate = point.coordinate
        super.init()
    }
}
