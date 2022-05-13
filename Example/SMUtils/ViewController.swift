//
//  ViewController.swift
//  SMUtils
//
//  Created by sangriel on 05/13/2022.
//  Copyright (c) 2022 sangriel. All rights reserved.
//

import UIKit
import SMUtils




class ViewController: UIViewController {

    let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        
        self.view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        image.backgroundColor = .black
        image.tocircle()
        
        Loading.global.color = .black
        
        Loading.global.show()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            Loading.global.hide()
        }
        
        Toasty.global.show(msg: "test")
    
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        image.tocircle()
    }

}

