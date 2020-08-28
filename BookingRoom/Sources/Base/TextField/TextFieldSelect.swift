//
//  TextFieldSelect.swift
//  Married
//
//  Created by Nguyễn Tùng Anh on 8/8/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

typealias OnTextFieldSelectDidSelect = (_ sender: TextFieldSelect,_ index: Int,_ item: TextFieldSelectData) -> Void

struct TextFieldSelectData {
    var key: Int?
    var value: String!
}

class TextFieldSelect: BaseTextField {
    private var pickerData : [TextFieldSelectData] = []
    private var currentIndex : Int = 0
    private var pickerView: UIPickerView!
    var onTextFieldSelectDidSelect: OnTextFieldSelectDidSelect?
    
    private func setupPickerView() {
        tintColor = .clear
        pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        self.inputView = pickerView
        self.delegate = self
    }
    
    func update(data: [TextFieldSelectData], defaultValue: TextFieldSelectData? = nil, showItemAt index : Int? = nil) {
        pickerData = data
        
        if pickerView == nil {
            setupPickerView()
        }
        
        if defaultValue != nil {
            pickerData.insert(defaultValue!, at: 0)
            self.text = defaultValue?.value
        }
        
        if index != nil && index! > -1 && index! < pickerData.count {
            self.text = data[index!].value
        }
        
        pickerView.reloadAllComponents()
        pickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
    func moveTo(index: Int) {
        pickerView.selectRow(index, inComponent: 0, animated: false)
    }
}

extension TextFieldSelect : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = pickerData[row]
        return item.value
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentIndex = row
    }
}

extension TextFieldSelect: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if pickerData.count > 0 {
            self.text = pickerData[currentIndex].value
            if let event = onTextFieldSelectDidSelect {
                event(self, currentIndex, pickerData[currentIndex])
            }
        }
    }
}
