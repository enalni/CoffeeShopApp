//
//  AutorizationViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.01.2023.
//

import UIKit

class AutorizationViewController: UIViewController {
    //MARK: Private property
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: - Private constants
    private enum UIConstants {
        static let title = "Номер телефона"
    }
}
//MARK: - Private methods
private extension AutorizationViewController {
    func initialize() {
        view.backgroundColor = .systemYellow
        title = UIConstants.title
    }
}
