//
//  MagicPresenterUISketchPanelController.h
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

@import Cocoa;
#import "MagicPresenterUIMSDocument.h"
#import "MagicPresenterUIMSInspectorStackView.h"
#import "MagicPresenterUISketchPanelDataSource.h"
@class MagicPresenterUISketchPanel;

@interface MagicPresenterUISketchPanelController : NSObject <MagicPresenterUISketchPanelDataSource>

@property (nonatomic, strong, readonly) id <MagicPresenterUIMSInspectorStackView> stackView; // MSInspectorStackView
@property (nonatomic, strong, readonly) MagicPresenterUISketchPanel *panel;
@property (nonatomic, copy) id context;

- (instancetype)initWithContext:(id)context;
- (void)selectionDidChange:(NSArray *)selection;

@end
