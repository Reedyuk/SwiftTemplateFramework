# SwiftTemplateFramework

A template framework that handles network requests in a generic way. Why? The idea is to remove your project dependencies on a single networking library. This project should allow the switching of network libraries, currently it support Siesta, but should be able to support many other libraries and keep the same interface.

This library is also a good example on how to move your common code into a seperate library, this way you can share this with many projects, maybe you decide to make a seperate iPad project? maybe just another project that uses the same api's, this way you can keep the logic in one place and share it.

## Installation

This project uses cocoapods, pod install.

## Usage

Add to your current project pod file, 

`pod 'SwiftTemplateFramework', :git => 'https://github.com/Reedyuk/SwiftTemplateFramework.git'`

Initialise the network layer in your appDelegate method 'didFinishLaunchingWithOptions'

`Urls.changeLocalConfig(newLocalConfig: [.all: "https://google.com"])
NetworkRequestAdapter.sharedInstance.createNewInstancesOfServices(networkRequestAdapterDelegate: nil)`

Then simply make a 'service' class which deals with the endpoint, e.g. userService, then you can make simple requests with one line calls:

`NetworkRequestAdapter.performRequest(path: "/questions", onSuccess: onSuccess, onFailure: onFailure)`

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits

Andrew Reed - andrew_reed@hotmail.com

## TODO:

- Create example project using the framework.
