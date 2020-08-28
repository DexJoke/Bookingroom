//
//  BaseTextField.swift
//  Married
//
//  Created by Nguyễn Tùng Anh on 8/16/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {

    override func draw(_ rect: CGRect) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.autocorrectionType = .no
    }

}
