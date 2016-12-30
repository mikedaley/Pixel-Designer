//
//  CenteredClipView.m
//  ZX Pixel Designer
//
//  Created by Mike Daley on 28/12/2016.
//  Copyright © 2016 Mike Daley. All rights reserved.
//

#import "CenteredClipView.h"

@implementation CenteredClipView


- (NSRect)constrainBoundsRect:(NSRect)proposedClipViewBoundsRect {
    
    NSRect constrainedClipViewBoundsRect;
    NSRect documentViewFrameRect = [self.documentView frame];
    
    constrainedClipViewBoundsRect = [super constrainBoundsRect:proposedClipViewBoundsRect];
    
    // If proposed clip view bounds width is greater than document view frame width, center it horizontally.
    if (proposedClipViewBoundsRect.size.width >= documentViewFrameRect.size.width) {
        // Adjust the proposed origin.x
        constrainedClipViewBoundsRect.origin.x = centeredCoordinateUnitWithProposedContentViewBoundsDimensionAndDocumentViewFrameDimension(proposedClipViewBoundsRect.size.width, documentViewFrameRect.size.width);
    }
    
    // If proposed clip view bounds is hight is greater than document view frame height, center it vertically.
    if (proposedClipViewBoundsRect.size.height >= documentViewFrameRect.size.height) {
        
        // Adjust the proposed origin.y
        constrainedClipViewBoundsRect.origin.y = centeredCoordinateUnitWithProposedContentViewBoundsDimensionAndDocumentViewFrameDimension(proposedClipViewBoundsRect.size.height, documentViewFrameRect.size.height);
    }
    
    return constrainedClipViewBoundsRect;
}


CGFloat centeredCoordinateUnitWithProposedContentViewBoundsDimensionAndDocumentViewFrameDimension (CGFloat proposedContentViewBoundsDimension, CGFloat documentViewFrameDimension )
{
    CGFloat result = floor( (proposedContentViewBoundsDimension - documentViewFrameDimension) / -2.0f );
    return result;
}

@end
