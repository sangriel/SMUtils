//
//  Toasty.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/13.
//

import Foundation


public class Toasty {
    public static let global = Toasty()
    private init(){}
    
    
    private var toastwindow : ToastWindow?
    
    public enum pos {
        case center
        case bottom
    }

    
    public func show(msg : String ,pos : pos = .bottom){
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            print("noscene")
            return
        }
        
        if toastwindow == nil {
            toastwindow = ToastWindow(windowScene: scene)
        }
        
        toastwindow?.rootViewController = UIViewController()
        toastwindow!.isHidden = false
        ToastView.shared.short(view :toastwindow!,txt_msg: msg, post: pos) { [unowned self] in
            toastwindow?.isHidden = true
        }
        
    }
    
    
    
    
    
    
    
}
