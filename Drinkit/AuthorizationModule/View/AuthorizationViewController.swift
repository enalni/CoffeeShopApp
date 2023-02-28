//
//  AuthorizationViewController.swift
//  Drinkit
//
//  Created by Александр Николаевич on 20.01.2023.
//

import UIKit



final class AuthorizationViewController: UIViewController {
    //MARK: Private property
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: - Private constants
    private enum UIConstants {
        static let title = "Номер телефона"
        static let sizeTitleLabel: CGFloat = 18
    }
    
    //MARK: - Private property
    
    weak var delegate: AuthorizationViewControllerDelegate?
    
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
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let personalDataProcessingButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("обработка личных данных", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let getCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ПОЛУЧИТЬ КОД", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}
//MARK: - Private methods
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
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dismissViewControllerButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            dismissViewControllerButton.heightAnchor.constraint(equalToConstant: 30),
            dismissViewControllerButton.widthAnchor.constraint(equalToConstant: 30),
            dismissViewControllerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            numberTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            numberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            personalDataProcessingButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 5),
            personalDataProcessingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            personalDataProcessingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            personalDataProcessingButton.heightAnchor.constraint(equalToConstant: 20),
            
            getCodeButton.topAnchor.constraint(equalTo: personalDataProcessingButton.bottomAnchor, constant: 5),
            getCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            getCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            getCodeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    @objc func closeVC() {
        let vc = self
        delegate?.authorizationViewControllerDidCancel(_controller: vc)
        print("DEBUG: TAPPED dismissViewControllerButton")
    }
    
    @objc func getCode() {
        print("DEBUG: TAPPED getCodeButton")
    }
    
    @objc func getPersonalDataDocuments() {
        print("DEBUG: TAPPED personalDataProcessingButton")
    }
}
