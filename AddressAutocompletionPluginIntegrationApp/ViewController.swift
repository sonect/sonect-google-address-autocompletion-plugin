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
        
//        plugin.addressAutocompletion(forSearchTerm: searchTerm, countryCode: countryCode) { (addressAutocompletion, error) in
//            print(String(describing: addressAutocompletion))
//        }
//
//        plugin.adressDetails(forAddressId: "EhxMaXZlcnBvb2wgU3RyZWV0LCBMb25kb24sIFVLIi4qLAoUChIJqeLSXbIcdkgRqAbi6bi_PEcSFAoSCfPzF7dbG3ZIEQqyADl5LpFJ") { (details, error) in
//            print(String(describing: details))
//        }
//
//        plugin.shops(forSearchTerm: searchTerm, countryCode: countryCode) { (shopSearch, error) in
//            print(String(describing: shopSearch))
//        }
//
//        plugin.shopDetails(forShopId: "ChIJBZ0aNKes2EcRou8EZfpOOy0") { (details, error) in
//            print(String(describing: details))
//            self.imageView.image = details?.shopImage
//        }
        
        removePlaceViews()
        
        plugin.places(forSearchTerm: searchTerm, latitude: lat, longitude: lon) { (placeSearch, error) in
            print(String(describing: placeSearch))
            guard let results = placeSearch?.results else { return }

            self.addPlaceViews(for: results, plugin: plugin)
        }
    }
    
    func removePlaceViews() {
        for subview in horizontalStackView.arrangedSubviews {
            horizontalStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    func addPlaceViews(for shopDetails: [SNCShopDetails], plugin: SNCGoogleAddressAutocompletionPlugin) {
        for detail in shopDetails {
            let mainLabel = UILabel(frame: .zero)
            mainLabel.text = detail.name
            let secondaryLabel = UILabel(frame: .zero)
            secondaryLabel.text = detail.vicinity
            let verticalStack = UIStackView(arrangedSubviews: [mainLabel, secondaryLabel])
            verticalStack.distribution = .equalSpacing
            verticalStack.spacing = 10;
            verticalStack.axis = .vertical
            verticalStack.widthAnchor.constraint(equalToConstant: 120).isActive = true
            
            self.horizontalStackView.addArrangedSubview(verticalStack)
            
            guard let ref = detail.photoReference else { continue }
            plugin.photo(fromReference: ref, maxWidth: 128) { (image, error) in
                guard let image = image else { return }

                DispatchQueue.main.async {
                    let imageView = UIImageView(image: image)
                    imageView.widthAnchor.constraint(equalToConstant: image.size.width).isActive = true
                    verticalStack.addArrangedSubview(imageView)
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
