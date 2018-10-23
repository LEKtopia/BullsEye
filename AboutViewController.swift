//
//  AboutViewController.swift
//  Bullseye
//
//  Created by Kastel, Lynette on 9/5/17.
//  Copyright © 2017 LynetteKastel. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    // Create a connection the web view (added on AboutViewController's storyboard)
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Find the BullsEye.html file in the project (get the url to it)
        // (if let = optional binding) MARK: debug assignment stuff
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            
            // Convert to useable data (html data)
            if let htmlData = try? Data(contentsOf: url) {
                
                // Obtain the base URL for the project
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                
                // Load the data into the web view (access the outlet)
                webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
                
                // Connect the outlet! (in the storyboard)
                
            }
        }
        
        // MARK: To load remote site (URL), use:
        // let url = URL(string: "https://www.raywenderlich.com")
        // let request = URLRequest(url: url)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }

}
