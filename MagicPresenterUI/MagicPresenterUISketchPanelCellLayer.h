//
//  MagicPresenterUISketchPanelCellLayer.h
//  MagicPresenter2
//
//  Created by James Tang on 1/6/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenterUISketchPanelCell.h"

@interface MagicPresenterUISketchPanelCellLayer : MagicPresenterUISketchPanelCell

@property (nonatomic, copy) id context;
@property (nonatomic, strong) id mslayer; // MSLayer
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSPopUpButton *typeButton;

@end
