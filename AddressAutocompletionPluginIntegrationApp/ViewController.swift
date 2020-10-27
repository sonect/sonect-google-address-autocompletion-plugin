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
import SonectCore

class ViewController: UIViewController {

    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var runPluginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchChanged(_:)), for: .editingChanged)
    }
    
    @IBAction func runPluginTapped(_ sender: Any) {
        let plugin = SNCGoogleAddressAutocompletionPlugin(apiKey: apiKeyTextField.text!)
        
        plugin.addressAutocompletion(forSearchTerm: "Dobri Voynikov", countryCode: "BG") { (addressAutocompletion, error) in
            print(String(describing: addressAutocompletion))
        }
        
        plugin.shops(forSearchTerm: "дар", countryCode: "BG") { (shopSearch, error) in
            print(String(describing: shopSearch))
        }
        
        plugin.shopDetails(forShopId: "ChIJP3A3D_OEqkARikTSnZhYMhw") { (details, error) in
            print(String(describing: details))
            self.imageView.image = details?.shopImage
        }
    }
    
    @objc func searchChanged(_ sender: Any) {
        guard let searchTerm = searchTextField.text else {
            return
        }
        
        let plugin = SNCGoogleAddressAutocompletionPlugin(apiKey: apiKeyTextField.text!)
        
        plugin.shops(forSearchTerm: searchTerm, countryCode: "CH") { (shopSearch, error) in
            print(String(describing: shopSearch))
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true;
    }
}
