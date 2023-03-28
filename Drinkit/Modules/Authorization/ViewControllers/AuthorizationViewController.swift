//
//  AuthorizationViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.01.2023.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    // MARK: Private property
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private constants
    private enum UIConstants {
        static let title = "Номер телефона"
        static let sizeTitleLabel: CGFloat = 18
        static let cornerRadiusSet: CGFloat = 20
        static let sizeFontNumberTextField: CGFloat = 30
        static let sizePersonalDataProcessingButton: CGFloat = 18
        static let sizeFontGetCodeButton: CGFloat = 20
        
        static let topAnchorSet: CGFloat = 10
        static let leadingAnchorSet: CGFloat = 10
        static let trailingAnchorSet: CGFloat = -10
        static let heightAnchorSet: CGFloat = 50
        static let heightPersonalDataProcessingButton: CGFloat = 20
        static let sizeDismissViewControllerButton: CGFloat = 30
    }
    
    // MARK: - Private property
    
    weak var delegate: ViewControllerCancelDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeTitleLabel)
        label.text = UIConstants.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dismissViewControllerButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        let image = UIImage(systemName: "x.circle")
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let numberTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.text = "+7"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(named: "colorTexfileld")
        textField.layer.cornerRadius = UIConstants.cornerRadiusSet
        textField.font = UIFont(name: "Roboto-Medium", size: UIConstants.sizeFontNumberTextField)
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let personalDataProcessingButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("обработка личных данных", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.sizePersonalDataProcessingButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let getCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ПОЛУЧИТЬ КОД", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeFontGetCodeButton)
        button.layer.cornerRadius = UIConstants.cornerRadiusSet
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
}
// MARK: - Private methods
private extension AuthorizationViewController {
    func initialize() {
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(dismissViewControllerButton)
        view.addSubview(numberTextField)
        view.addSubview(personalDataProcessingButton)
        view.addSubview(getCodeButton)
        
        dismissViewControllerButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        getCodeButton.addTarget(self, action: #selector(getCode), for: .touchUpInside)
        personalDataProcessingButton.addTarget(self, action: #selector(getPersonalDataDocuments), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.topAnchorSet),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dismissViewControllerButton.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.topAnchorSet),
            dismissViewControllerButton.heightAnchor.constraint(equalToConstant: UIConstants.sizeDismissViewControllerButton),
            dismissViewControllerButton.widthAnchor.constraint(equalToConstant: UIConstants.sizeDismissViewControllerButton),
            dismissViewControllerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.trailingAnchorSet),
            
            numberTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.leadingAnchorSet),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.trailingAnchorSet),
            numberTextField.heightAnchor.constraint(equalToConstant: UIConstants.heightAnchorSet),
            
            personalDataProcessingButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: UIConstants.topAnchorSet),
            personalDataProcessingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.leadingAnchorSet),
            personalDataProcessingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.trailingAnchorSet),
            personalDataProcessingButton.heightAnchor.constraint(equalToConstant: UIConstants.heightPersonalDataProcessingButton),
            
            getCodeButton.topAnchor.constraint(equalTo: personalDataProcessingButton.bottomAnchor, constant: UIConstants.topAnchorSet),
            getCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.leadingAnchorSet),
            getCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.trailingAnchorSet),
            getCodeButton.heightAnchor.constraint(equalToConstant: UIConstants.heightAnchorSet),
        ])
        
    }
    
    @objc func closeVC() {
        let vc = self
        delegate?.viewControllerDidCancel(_controller: vc)
        print("DEBUG: TAPPED dismissViewControllerButton")
    }
    
    @objc func getCode() {
        print("DEBUG: TAPPED getCodeButton")
    }
    
    @objc func getPersonalDataDocuments() {
        print("DEBUG: TAPPED personalDataProcessingButton")
    }
}
