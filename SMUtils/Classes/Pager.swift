//
//  Pager.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit


public class Pager : NSObject {

    weak var viewcontroller : UIViewController?
    weak var view : UIView?
    weak var presenter  : PagingIndicatorViewDelegate?
    weak var cv : UICollectionView?
    
    private var cvrefresh = UIRefreshControl()
    lazy private var footerView = PagingIndicatorView(frame: .zero, color: maincolor)
    private var footerheightanc : NSLayoutConstraint?
    var isLoading:Bool = false
    private var blockpaging : Bool = false
    
    public var refreshcallback : (() -> ())?
    var maincolor : UIColor = .white
    
    
    public init(viewcontroller : UIViewController , presenter : PagingIndicatorViewDelegate , cv : UICollectionView,color : UIColor){
        self.viewcontroller = viewcontroller
        self.presenter = presenter
        self.cv = cv
        super.init()
        self.maincolor = color
        registrefreshcontroller()
        makefooterview(isVc: true)
    }
    
    public init(viewcontroller : UIViewController , presenter : PagingIndicatorViewDelegate , cv : UICollectionView,with target : UIView,color : UIColor){
        self.viewcontroller = viewcontroller
        self.presenter = presenter
        self.cv = cv
        super.init()
        self.maincolor = color
        registrefreshcontroller()
        makefooterviewwithTarget(isVc : true , target : target)
    }
    
    public init(view : UIView , presenter : PagingIndicatorViewDelegate , cv : UICollectionView,color : UIColor){
        self.view = view
        self.presenter = presenter
        self.cv = cv
        super.init()
        self.maincolor = color
        registrefreshcontroller()
        makefooterview(isVc: false)
    }
    
    func removeRefresh(){
        cvrefresh.removeFromSuperview()
    }
 
    @objc func refresh(){
        if let cb = refreshcallback {
            cb()
        }
    }
    
    
    func registrefreshcontroller(){
        self.cv?.addSubview(cvrefresh)
        cvrefresh.addTarget(self, action: #selector(refresh), for: .valueChanged)
        cvrefresh.tintColor = maincolor
    }
    
    func disablepullrefresh(){
        cvrefresh.removeFromSuperview()
    }
    
    func makefooterview(isVc : Bool){
        
        if isVc {
            guard let viewcontroller = viewcontroller else {
                return
            }

            viewcontroller.view.addSubview(footerView)
            footerView.leadingAnchor.constraint(equalTo: viewcontroller.view.leadingAnchor, constant: 0).isActive = true
            footerView.trailingAnchor.constraint(equalTo: viewcontroller.view.trailingAnchor, constant: 0).isActive = true
            footerView.bottomAnchor.constraint(equalTo: viewcontroller.view.bottomAnchor, constant: 0).isActive = true
        }
        else {
            guard let view = view else {
                return
            }

            view.addSubview(footerView)
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        }
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        footerheightanc = footerView.heightAnchor.constraint(equalToConstant: 50)
        footerheightanc?.isActive = true
        footerView.delegate = presenter
    }
   
    func makefooterviewwithTarget(isVc : Bool , target : UIView){
      
        if isVc {
            guard let viewcontroller = viewcontroller else {
                return
            }

            viewcontroller.view.addSubview(footerView)
            footerView.leadingAnchor.constraint(equalTo: viewcontroller.view.leadingAnchor, constant: 0).isActive = true
            footerView.trailingAnchor.constraint(equalTo: viewcontroller.view.trailingAnchor, constant: 0).isActive = true
            footerView.bottomAnchor.constraint(equalTo: target.topAnchor, constant: 0).isActive = true
        }
        else {
            guard let view = view else {
                return
            }

            view.addSubview(footerView)
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            footerView.bottomAnchor.constraint(equalTo: target.topAnchor, constant: 0).isActive = true
        }
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        footerheightanc = footerView.heightAnchor.constraint(equalToConstant: 50)
        footerheightanc?.isActive = true
        footerView.delegate = presenter 
    }
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.cv {
            let contentOffset = scrollView.contentOffset.y;
            let contentHeight = scrollView.contentSize.height;
            let diffHeight = contentHeight - contentOffset;
            
            let frameHeight = scrollView.bounds.size.height;
            
            if abs(diffHeight - frameHeight) < 30 && self.isLoading == false && blockpaging == false  {
                footerView.startAnimate()
                self.isLoading = true
            }
        }
    }
    
    public func reloadCv(nomoreContent: Bool){
        DispatchQueue.main.async { [unowned self] in
            self.blockpaging = nomoreContent
            self.cv?.reloadData()
            self.cvrefresh.endRefreshing()
            self.isLoading = false
            self.footerView.stopAnimate()
        }
    }
}



