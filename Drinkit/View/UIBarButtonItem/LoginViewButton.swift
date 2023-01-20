//
//  LoginViewButton.swift
//  Drinkit
//
//  Created by Александр Николаевич on 18.01.2023.
//

import UIKit
import SnapKit

class LoginViewButton: UIView {
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private constraint
    private enum UIConstants {
        
    }
    
    //MARK: - Private property
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "colorText")
        label.text = "войти"
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var xStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, imageView])
        stack.axis = .horizontal
        stack.spacing = 1
        return stack
    }()
}

//MARK: - Private methods
private extension LoginViewButton {
    func initialize() {
        addSubview(xStack)
        xStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        layer.cornerRadius = 15
        clipsToBounds = true
        backgroundColor = UIColor(named: "colorButton")
        tintColor = .white
        
        self.isUserInteractionEnabled = true
    }
}
