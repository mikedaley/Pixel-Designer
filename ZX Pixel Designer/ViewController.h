//
//  ViewController.h
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Document;
@class DesignerView;

@interface ViewController : NSViewController

@property (weak) IBOutlet NSScrollView *designerScrollView;
@property (strong) Document *document;
@property (weak) IBOutlet DesignerView *designerView;

@end

