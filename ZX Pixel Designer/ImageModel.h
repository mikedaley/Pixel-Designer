//
//  ImageModel.h
//  ZX Pixel Designer
//
//  Created by Mike Daley on 03/01/2017.
//  Copyright © 2017 Mike Daley. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Forward Classes


@class Action;


#pragma mark - Interface


@interface ImageModel : NSObject

- (void)addAction:(Action *)action;
- (void)removeAction:(Action *)action;
- (Action *)getActionAtIndex:(NSUInteger)index;


@end
