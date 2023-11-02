//
//  LoadableProtocol.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import UIKit

protocol LoadableProtocol {
    var loadingViewController: UIViewController {get set}
    func showLoadingView()
    func hideLoadingView()
}

extension LoadableProtocol where Self : UIViewController {
    
    
    func showLoadingView() {
        addChild(loadingViewController)
        loadingViewController.view.frame = view.frame
        view.addSubview(loadingViewController.view)
        loadingViewController.didMove(toParent: self)
    }
    
    func hideLoadingView() {
        loadingViewController.willMove(toParent: nil)
        loadingViewController.view.removeFromSuperview()
        loadingViewController.removeFromParent()
    }
}
