//
//  Action.h
//  ZX Pixel Designer
//
//  Created by Mike Daley on 03/01/2017.
//  Copyright © 2017 Mike Daley. All rights reserved.
//

#import <Quartz/Quartz.h>

#pragma mark - Types


typedef NS_ENUM(NSUInteger, ActionType)
{
    ActionTypeChangePixelColor,
    ActionTypeChangeBackgroundColor,
    ActionTypeDrawPoint,
    ActionTypeDrawLine
};


#pragma mark - Interface


@interface Action : NSObject

// Properties
@property (assign) ActionType actionType;
@property (assign) CGMutablePathRef path;
@property (strong) NSColor *inkColor;
@property (strong) NSColor *paperColor;


// Methods
- (instancetype)initWithActionType:(ActionType)actionType path:(CGMutablePathRef)path inkColor:(NSColor *)inkColor paperColor:(NSColor *)paperColor;


@end
