# StatusFlow [![Build Status](https://travis-ci.org/weitzel926/StatusFlow.svg?branch=master)](https://travis-ci.org/weitzel926/StatusFlow) [![Cocoapod Version](http://img.shields.io/badge/pod-v0.0.3-blue.svg)](http://cocoapods.org/?q=StatusFlow) [![Cocoapod Platform](http://img.shields.io/badge/platform-iOS-blue.svg)](http://cocoapods.org/?q=StatusFlow) [![License](http://b.repl.ca/v1/License-MIT-blue.png)](https://github.com/weitzel926/StatusFlow/blob/master/MIT.LICENSE)

StatusFlow is an iOS implementation of a simple to use UICollectionView intended to show meaningful status that is animated and beautiful.  

![Alt text](https://github.com/weitzel926/StatusFlow/blob/master/docs/AnimatedStatusFlow.gif) 

## Features 

StatusFlow is a custom UICollectionView with a custom UICollectionViewFlowLayout. 

It is intended to show incremental status, such that the "current" item is twice the size of other items in the collection view, is the selected item, and is centered horizontally and vertically within the view.  The previous item is to the left of center and the next item is to the right.  Other items are invisible and will fade in/fade out as the selected index is incremented.  Although the setting of any selected index is supported, the control is intended to be used by incrementing or decrementing the selected index.  Because it is a custom UICollectionView, any cell type is supported (although, most likely, your cell will just be a UIImageView).  Since this is an informational control, user interaction is disabled.  The typical mode is horizontal, but StatusFlow now supports vertical as well.  

![Alt text](https://github.com/weitzel926/StatusFlow/blob/master/docs/vertical.gif)

## Usage

### Installation

##### Via CocoaPods (preferred)
Use [CocoaPods](http://cocoapods.org/) to add StatusFlow to your project.  

1. Add the StatusFlow pod to your podfile:  `pod 'StatusFlow'`
2. Run pod install from your project folder to get the StatusFlow pod: `pod install`
3. Open your project in XCode using the workspace instead of the project file:  `open <your_project>.xcworkspace`
4. `#import <StatusFlow/WDWStatusFlowView.h>` to use StatusFlow

##### Via direct usage

Copy the following files into your workspace, or add them as a submodule:
* WDWStatusFlowView.h
* WDWStatusFlowView.m
* WDWStatusFlowViewLayout.h
* WDWStatusFlowViewLayout.m
* WDWStatusFlowEnum.h

### Creating a StatusFlow

StatusFlowView works very similar to using a UICollectionView.  See the example in this project for a full project using StatusFlow.  

![Alt text](https://github.com/weitzel926/StatusFlow/blob/master/docs/xcode_sample.png)

1. Use storyboards to create a storyboard for the view controller the has your StatusFlow in it.  Drag a UICollectionView to your view controller.  This will be the status flow.  
2. Set the Custom Class -> Class property of the storyboard to WDWStatusFlow. 
3. Create an outlet from the StatusFlow to your view controller.  This can be a private property.  
4. Create a cell class in XCode.  It should inherit from UICollectionViewCell.  
5. Create the cell in the storyboard, and link it to the cell class using the Custom Class -> Class property. 
6. Make sure your UIViewController conforms to UICollectionViewDataSource and UICollectionViewDelegateFlowLayout (for collectionView:layout:sizeForItemAtIndexPath). 
7. In your ViewController's viewDidLoad method, use the StatusFlowView's gapBetweenCells property to define the space between each cell.  The default is 5.  
8. In your ViewController's viewDidLoad method, you can set the direction property on your StatusFlowView object to either WDWStatusFlowViewDirectionHorizontal or WDWStatusFlowViewDirectionVertical.  It will be horizontal by default.   
8. Implement collectionView:numberOfItemsInSection.  Note that there can only be ONE section.  
9. Implement collectionView:cellForItemAtIndexPath
10. Implement collectionView:layout:sizeForItemAtIndexPath: to set the cell's size.  The size of the cell is the size of the cell when it is NOT selected.  It will double in size when selected.  If your selected cell is larger than the collection view in width or height, it may not render properly.    
11. Increment or decrement the StatusFlowView by incrementing or decrementing the selectedIndex property of the StatusFlowView.  It is recommended that you only increment or decrement this value by one (although greater jumps are supported).  

### Using this repo

Your machine should have the following before you begin: [ruby](https://github.com/sstephenson/rbenv), [ruby gems](https://rubygems.org/pages/download), [bundler](http://bundler.io)

To setup the project, run the included setup.sh.  This will install required Gems and perform a pod install.  

```bash
$ ./setup.sh
```

To open the project in XCode run

```bash
$ open StatusFlow.xcworkspace
```

To test the project from the command line:

```bash
$ bundle exec rake
```

To build the project from the command line:
```bash
$ bundle exec rake build
```

To clean the project form the command line:
```bash
$ bundle exec rake clean
```
## Version history

Version history can be found in the [wiki](https://github.com/weitzel926/StatusFlow/wiki)

## Acknowledgements

A tip of the crow to [Ryan Baumbach](https://github.com/rbaumbach) for assistance with Travis ci.  

## Feedback

Got a question, suggestion, comment, or guacamole recipe?  wade.d.weitzel+github@gmail.com
