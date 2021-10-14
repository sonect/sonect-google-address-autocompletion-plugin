//
//  ViewController.swift
//  AddressAutocompletionPluginIntegrationApp
//
//  Created by Ivan Yanakiev on 8.04.20.
//  Copyright © 2020 Ivan Yanakiev. All rights reserved.
//

import UIKit
import GoogleAddressAutocompletionPlugin
import SonectCore

class ViewController: UIViewController {

    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var runPluginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var horizontalStackView: UIStackView!
    
    let countryCode = "CH"
    
    let lat = 47.383953, lon = 8.499051 // Zurich
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchChanged(_:)), for: .editingChanged)
    }
    
    @IBAction func runPluginTapped(_ sender: Any) {
        let plugin = SNCGoogleAddressAutocompletionPlugin(apiKey: apiKeyTextField.text!)
        plugin.isDebuggingEnabled = true
        
        let searchTerm = searchTextField?.text ?? "pizza"
        
        plugin.addressAutocompletion(forSearchTerm: searchTerm, countryCode: countryCode) { (addressAutocompletion, error) in
            print(String(describing: addressAutocompletion))
        }

        plugin.adressDetails(forAddressId: "EhxMaXZlcnBvb2wgU3RyZWV0LCBMb25kb24sIFVLIi4qLAoUChIJqeLSXbIcdkgRqAbi6bi_PEcSFAoSCfPzF7dbG3ZIEQqyADl5LpFJ") { (details, error) in
            print(String(describing: details))
        }

        plugin.shops(forSearchTerm: searchTerm, countryCode: countryCode) { (shopSearch, error) in
            print(String(describing: shopSearch))
        }

        plugin.shopDetails(forShopId: "ChIJBZ0aNKes2EcRou8EZfpOOy0") { (details, error) in
            print(String(describing: details))
            self.imageView.image = details?.shopImage
        }
        
        for subview in horizontalStackView.arrangedSubviews {
            horizontalStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        plugin.places(forSearchTerm: searchTerm, latitude: lat, longitude: lon) { (placeSearch, error) in
            print(String(describing: placeSearch))
            guard let results = placeSearch?.predictions else { return }
            
            for address in results {
                
                let mainLabel = UILabel(frame: .zero)
                mainLabel.text = address.mainText
                let secondaryLabel = UILabel(frame: .zero)
                secondaryLabel.text = address.secondaryText
                let verticalStack = UIStackView(arrangedSubviews: [mainLabel, secondaryLabel])
                verticalStack.distribution = .fillEqually
                verticalStack.axis = .vertical
                verticalStack.widthAnchor.constraint(equalToConstant: 120).isActive = true
                
                self.horizontalStackView.addArrangedSubview(verticalStack)
            }
        }
    }
    
    @objc func searchChanged(_ sender: Any) {
        guard let searchTerm = searchTextField.text else {
            return
        }
        
        let plugin = SNCGoogleAddressAutocompletionPlugin(apiKey: apiKeyTextField.text!)
        
        plugin.shops(forSearchTerm: searchTerm, countryCode: countryCode) { (shopSearch, error) in
            print(String(describing: shopSearch))
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true;
    }
}
