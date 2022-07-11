# Sonect Google Address Autocompletion Plugin
This is Sonect's address autocompletion plugin repository, based on Google Maps API, used to complement [Sonect Shop SDK](https://github.com/sonect/sonect-shop-sdk-ios)

Contact support@sonect.ch if additional info is needed.

## Installation: 

Via dependency managers:
- Cocoapods: `pod 'sonect-google-address-autocompletion-plugin'`
- Carthage: `github "sonect/sonect-google-address-autocompletion-plugin"`
- Manual: Get the [latest release](https://github.com/sonect/sonect-google-address-autocompletion-plugin/releases/latest) and integrate it into your project. 

## Usage:

To initiate the plugin:
`let plugin = SNCGoogleAddressAutocompletionPlugin(apiKey: <GOOGLE_API_KEY>)`

You can check if it's properly initiated using one of it's functions. For example, next code piece should return list of pizza shops in Italy:

`plugin.addressAutocompletion(forSearchTerm: "pizza", countryCode: "IT") { (addressAutocompletion, error) in
      print(String(describing: addressAutocompletion))
 }
`

## Important notes:

To use this plugin, you will also need Google API key with properly set up payment.
Contact Sonect (support@sonect.ch) for further instructions. 
