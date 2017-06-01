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
#import "MagicPresenterUtil.h"
#import "MagicPresenterArtboardRenderer.h"

@interface MagicPresenterUISketchPanelController ()

@property (nonatomic, strong) id <MagicPresenterUIMSInspectorStackView> stackView; // MSInspectorStackView
@property (nonatomic, strong) MagicPresenterUISketchPanel *panel;
@property (nonatomic, copy) NSArray *selection;
@property (nonatomic, strong) MagicPresenterArtboardRenderer *renderer;

@end

@implementation MagicPresenterUISketchPanelController

- (instancetype)initWithContext:(id)context {
    if (self = [super init]) {
        _context = context;
        _panel = [[MagicPresenterUISketchPanel alloc] initWithStackView:nil];
        _panel.datasource = self;
        _renderer = [[MagicPresenterArtboardRenderer alloc] init];
    }
    return self;
}

- (void)selectionDidChange:(id)context {
    _context = context;

    self.selection = @[[[MagicPresenterUtilGetSelection(context) firstObject] valueForKeyPath:@"parentArtboard"]];
    self.panel.stackView = MagicPresenterUtilGetStackView(context);
    [self.panel reloadData];
}

#pragma mark - MagicPresenterUISketchPanelDataSource

- (MagicPresenterUISketchPanelCell *)headerForMagicPresenterUISketchPanel:(MagicPresenterUISketchPanel *)panel {
    MagicPresenterUISketchPanelCellHeader *cell = (MagicPresenterUISketchPanelCellHeader *)[panel dequeueReusableCellForReuseIdentifier:@"header"];
    if ( ! cell) {
        cell = [MagicPresenterUISketchPanelCellHeader loadNibNamed:@"MagicPresenterUISketchPanelCellHeader"];
        cell.reuseIdentifier = @"header";
    }
    cell.context = self.context;
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

    id layer = self.selection[0];
    _renderer.context = self.context;
    NSLog(@"_renderer %@", _renderer);

    [_renderer renderArtboard:layer completion:^(NSImage *image) {
        NSLog(@"image %@", image);
        cell.imageView.image = image;
    }];

    return cell;
}

@end
