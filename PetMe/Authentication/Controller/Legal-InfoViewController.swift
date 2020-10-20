//
//  Legal-InfoViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-06-25.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import WebKit

class Legal_InfoViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var documentToOpen: String!
    let dismissButton = DismissButton()
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        if documentToOpen == "TC" {
            let url = URL(string: "https://petmeinfo.herokuapp.com/terms-of-use.html")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        } else if documentToOpen == "PP" {
            let url = URL(string: "https://petmeinfo.herokuapp.com/privacy-policy.html")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        view.addSubview(dismissButton)
        view.addContraintsWithFormat(format: "V:|-5-[v0]", views: dismissButton)
        view.addContraintsWithFormat(format: "H:[v0]-5-|", views: dismissButton)
        
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
