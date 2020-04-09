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

    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var runPluginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func runPluginTapped(_ sender: Any) {
        let plugin = SNCGoogleAddressAutocompletionPlugin(apiKey: apiKeyTextField.text!)
        
        plugin.addressAutocompletion(forSearchTerm: "Dobri Voynikov", countryCode: "BG") { (addressAutocompletion, error) in
            print(String(describing: addressAutocompletion))
        }
    }
}
