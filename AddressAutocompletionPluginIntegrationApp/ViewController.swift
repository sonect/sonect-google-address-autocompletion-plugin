//
//  ViewController.swift
//  AddressAutocompletionPluginIntegrationApp
//
//  Created by Ivan Yanakiev on 8.04.20.
//  Copyright © 2020 Ivan Yanakiev. All rights reserved.
//

import UIKit
import GoogleAddressAutocompletionPlugin
import SonectShop

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plugin = SNCGoogleAddressAutocompletionPlugin(apiKey: "AIzaSyDxPjg7nmdWmUs2L9DpF2nk33u4ds8gEKw")
        
        plugin.addressAutocompletion(forSearchTerm: "Dobri Voynikov", countryCode: "BG") { (addressAutocompletion, error) in
            print(String(describing: addressAutocompletion))
        }
    }
}
