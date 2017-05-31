//
//  MagicPresenterUISketchPanelDataSource.h
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MagicPresenterUISketchPanel;
@class MagicPresenterUISketchPanelCell;

@protocol MagicPresenterUISketchPanelDataSource <NSObject>

- (NSUInteger)numberOfRowsForMagicPresenterUISketchPanel:(MagicPresenterUISketchPanel *)panel;
- (MagicPresenterUISketchPanelCell *)MagicPresenterUISketchPanel:(MagicPresenterUISketchPanel *)panel itemForRowAtIndex:(NSUInteger)index;
- (MagicPresenterUISketchPanelCell *)headerForMagicPresenterUISketchPanel:(MagicPresenterUISketchPanel *)panel;

@end
