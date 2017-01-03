//
//  Document.h
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Action.h"

#pragma mark - Types


#pragma mark - Forward References


@class ImageModel;


#pragma mark - Interface


@interface Document : NSDocument


// Properties
@property (strong) ImageModel *imageModel;
@property (assign, nonatomic) CGImageRef image;
@property (assign, nonatomic) CGImageRef tempImage;


// Methods
- (void)mouseDownAtPoint:(NSPoint)point withActionType:(ActionType)actionType;
- (void)mouseDraggedAtPoint:(NSPoint)point withActionType:(ActionType)actionType;
- (void)mouseUpAtPoint:(NSPoint)point withActionActionType:(ActionType)actionType;
- (void)mouseMovedAtPoint:(NSPoint)point withActionType:(ActionType)actionType;

@end

