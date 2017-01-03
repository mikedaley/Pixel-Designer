//
//  TrackingView.m
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

#import "TrackingView.h"

@implementation TrackingView
{
    NSTrackingArea *_trackingArea;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self updateTrackingAreas];
        [self.window setAcceptsMouseMovedEvents:YES];
    }
    return self;
}


- (void)awakeFromNib
{
    [self updateTrackingAreas];
    [self.window setAcceptsMouseMovedEvents:YES];    
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
