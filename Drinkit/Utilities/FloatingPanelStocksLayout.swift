import Foundation
import FloatingPanel

// MARK: - FloatingPanelLayout
final class FloatingPanelStocksLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 50, edge: .top, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 40, edge: .bottom, referenceGuide: .safeArea),
    ]
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}
