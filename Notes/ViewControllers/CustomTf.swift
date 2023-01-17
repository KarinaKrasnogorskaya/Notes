//
//  CustomTf.swift
//  Notes
//
//  Created by Карина on 16.01.2023.
//

import UIKit

//MARK: - RegisterTextField
final class RegisterTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    
    //MARK: - Initializers
    init(placeholder: String, isPrivate: Bool = false) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder, isPrivate: isPrivate)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    //MARK: - Private Methods
    private func setupTextField(placeholder: String, isPrivate: Bool) {
        
        
        
        textColor = .black
        tintColor = .black
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        font = .boldSystemFont(ofSize: 18)
    
        
        if isPrivate {
            isSecureTextEntry = true
        }
    }
}
