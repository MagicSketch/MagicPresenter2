//
//  MagicPresenterUISketchPanelCellDefault.m
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenterUISketchPanelCellDefault.h"

@implementation MagicPresenterUISketchPanelCellDefault

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    // Drawing code here.
}

- (void)setAspectRatio:(NSSize)aspectRatio {
    _aspectRatio = aspectRatio;
    CGFloat width = self.bounds.size.width;
    CGFloat height = (width - 16) * _aspectRatio.height / _aspectRatio.width;
    [self setFrameSize:NSMakeSize(width, height + 16)];
}

@end
