//
//  PagingIndicatorView.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit

public protocol PagingIndicatorViewDelegate : class {
    func updatebtpaging()
}

class PagingIndicatorView: UIView {
    
    private var spinner = UIActivityIndicatorView()
    var isAnimatingFinal:Bool = false
    var currentTransform:CGAffineTransform?
    
    weak var delegate : PagingIndicatorViewDelegate?
    
    
    var maincolor : UIColor = .white
    
    init(frame : CGRect,color : UIColor){
        super.init(frame : frame)
        self.backgroundColor = .clear
        makespinner()
        maincolor = color
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimate() {
        self.spinner.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        self.spinner.startAnimating()
        delegate?.updatebtpaging()
    }
    
    func stopAnimate() {
        self.spinner.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        self.spinner.stopAnimating()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
    
    
}
extension PagingIndicatorView {
    private func makespinner(){
        self.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 200).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 200).isActive = true
        spinner.color = maincolor
        spinner.contentMode = .scaleAspectFill
        spinner.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        
    }
}
