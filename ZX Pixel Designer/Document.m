//
//  Document.m
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

#import "Document.h"
#import "Action.h"
#import "ImageModel.h"


#pragma mark - Private Interface

@interface Document ()

@end


#pragma mark - Implementation


@implementation Document
{
    CGContextRef _pixelAttrContext;
    CGContextRef _pixelContext;
    CGContextRef _tempContext;
    
    NSPoint _previousMousePoint;
    NSPoint _currentMousePoint;
    
    NSColor *_inkColor;
    NSColor *_paperColor;
}


- (instancetype)init {
    self = [super init];
    if (self)
    {
        // Add your subclass-specific initialization here.
        _imageModel = [ImageModel new];
        _pixelAttrContext = [self createBitmapContextWithSize:(NSSize){256, 192}];
        _pixelContext = [self createBitmapContextWithSize:(NSSize){256, 192}];
        _tempContext = [self createBitmapContextWithSize:(NSSize){256, 192}];
        _inkColor = [NSColor blackColor];
        _paperColor = [NSColor whiteColor];
    }
    return self;
}


+ (BOOL)autosavesInPlace
{
    return YES;
}


- (void)makeWindowControllers
{
    // Override to return the Storyboard file name of the document.
    [self addWindowController:[[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"Document Window Controller"]];
}


#pragma mark - Save/Load


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return YES;
}


#pragma mark - Setting pixels


- (void)setPixelAtPoint:(NSPoint)point
{
//    point.x = floorf(point.x);
//    point.y = floorf(point.y);
//    
//    CGContextSetStrokeColorWithColor(_bitmapContext, [NSColor redColor].CGColor);
    
//    NSUInteger color[3] = {0, 1, 1};
//    [_bitmapRep setPixel:color atX:point.x y:point.y];
    
//    [_bitmapRep setColor:self.inkColor atX:point.x y:point.y];
//    
//    int char_x = point.x / 8;
//    int char_y = point.y / 8;
//    
//    for (int y = char_y * 8; y < (char_y * 8) + 8; y++)
//    {
//        for (int x = char_x * 8; x < (char_x * 8) + 8; x++)
//        {
//            NSColor *color = [_bitmapRep colorAtX:x y:y];
//            if ([color isNotEqualTo:self.inkColor] && [color isNotEqualTo:self.backgroundColour])
//            {
//                [_bitmapRep setColor:self.backgroundColour atX:x y:y];
//            }
//        }
//    }
}


#pragma mark - Mouse Events


- (void)mouseDownAtPoint:(NSPoint)point withActionType:(ActionType)actionType
{
    point.x = floorf(point.x) + 0.5;
    point.y = floorf(point.y) + 0.5;

    CGContextSetFillColorWithColor(_tempContext, [NSColor blueColor].CGColor);
    CGContextClearRect(_tempContext, (NSRect){0, 0, 256, 192});
    
    switch (actionType) {
        case ActionTypeDrawPoint:
        {
            _previousMousePoint = _currentMousePoint;
            _currentMousePoint = point;
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, (NSRect){point.x, point.y, 0.5, 0.5});
            Action *action = [[Action alloc] initWithActionType:actionType path:path inkColor:_inkColor paperColor:_paperColor];
            [self drawAction:action inContext:_tempContext];
            break;
        }
            
        case ActionTypeDrawLine:
            _previousMousePoint = _currentMousePoint;
            _currentMousePoint = point;
            break;
            
        default:
            break;
    }
    
}


- (void)mouseDraggedAtPoint:(NSPoint)point withActionType:(ActionType)actionType
{
    point.x = floorf(point.x) + 0.5;
    point.y = floorf(point.y) + 0.5;
    
    CGContextSetFillColorWithColor(_tempContext, [NSColor blueColor].CGColor);
    CGContextClearRect(_tempContext, (NSRect){0, 0, 256, 192});

    switch (actionType) {
        case ActionTypeDrawPoint:
        {
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, (NSRect){point.x, point.y, 0.5, 0.5});
            Action *action = [[Action alloc] initWithActionType:actionType path:path inkColor:_inkColor paperColor:_paperColor];
            [self drawAction:action inContext:_tempContext];
            break;
        }
            
        case ActionTypeDrawLine:
        {
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, _currentMousePoint.x, _currentMousePoint.y);
            CGPathAddLineToPoint(path, NULL, point.x, point.y);
            Action *action = [[Action alloc] initWithActionType:actionType path:path inkColor:_inkColor paperColor:_paperColor];
            [self drawAction:action inContext:_tempContext];
            
            break;
        }
        default:
            break;
    }

}


- (void)mouseUpAtPoint:(NSPoint)point withActionActionType:(ActionType)actionType
{
    point.x = floorf(point.x) + 0.5;
    point.y = floorf(point.y) + 0.5;
    
    CGContextClearRect(_tempContext, (NSRect){0, 0, 256, 192});

    switch (actionType) {
        case ActionTypeDrawPoint:
        {
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, (NSRect){_currentMousePoint.x, _currentMousePoint.y, 0.5, 0.5});
            Action *action = [[Action alloc] initWithActionType:actionType path:path inkColor:_inkColor paperColor:_paperColor];
            [self.imageModel addAction:action];
            [self drawAction:action inContext:_pixelAttrContext];
            break;
        }
            
        case ActionTypeDrawLine:
        {
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, _currentMousePoint.x, _currentMousePoint.y);
            CGPathAddLineToPoint(path, NULL, point.x, point.y);
            Action *action = [[Action alloc] initWithActionType:actionType path:path inkColor:_inkColor paperColor:_paperColor];
            [self.imageModel addAction:action];
            [self drawAction:action inContext:_pixelAttrContext];
            
            break;
        }
        default:
            break;
    }

}


- (void)mouseMovedAtPoint:(NSPoint)point withActionType:(ActionType)actionType
{
    
}


#pragma mark - Drawing

- (void)drawAction:(Action *)action inContext:(CGContextRef)context
{
    CGContextSetStrokeColorWithColor(context, _inkColor.CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextAddPath(context, action.path);
    CGContextDrawPath(context, kCGPathStroke);
}

#pragma mark - Getters

- (CGImageRef)image
{
    return CGBitmapContextCreateImage(_pixelAttrContext);
}

- (CGImageRef)tempImage
{
    return CGBitmapContextCreateImage(_tempContext);
}

#pragma mark - ImageRep Setup


- (NSBitmapImageRep *)createBitmapImageRepWithSize:(NSSize)size
{
    NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                                         pixelsWide:size.width
                                                                         pixelsHigh:size.height
                                                                      bitsPerSample:8
                                                                    samplesPerPixel:3
                                                                           hasAlpha:NO
                                                                           isPlanar:NO
                                                                     colorSpaceName:NSCalibratedRGBColorSpace
                                                                       bitmapFormat:NSBitmapFormatAlphaNonpremultiplied
                                                                        bytesPerRow:0
                                                                       bitsPerPixel:0];
    return imageRep;
}


- (CGContextRef)createBitmapContextWithSize:(NSSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextSetShouldAntialias(context, NO);
    
    CGColorSpaceRelease(colorSpace);
    return context;
}

@end
