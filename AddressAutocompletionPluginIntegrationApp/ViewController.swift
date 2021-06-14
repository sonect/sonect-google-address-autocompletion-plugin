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
    @IBOutlet var horizontalStackView: UIStackView!
    
    let countryCode = "CH"
    let lat = 47.3624523, lon = 8.5481677
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchChanged(_:)), for: .editingChanged)
    }
    
    @IBAction func runPluginTapped(_ sender: Any) {
        let plugin = SNCGoogleAddressAutocompletionPlugin(apiKey: apiKeyTextField.text!)
        
        let searchTerm = searchTextField?.text ?? "pizza"
        
//        plugin.addressAutocompletion(forSearchTerm: searchTerm, countryCode: countryCode) { (addressAutocompletion, error) in
//            print(String(describing: addressAutocompletion))
//        }
//        
//        plugin.shops(forSearchTerm: searchTerm, countryCode: countryCode) { (shopSearch, error) in
//            print(String(describing: shopSearch))
//        }
//        
//        plugin.shopDetails(forShopId: "ChIJP3A3D_OEqkARikTSnZhYMhw") { (details, error) in
//            print(String(describing: details))
//            self.imageView.image = details?.shopImage
//        }
        
        for subview in horizontalStackView.arrangedSubviews {
            horizontalStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        plugin.places(forSearchTerm: searchTerm, latitude: lat, longitude: lon) { (placeSearch, error) in
            print(String(describing: placeSearch))
            guard let results = placeSearch?.results else { return }
            
            for detail in results {
                guard let ref = detail.photoReference else { continue }
                plugin.photo(fromReference: ref, maxWidth: 128) { (image, error) in
                    guard let image = image else { return }
                    
                    DispatchQueue.main.async {
                        let view = UIImageView(image: image)
                        view.widthAnchor.constraint(equalToConstant: image.size.width).isActive = true
                        self.horizontalStackView.addArrangedSubview(view)
                    }
                }
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
