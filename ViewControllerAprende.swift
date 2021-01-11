//
//  ViewControllerAprende.swift
//  Densidad
//
//  Created by Rodrigo Esparza on 4/27/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit

class ViewControllerAprende: UIViewController {

    let doc1 = "Densidad tradicional"
    let doc2 = "Densidad lineal"
    let doc3 = "Densidad Media"
    
    
    var bgColor: UIColor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = bgColor
        // Do any additional setup after loading the view.
    }
    

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 
    
    @IBAction func tema1(_ sender: Any) {
        
        if let url = Bundle.main.url(forResource: doc1, withExtension: "pdf"){
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)

            let pdfVC = UIViewController()
            pdfVC.view.addSubview(webView)
            pdfVC.title = doc1
            self.navigationController?.pushViewController(pdfVC, animated: true)
        }
    }
    
    @IBAction func tema2(_ sender: Any) {
        if let url = Bundle.main.url(forResource: doc2, withExtension: "pdf"){
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)
            
            let pdfVC = UIViewController()
            pdfVC.view.addSubview(webView)
            pdfVC.title = doc2
            self.navigationController?.pushViewController(pdfVC, animated: true)
        }
    }
    
    @IBAction func tema3(_ sender: Any) {
        if let url = Bundle.main.url(forResource: doc3, withExtension: "pdf"){
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)
            
            let pdfVC = UIViewController()
            pdfVC.view.addSubview(webView)
            pdfVC.title = doc3
            self.navigationController?.pushViewController(pdfVC, animated: true)
        }
    }
    

}
