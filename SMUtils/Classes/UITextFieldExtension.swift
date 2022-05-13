//
//  UITextFieldExtension.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation

public extension UITextField {
    
    enum timetype {
        case date
        case dateandtime
        case time
    }
    
    func setDatePicker(target: Any, selector: Selector,needCurrent : Bool , timetype : timetype ) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        if timetype == .dateandtime {
            datePicker.datePickerMode = .dateAndTime //2
        }
        else if timetype == .date {
            datePicker.datePickerMode = .date //2
        }
        else {
            datePicker.datePickerMode = .time //2
        }
        datePicker.locale = Locale.current
        datePicker.timeZone = TimeZone.current
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        let calendar = Calendar(identifier: .gregorian)
        
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = 5
        components.month = 12
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        if needCurrent {
            datePicker.minimumDate = currentDate
        }
        else {
            components.year = -55
            let minDate = calendar.date(byAdding: components, to: currentDate)
            datePicker.minimumDate = minDate
        }
        datePicker.maximumDate = maxDate
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    
    
    
}
