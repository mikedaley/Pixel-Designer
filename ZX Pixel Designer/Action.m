//
//  Action.m
//  ZX Pixel Designer
//
//  Created by Mike Daley on 03/01/2017.
//  Copyright © 2017 Mike Daley. All rights reserved.
//

#import "Action.h"

@implementation Action


- (instancetype)initWithActionType:(ActionType)actionType path:(CGMutablePathRef)path inkColor:(NSColor *)inkColor paperColor:(NSColor *)paperColor
{
    self = [super init];
    if (self)
    {
        _actionType = actionType;
        _path = path;
        _inkColor = inkColor;
        _paperColor = paperColor;
    }
    return self;
}

@end
