//
//  ImageModel.m
//  ZX Pixel Designer
//
//  Created by Mike Daley on 03/01/2017.
//  Copyright © 2017 Mike Daley. All rights reserved.
//

#import "ImageModel.h"
#import "Action.h"

@implementation ImageModel
{
    NSMutableArray *_actionsArray;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _actionsArray = [NSMutableArray new];
    }
    return self;
}


- (void)addAction:(Action *)action
{
    [_actionsArray addObject:action];
}


- (void)removeAction:(Action *)action
{
    [_actionsArray removeObject:action];
}


- (Action *)getActionAtIndex:(NSUInteger)index
{
    return [_actionsArray objectAtIndex:index];
}

@end
