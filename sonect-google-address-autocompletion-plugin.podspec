Pod::Spec.new do |spec|

    spec.name         = "sonect-google-address-autocompletion-plugin"
    spec.version      = "1.3.5"
    spec.summary      = "Sonect Google Address Autocompletion Plugin"
    spec.description  = <<-DESC
    This is the Sonect Google Address Autocompletion Plugin public podspec. 
                     DESC
  
    spec.homepage     = "https://github.com/sonect/sonect-google-address-autocompletion-plugin"
    spec.license      = { :type => "Sonect Closed Source", :text => <<-LICENSE
                      Copyright (C) Sonect AG - All Rights Reserved
                      Unauthorized copying of this file, and the Sonect SDK via any medium is strictly prohibited
                      Proprietary and confidential
                      Sonect, February 2012. 
                      LICENSE
                 }
    spec.author             = { "sonect" => "marko.hlebar@sonect.ch" }
    spec.platform     = :ios, "13.0"
    spec.source       = { :http => "https://github.com/sonect/sonect-google-address-autocompletion-plugin/releases/download/#{spec.version}/GoogleAddressAutocompletionPlugin_Cocoapods.framework.zip" }
    spec.ios.vendored_frameworks = 'GoogleAddressAutocompletionPlugin.xcframework'
  
  end
  
