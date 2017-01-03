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
#import "Action.h"


#pragma mark - Private Interface


@interface ViewController ()
{
    ActionType _currentActionType;
}

@end


#pragma mark - Implementation 


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [(DesignerView *)self.designerScrollView.documentView setFrameSize:(NSSize){256, 192}];
    self.document = [Document new];
    _currentActionType = ActionTypeDrawLine;
}


#pragma mark - Mouse Events


- (void)mouseDown:(NSEvent *)event
{
    NSPoint point = [self.view convertPoint:event.locationInWindow toView:self.designerView];
    [self.document mouseDownAtPoint:point withActionType:_currentActionType];
    self.designerView.tempLayer.contents = CFBridgingRelease(self.document.tempImage);
}


- (void)mouseUp:(NSEvent *)event
{
    NSPoint point = [self.view convertPoint:event.locationInWindow toView:self.designerView];
    [self.document mouseUpAtPoint:point withActionActionType:_currentActionType];
    self.designerView.imageLayer.contents = CFBridgingRelease(self.document.image);
}


- (void)mouseDragged:(NSEvent *)event
{
    NSPoint point = [self.view convertPoint:event.locationInWindow toView:self.designerView];
    [self.document mouseDraggedAtPoint:point withActionType:_currentActionType];
    self.designerView.tempLayer.contents = CFBridgingRelease(self.document.tempImage);
}


- (void)mouseMoved:(NSEvent *)event
{
    NSPoint point = [self.view convertPoint:event.locationInWindow toView:self.designerView];
    [self.document mouseMovedAtPoint:point withActionType:_currentActionType];
}


@end
