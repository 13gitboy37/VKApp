//
//  VKLoginVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 16.02.2022.
//
import UIKit
import WebKit

final class VKLoginVC: UIViewController {
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    @IBAction func unwindToLogin(_ segue: UIStoryboardSegue) {
        UserSession.instance.token = ""
        UserSession.instance.userID = 0
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach {
                if $0.displayName.contains("vk") {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [$0]) { [weak self] in
                        guard
                            let self = self,
                            let url = self.urlComponents.url
                        else { return }
                        self.webView.load(URLRequest(url: url))
                    }
                }
            }
        }
        
    }
    
    private var urlComponents: URLComponents = {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "oauth.vk.com"
        comp.path = "/authorize"
        comp.queryItems = [
        URLQueryItem(name: "client_id", value: "8081714"),
        URLQueryItem(name: "display" , value: "mobile"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "scope", value: "336918"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "v", value: "5.130")
        ]
        return comp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard
            let url = urlComponents.url
        else { return }
        webView.load(URLRequest(url: url))
    }
    
}


extension VKLoginVC: WKNavigationDelegate{
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            guard
                let url = navigationResponse.response.url,
                url.path == "/blank.html",
                let fragment = url.fragment
            else { return decisionHandler(.allow)}
            
            let parameters = fragment
                .components(separatedBy: "&")
                .map{ $0.components(separatedBy: "=") }
                .reduce( [String: String]()){
                  partialResult, params in
                    var dict = partialResult
                    let key = params[0]
                    let value = params[1]
                    dict[key] = value
                    return dict
                }
            guard
                let token = parameters["access_token"],
                let userIDString = parameters["user_id"],
                let userID = Int(userIDString)
            else { return decisionHandler(.allow) }
            
            UserSession.instance.token = token
            UserSession.instance.userID = userID
            
            performSegue(
                withIdentifier: "goToMain",
                sender: nil)
            decisionHandler(.cancel)
    }
}