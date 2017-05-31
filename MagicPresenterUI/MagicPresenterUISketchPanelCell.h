//
//  MagicPresenterUISketchPanelCell.h
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MagicPresenterUISketchPanelCell;

@interface MagicPresenterUISketchPanelCell : NSView

@property (nonatomic, copy) NSString *reuseIdentifier;

+ (instancetype)loadNibNamed:(NSString *)nibName;

@end
