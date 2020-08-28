//
//  BaseButton.swift
//  Married
//
//  Created by dexjoke on 7/23/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

protocol BaseButtonDelegate {
    func onStartHilight(sender: BaseButton)
    func onEndHilight(sender: BaseButton)
}

@IBDesignable
class BaseButton: UIButton {
    var baseButtonDelegate: BaseButtonDelegate?
    override func awakeFromNib() {
        commonInit()
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(BaseButton.startHilight(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector(BaseButton.endHilight(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(BaseButton.endHilight(sender:)), for: .touchUpOutside)
        self.addTarget(self, action: #selector(BaseButton.endHilight(sender:)), for: .touchCancel)
    }
    
    @objc func startHilight(sender: UIButton) {
        baseButtonDelegate?.onStartHilight(sender: self)
    }
    
    @objc func endHilight(sender: UIButton) {
        baseButtonDelegate?.onEndHilight(sender: self)
    }
}
