//
//  designerView.m
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

// Use a 1 bit array to store pixel information
// Use a 32 bit array to store colour information
// pixels are turned on and off in the colour array when a pixel is set in the pixel array.
// When a colour attribute is changed then the colour array is updated with the new colour and
// a pixel only set if its in the 1 bit array.

#import "DesignerView.h"
#import <Quartz/Quartz.h>
#import <CoreImage/CoreImage.h>


#pragma mark - Implementation 


@implementation DesignerView
{
    NSTrackingArea *_trackingArea;
    CALayer *_checkersLayer;
    CIImage *_checkersImage;
}


-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        self.wantsLayer = YES;

        // Create a checker board pattern
//        CIFilter *checkers = [CIFilter filterWithName:@"CICheckerboardGenerator"];
//        [checkers setDefaults];
//        [checkers setValue:[CIVector vectorWithX:0 Y:0] forKey:@"inputCenter"];
//        [checkers setValue:[CIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] forKey:@"inputColor0"];
//        [checkers setValue:[CIColor colorWithRed:1 green:1 blue:1 alpha:1] forKey:@"inputColor1"];
//        [checkers setValue:@(8) forKey:@"inputWidth"];
//        _checkersImage = [checkers valueForKey:@"outputImage"];
//        
//        // Create an image with the correct size using the checker patter CIImage
//        CIContext *con = [CIContext contextWithOptions:nil];
//        CGImageRef checkImage = [con createCGImage:_checkersImage fromRect:(CGRect){0, 0, 256, 192}];
        
        // Create a layer for displaying the checker pattern
//        _checkersLayer = [CALayer layer];
//        _checkersLayer.magnificationFilter = kCAFilterNearest;
//        [_checkersLayer setAnchorPoint:(CGPoint){0, 0}];
//        [_checkersLayer setBounds:(CGRect){0, 0, 256, 192}];
//        _checkersLayer.contents = CFBridgingRelease(checkImage);
//        [self.layer addSublayer:_checkersLayer];
        
        // Create a new context into which a grid an be drawn. This context can then be used to contents on the grid layer
//        CGContextRef context = [self createBitmapContextWithSize:(NSSize){256, 192}];
//        [self drawGridIntoContext:context];
//        _checkersLayer.contents = CFBridgingRelease(CGBitmapContextCreateImage(context));
        
        // Create a layer for displaying the drawing
        self.imageLayer = [CALayer layer];
        self.imageLayer.magnificationFilter = kCAFilterNearest;
        [self.imageLayer setAnchorPoint:(CGPoint){0, 0}];
        [self.imageLayer setBounds:(CGRect){0, 0, 256, 192}];
        [self.layer addSublayer:self.imageLayer];

        self.tempLayer = [CALayer layer];
        self.tempLayer.magnificationFilter = kCAFilterNearest;
        [self.tempLayer setAnchorPoint:(CGPoint){0, 0}];
        [self.tempLayer setBounds:(CGRect){0, 0, 256, 192}];
        [self.layer addSublayer:self.tempLayer];

    }
    return self;
}


- (void)drawGridIntoContext:(CGContextRef)context
{    
    for (int x = 0; x <= 256; x += 8) {
        CGContextMoveToPoint(context, x, 0);
        CGContextAddLineToPoint(context, x, 192);
    }
    
    for (int y = 0; y <= 192; y += 8) {
        CGContextMoveToPoint(context, 0, y);
        CGContextAddLineToPoint(context, 256, y);
    }
    
    CGContextStrokePath(context);
}


- (CGContextRef)createBitmapContextWithSize:(NSSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextSetShouldAntialias(context, NO);
    CGColorSpaceRelease(colorSpace);
    return context;
}


- (void)drawRect:(NSRect)dirtyRect
{
    NSGraphicsContext *context = [NSGraphicsContext currentContext];
    CGContextRef currentContext = [context graphicsPort];
    
    CGContextSetFillColorWithColor(currentContext, [NSColor whiteColor].CGColor);
    CGContextFillRect(currentContext, self.frame);
    CGContextSetStrokeColorWithColor(currentContext, [NSColor blackColor].CGColor);
    
    CGContextSetLineWidth(currentContext, 0.05);

    for (int x = 0; x <= 256; x += 8) {
        CGContextMoveToPoint(currentContext, x, 0);
        CGContextAddLineToPoint(currentContext, x, 192);
    }
    
    for (int y = 0; y <= 192; y += 8) {
        CGContextMoveToPoint(currentContext, 0, y);
        CGContextAddLineToPoint(currentContext, 256, y);
    }
    
    CGContextStrokePath(currentContext);
  
}


- (void)mouseMoved:(NSEvent *)event
{

}


- (void)updateTrackingAreas
{
    NSTrackingAreaOptions options = (NSTrackingActiveAlways | NSTrackingInVisibleRect |
                                     NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved);
    
    [self removeTrackingArea:_trackingArea];
    
    _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:options
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:_trackingArea];
}


@end
