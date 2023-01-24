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
    
    //MARK: - Private property
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
        let button = UIButton(type: .infoDark)
        button.setTitle("обработка личных данных", for: .normal)
        return button
    }()
    
    private let getCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ПОЛУЧИТЬ КОД", for: .normal)
        return button
    }()
    
}
//MARK: - Private methods
private extension AutorizationViewController {
    func initialize() {
        view.backgroundColor = .white
        title = UIConstants.title
        
        view.addSubview(numberTextField)
        view.addSubview(personalDataProcessingButton)
        view.addSubview(getCodeButton)
        
        numberTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(50)
        }
        
        personalDataProcessingButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(5)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(30)
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
    }
}
