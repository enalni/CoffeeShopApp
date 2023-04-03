import UIKit

extension UIButton {
    func addVibrationResponse() {
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
    }
}
