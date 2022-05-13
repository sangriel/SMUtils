//
//  LoadingView.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit



class LoadingView : UIViewController {
    
    private var spinner = UIActivityIndicatorView()
    
    var maincolor : UIColor = .black
    
    
    convenience init(color : UIColor){
        self.init()
        self.maincolor = color
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(white: 0, alpha: 0.3)
        makespinner()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spinner.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        spinner.stopAnimating()
    }
    
    
    private func makespinner(){
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.tintColor = maincolor
        spinner.contentMode = .scaleToFill
        spinner.style = .large
        spinner.color = maincolor
        
    }
}


