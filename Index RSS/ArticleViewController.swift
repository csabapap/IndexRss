//
//  ArticleViewController.swift
//  Index RSS
//
//  Created by Pap Csaba on 2019. 11. 19..
//  Copyright © 2019. Pap Csaba. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {
    
    let webView = WKWebView()
    
    var article: FeedItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        
        webView.frame = view.frame
        
        // Do any additional setup after loading the view.
        print(article?.title ?? "nil")
        print(article?.link ?? "link: nil")
        if let feedItem = article {
            let url = NSURL (string: feedItem.link);
            let request = NSURLRequest(url: url! as URL);
            webView.load(request as URLRequest);
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
