//
//  ViewController.m
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

#import "ViewController.h"
#import "Document.h"
#import "DesignerView.h"

#pragma mark - Private Interface

@interface ViewController ()
{
    NSBezierPath *_path;
}

@end


#pragma mark - Implementation 


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.document = [Document new];
    [(DesignerView *)self.designerScrollView.documentView setFrameSize:(NSSize){256, 192}];
}


- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (void)mouseDown:(NSEvent *)event
{
    NSPoint point = [self.designerView convertPointToLayer:event.locationInWindow];
    [self updatePixelAtPoint:point withEvent:event];
    [self.document mouseDownAtPoint:[self.view convertPoint:event.locationInWindow toView:self.designerScrollView.documentView]];
}


- (void)mouseUp:(NSEvent *)event
{
    [self.document mouseUp];
}


- (void)mouseDragged:(NSEvent *)event
{
    NSPoint point = [self.designerView convertPointToLayer:event.locationInWindow];
    [self updatePixelAtPoint:point withEvent:event];
    [self.document mouseDraggedAtPoint:[self.view convertPoint:event.locationInWindow toView:self.designerScrollView.documentView]];
}

- (void)updatePixelAtPoint:(NSPoint)windowLocation withEvent:(NSEvent *)event
{
    NSPoint documentLocation = [self.view convertPoint:windowLocation toView:self.designerScrollView.documentView];
    
    if (event.modifierFlags & NSEventModifierFlagShift)
    {
        [self.document unsetPixelAtPoint:documentLocation];
    }
    else
    {
        [self.document setPixelAtPoint:documentLocation];
    }
    self.designerView.imageLayer.contents = CFBridgingRelease(self.document.image);
}

- (void)mouseMoved:(NSEvent *)event
{
    NSPoint point = [self.view convertPoint:event.locationInWindow toView:self.designerScrollView.documentView];
}

@end
