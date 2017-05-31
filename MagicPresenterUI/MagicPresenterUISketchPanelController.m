//
//  MagicPresenterUISketchPanelController.m
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenterUISketchPanelController.h"
#import "MagicPresenterUISketchPanelCell.h"
#import "MagicPresenterUISketchPanelCellHeader.h"
#import "MagicPresenterUISketchPanelCellDefault.h"
#import "MagicPresenterUISketchPanel.h"
#import "MagicPresenterUISketchPanelDataSource.h"


@interface MagicPresenterUISketchPanelController ()

@property (nonatomic, strong) id <MagicPresenterUIMSInspectorStackView> stackView; // MSInspectorStackView
@property (nonatomic, strong) id <MagicPresenterUIMSDocument> document;
@property (nonatomic, strong) MagicPresenterUISketchPanel *panel;
@property (nonatomic, copy) NSArray *selection;

@end

@implementation MagicPresenterUISketchPanelController

- (instancetype)initWithDocument:(id <MagicPresenterUIMSDocument>)document {
    if (self = [super init]) {
        _document = document;
        _panel = [[MagicPresenterUISketchPanel alloc] initWithStackView:nil];
        _panel.datasource = self;
    }
    return self;
}

- (void)selectionDidChange:(NSArray *)selection {
    self.selection = [selection valueForKey:@"layers"];         // To get NSArray from MSLayersArray

    self.panel.stackView = [(NSObject *)_document valueForKeyPath:@"inspectorController.currentController.stackView"];
    [self.panel reloadData];
}

#pragma mark - MagicPresenterUISketchPanelDataSource

- (MagicPresenterUISketchPanelCell *)headerForMagicPresenterUISketchPanel:(MagicPresenterUISketchPanel *)panel {
    MagicPresenterUISketchPanelCellHeader *cell = (MagicPresenterUISketchPanelCellHeader *)[panel dequeueReusableCellForReuseIdentifier:@"header"];
    if ( ! cell) {
        cell = [MagicPresenterUISketchPanelCellHeader loadNibNamed:@"MagicPresenterUISketchPanelCellHeader"];
        cell.reuseIdentifier = @"header";
    }
    cell.titleLabel.stringValue = @"MagicPresenterUI";
    return cell;
}

- (NSUInteger)numberOfRowsForMagicPresenterUISketchPanel:(MagicPresenterUISketchPanel *)panel {
    return self.selection.count;    // Using self.selection as number of rows in the panel
}

- (MagicPresenterUISketchPanelCell *)MagicPresenterUISketchPanel:(MagicPresenterUISketchPanel *)panel itemForRowAtIndex:(NSUInteger)index {
    MagicPresenterUISketchPanelCellDefault *cell = (MagicPresenterUISketchPanelCellDefault *)[panel dequeueReusableCellForReuseIdentifier:@"cell"];
    if ( ! cell) {
        cell = [MagicPresenterUISketchPanelCellDefault loadNibNamed:@"MagicPresenterUISketchPanelCellDefault"];
        cell.reuseIdentifier = @"cell";
    }

    id layer = self.selection[index];
    cell.titleLabel.stringValue = [layer name];
    cell.imageView.image = [layer valueForKeyPath:@"previewImages.LayerListPreviewUnfocusedImage"];

    return cell;
}

@end
