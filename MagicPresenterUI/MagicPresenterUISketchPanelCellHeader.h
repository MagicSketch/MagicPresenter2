//
//  MagicPresenterUISketchPanelCellHeader.h
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MagicPresenterUISketchPanelCell.h"

@interface MagicPresenterUISketchPanelCellHeader : MagicPresenterUISketchPanelCell

@property (nonatomic, weak) IBOutlet NSTextField *titleLabel;
@property (nonatomic, copy) id context;

@end
