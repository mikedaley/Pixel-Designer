//
//  Document.h
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument

@property (assign, nonatomic) CGImageRef image;

- (void)setPixelAtPoint:(NSPoint)point;
- (void)unsetPixelAtPoint:(NSPoint)point;
- (void)mouseDraggedAtPoint:(NSPoint)point;
- (void)mouseDownAtPoint:(NSPoint)point;
- (void)mouseUp;

@end

