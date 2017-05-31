//
//  MagicPresenterUISketchPanelCell.m
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenterUISketchPanelCell.h"

@interface MagicPresenterUISketchPanelCell ()

@end

@implementation MagicPresenterUISketchPanelCell

- (NSView *)view {
    return self;
}

+ (instancetype)loadNibNamed:(NSString *)nibName {
    NSNib *nib = [[NSNib alloc] initWithNibNamed:nibName bundle:[NSBundle bundleForClass:[self class]]];
    NSArray *views;
    [nib instantiateWithOwner:nil topLevelObjects:&views];

    NSArray *filtered = [views filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[self class]];
    }]];

    return [filtered firstObject];
}

@end
