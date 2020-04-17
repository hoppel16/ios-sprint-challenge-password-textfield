//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var strength: Strength = .weak
    
    enum Strength: String {
        case weak = "Too weak"
        case medium = "Could be stronger"
        case strong = "Strong password"
    }
    
    private var isPasswordHidden = true
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        
        backgroundColor = bgColor
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Password"
        titleLabel.textAlignment = .left
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        addSubview(titleLabel)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = labelTextColor
        textField.font = labelFont
        textField.textContentType = .newPassword
        textField.isSecureTextEntry = true
        textField.placeholder = "password"
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        
        let passwordStackView = UIStackView()
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordStackView.addArrangedSubview(textField)
        passwordStackView.addArrangedSubview(showHideButton)
        passwordStackView.alignment = .fill
        passwordStackView.distribution = .fill
        passwordStackView.axis = .horizontal
        addSubview(passwordStackView)
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = weakColor
//        weakView.frame = CGRect(x: 0, y: 0, width: 18, height: 3)
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
//        mediumView.frame = CGRect(x: 0, y: 0, width: 18, height: 3)
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = unusedColor
//        mediumView.frame = CGRect(x: 0, y: 0, width: 18, height: 3)
        
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = self.strength.rawValue
        
        let strengthStackView = UIStackView()
        strengthStackView.translatesAutoresizingMaskIntoConstraints = false
        strengthStackView.addArrangedSubview(weakView)
        strengthStackView.addArrangedSubview(mediumView)
        strengthStackView.addArrangedSubview(strongView)
        strengthStackView.addArrangedSubview(strengthDescriptionLabel)
        strengthStackView.alignment = .fill
        strengthStackView.distribution = .fill
        strengthStackView.axis = .horizontal
        addSubview(strengthStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            
            passwordStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            passwordStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            passwordStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            
            strengthStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            strengthStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            strengthStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
//    // MARK: - Controls
//
//    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        let touchPoint = touch.location(in: self)
//        if textField.frame.contains(touchPoint) {
//            textField.becomeFirstResponder()
//        }
//        sendActions(for: [.touchDown])
//        return true
//    }
//
//    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        let touchPoint = touch.location(in: self)
//        if bounds.contains(touchPoint) {
//            sendActions(for: [.touchDragInside])
//        } else {
//            sendActions(for: [.touchDragOutside])
//        }
//        return true
//    }
//
//    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
//        guard let touch = touch else { return }
//
//        let touchPoint = touch.location(in: self)
//        if bounds.contains(touchPoint) {
//            sendActions(for: [.touchUpInside])
//        } else {
//            sendActions(for: [.touchUpOutside])
//        }
//    }
//
//    override func cancelTracking(with event: UIEvent?) {
//        sendActions(for: [.touchCancel])
//    }
    
    @objc private func showHidePassword() {
        isPasswordHidden = !isPasswordHidden
        
        switch isPasswordHidden {
        case true:
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        case false:
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        }
    }
    
    private func updateViews() {
        strengthDescriptionLabel.text = self.strength.rawValue

        switch self.strength {
        case .weak:
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case .medium:
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        case .strong:
            strongView.backgroundColor = strongColor
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        determineStrength(for: newText)
        updateViews()
        return true
    }
    
    private func determineStrength(for password: String) {
        switch password.count {
        case 0...9:
            self.strength = .weak
        case 10...19:
            self.strength = .medium
        default:
            self.strength = .strong
        }
    }
}
