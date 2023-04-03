import UIKit

extension String {
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "******\(self)******", comment: "")
    }
}
