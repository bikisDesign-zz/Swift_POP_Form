 [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# RP_iOSBootstrap
A framework filled with protocols I use all the time.

# Included in this framework:
## From [Cyrkus](https://github.com/cyrkus) & Rose&Pine

### Alertable
 A quick way to show stock AlertViewControllers

### KeyboardNotifiable
 Register for keyboard notifications

### DocumentsSearchable
 Quick helper to look up a file in the documents directory
 
### UIColor ext
RGB and Hex helpers

### Reachable
No longer supported. Use alamofire instead  

### UIDevice
No longer supported. Using Device Kit instead:
github "dennisweissmann/DeviceKit" ~> 1.0

## From [RadiantTap](https://github.com/radianttap)

### Bundle - Ext
  Get application meta-data
  
### Embeddable
  easily embed a viewController into a parentView
  
### AsyncOperation
  get state for async operations
    
### DequeableView // NibLoadable // ReusableView 
  Helpers to load various Views


## To install this framework

Add Carthage files to your .gitignore

    #Carthage
    Carthage/Build

Check your Carthage Version to make sure Carthage is installed locally:

    Carthage version

Create a CartFile to manage your dependencies:

    Touch CartFile

Open the Cartfile and add this as a dependency. (in OGDL):

    github "bikisDesign/RP_iosBootstrap" "master"

Update your project to include the framework:

    Carthage update --platform iOS --cache-builds

Add the framework to 'Linked Frameworks and Libraries' in the Xcode Project by dragging and dropping the framework created in

    Carthage/Build/iOS/pathToFramework*.framework

Create a new run script and add this:

    /usr/local/bin/carthage copy-frameworks

Add this input file to the run script:

    $(SRCROOT)/Carthage/Build/iOS/pathToFramework*.framework

If Xcode has issues finding your framework Add

    $(SRCROOT)/Carthage/Build/iOS

To 'Framework Search Paths' in Build Settings
