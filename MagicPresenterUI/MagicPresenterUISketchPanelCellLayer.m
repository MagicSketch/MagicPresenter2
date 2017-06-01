//
//  MagicPresenterUISketchPanelCellLayer.m
//  MagicPresenter2
//
//  Created by James Tang on 1/6/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenterUISketchPanelCellLayer.h"
#import "MagicPresenterUtil.h"

@implementation MagicPresenterUISketchPanelCellLayer

- (void)setContext:(id)context {
    _context = [context copy];
    [self reloadData];
}

- (void)setMslayer:(id)mslayer {
    _mslayer = mslayer;
    [self reloadData];
}

- (void)reloadData {
    if ( ! _mslayer) {
        self.textField.stringValue = @"";
    } else {
        if (_context) {
            NSString *value = self.textField.stringValue;
            NSString *type = [self.typeButton.selectedItem title];

            // TO implement

        }
    }
}

@end
