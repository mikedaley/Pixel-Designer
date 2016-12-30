//
//  Document.m
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

#import "Document.h"

#pragma mark - Private Interface

@interface Document ()

@end


#pragma mark - Implementation


@implementation Document
{
    NSBitmapImageRep *_bitmapRep;
    CGContextRef _bitmapContext;
    NSPoint _prevPoint;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        _bitmapContext = [self createBitmapContextWithSize:(NSSize){256, 192}];
    
    }
    return self;
}


+ (BOOL)autosavesInPlace {
    return YES;
}


- (void)makeWindowControllers {
    // Override to return the Storyboard file name of the document.
    [self addWindowController:[[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"Document Window Controller"]];
}


#pragma mark - Save/Load


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return YES;
}


#pragma mark - Setting pixels


- (void)setPixelAtPoint:(NSPoint)point
{
    point.x = floorf(point.x);
    point.y = floorf(point.y);
    
    CGContextSetStrokeColorWithColor(_bitmapContext, [NSColor redColor].CGColor);
}


- (void)unsetPixelAtPoint:(NSPoint)point
{
    point.x = floorf(point.x);
    point.y = floorf(point.y);
    CGContextSetStrokeColorWithColor(_bitmapContext, [NSColor blueColor].CGColor);
}


- (void)mouseDownAtPoint:(NSPoint)point
{
    point.x = floorf(point.x);
    point.y = floorf(point.y);
    _prevPoint = point;
}


- (void)mouseDraggedAtPoint:(NSPoint)point
{
    point.x = floorf(point.x);
    point.y = floorf(point.y);
    CGContextMoveToPoint(_bitmapContext, _prevPoint.x, _prevPoint.y);
    CGContextAddLineToPoint(_bitmapContext, point.x, point.y);
    CGContextStrokePath(_bitmapContext);
    _prevPoint = point;

}


- (void)mouseUp
{
//    CGContextStrokePath(_bitmapContext);
}


- (CGImageRef)image
{
    return CGBitmapContextCreateImage(_bitmapContext);
}

#pragma mark - ImageRep Setup


- (CGContextRef)createBitmapContextWithSize:(NSSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextSetShouldAntialias(context, NO);

    //    NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
//                                                                         pixelsWide:size.width
//                                                                         pixelsHigh:size.height
//                                                                      bitsPerSample:8
//                                                                    samplesPerPixel:4
//                                                                           hasAlpha:YES
//                                                                           isPlanar:NO
//                                                                     colorSpaceName:NSCalibratedRGBColorSpace
//                                                                       bitmapFormat:0
//                                                                        bytesPerRow:0
//                                                                       bitsPerPixel:0];
//    return imageRep;
    
    CGColorSpaceRelease(colorSpace);
    return context;
}

@end
