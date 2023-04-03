import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChild() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
