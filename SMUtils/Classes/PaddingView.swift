//
//  PaddingView.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit



public class PaddingView<Type : UIView> : UIView{
    
    var view : Type
    
    let stackview = UIStackView()
    
    init(type : Type){
        self.view = type
        super.init(frame: .zero)
        self.addSubview(stackview)
        stackview.addArrangedSubview(self.view)
        stackview.distribution = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        stackview.isLayoutMarginsRelativeArrangement = true
    }
    
    
    
    public var _layoutMargins: UIEdgeInsets {
        set {
            stackview.layoutMargins = newValue
        }
        get {
            return stackview.layoutMargins
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
