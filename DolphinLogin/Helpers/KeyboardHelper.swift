//
//  KeyboardHelper.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 18.11.2023.
//

import UIKit

extension RegistrationViewController {
    
//    func setupKeyboardHiding() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    
//    @objc func handleTap() {
//        self.endEditing(true)
//    }
//
//    @objc func keyboardWillShow(_ notification: NSNotification) {
//        guard let userInfo = notification.userInfo,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
//              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
//
//        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//        let convertedTextFieldFrame = self.convert(currentTextField.frame, from: currentTextField.superview)
//        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
//        
//        if textFieldBottomY > keyboardTopY {
//            let textBoxY = convertedTextFieldFrame.origin.y
//            let newFrameY = (textBoxY - keyboardTopY / 1.4) * -1
//            self.frame.origin.y = newFrameY
//        }
//    }
//
//    @objc func keyboardWillHide(_ notification: Notification) {
//        self.frame.origin.y = 0
//    }
//
//    func adjustContentInsets(_ insets: UIEdgeInsets) {
//        self.layoutMargins = insets
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
}

