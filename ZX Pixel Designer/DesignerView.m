//
//  designerView.m
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

#import "DesignerView.h"
#import <Quartz/Quartz.h>
#import <CoreImage/CoreImage.h>

@implementation DesignerView
{
    CALayer *_checkersLayer;
    CIImage *_checkersImage;
}


-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        self.wantsLayer = YES;
//        self.layer.backgroundColor = [NSColor whiteColor].CGColor;
//        self.layer.magnificationFilter = kCAFilterNearest;

        CIFilter *checkers = [CIFilter filterWithName:@"CICheckerboardGenerator"];
        [checkers setDefaults];
        [checkers setValue:[CIVector vectorWithX:0 Y:0] forKey:@"inputCenter"];
        [checkers setValue:[CIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] forKey:@"inputColor0"];
        [checkers setValue:[CIColor colorWithRed:1 green:1 blue:1 alpha:1] forKey:@"inputColor1"];
        [checkers setValue:@(8) forKey:@"inputWidth"];
        _checkersImage = [checkers valueForKey:@"outputImage"];
        
        CIContext *con = [CIContext contextWithOptions:nil];
        CGImageRef checkImage = [con createCGImage:_checkersImage fromRect:(CGRect){0, 0, 256, 192}];
        
        _checkersLayer = [CALayer layer];
        _checkersLayer.magnificationFilter = kCAFilterNearest;
        _checkersLayer.masksToBounds = YES;
        [_checkersLayer setAnchorPoint:(CGPoint){0, 0}];
        [_checkersLayer setBounds:(CGRect){0, 0, 256, 192}];
        _checkersLayer.contents = CFBridgingRelease(checkImage);
        [self.layer addSublayer:_checkersLayer];
        
        self.imageLayer = [CALayer layer];
        self.imageLayer.magnificationFilter = kCAFilterNearest;
        [self.imageLayer setAnchorPoint:(CGPoint){0, 0}];
        [self.imageLayer setBounds:(CGRect){0, 0, 256, 192}];
        [self.layer addSublayer:self.imageLayer];
    
    }
    return self;
}


@end
