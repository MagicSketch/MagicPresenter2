//
//  MagicPresenterUISketchPanel.h
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicPresenterUISketchPanelDataSource.h"
#import "MagicPresenterUIMSInspectorStackView.h"

@class MagicPresenterUISketchPanelCell;

@interface MagicPresenterUISketchPanel : NSObject

@property (nonatomic, strong, readonly) NSArray *views;
@property (nonatomic, weak) id <MagicPresenterUIMSInspectorStackView> stackView;
@property (nonatomic, weak) id <MagicPresenterUISketchPanelDataSource> datasource;

- (instancetype)initWithStackView:(id <MagicPresenterUIMSInspectorStackView>)stackView;
- (void)reloadData;
- (MagicPresenterUISketchPanelCell *)dequeueReusableCellForReuseIdentifier:(NSString *)identifier;

@end
