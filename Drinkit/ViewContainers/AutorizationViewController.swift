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
        static let sizeTitleLabel: CGFloat = 18
    }
    
    //MARK: - Private property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.sizeTitleLabel)
        label.text = UIConstants.title
        return label
    }()
    
    
    private let dismissViewControllerButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        let image = UIImage(systemName: "x.circle")
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let numberTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.keyboardType = .numberPad
        textFiled.text = "+7"
        textFiled.textAlignment = .center
        textFiled.backgroundColor = UIColor(named: "colorTexfileld")
        textFiled.layer.cornerRadius = 20
        textFiled.clipsToBounds = true
        return textFiled
    }()
    
    private let personalDataProcessingButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("обработка личных данных", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
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
        return button
    }()
    
}
//MARK: - Private methods
private extension AutorizationViewController {
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
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(10)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        dismissViewControllerButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.size.equalTo(30)
        }
        
        numberTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        personalDataProcessingButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(5)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(20)
        }
        
        getCodeButton.snp.makeConstraints { make in
            make.top.equalTo(personalDataProcessingButton.snp.bottom).offset(10)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
    }
    
    @objc func closeVC() {
        dismiss(animated: true)
        print("DEBUG: TAPED dismissViewControllerButton")
    }
    
    @objc func getCode() {
        print("DEBUG: TAPED getCodeButton")
    }
    
    @objc func getPersonalDataDocuments() {
        print("DEBUG: TAPED personalDataProcessingButton")
    }
}
