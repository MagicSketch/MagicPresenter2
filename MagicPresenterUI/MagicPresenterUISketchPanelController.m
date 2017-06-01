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
#import "MagicPresenterUISketchPanelCellLayer.h"

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

    NSArray *selection = MagicPresenterUtilGetSelection(context);

    if (selection && [selection respondsToSelector:@selector(firstObject)] && [selection firstObject]) {

        if ([[selection firstObject] isMemberOfClass:NSClassFromString(@"MSArtboardGroup")]) {
            selection = @[[selection firstObject]];
        } else {
            selection = @[[[selection firstObject] valueForKeyPath:@"parentArtboard"],
                          [selection firstObject]];
        }
    } else {
        selection = @[];
    }
    self.selection = selection;
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
    cell.titleLabel.stringValue = @"Magic Presenter 2";
    return cell;
}

- (NSUInteger)numberOfRowsForMagicPresenterUISketchPanel:(MagicPresenterUISketchPanel *)panel {
    return self.selection.count;    // Using self.selection as number of rows in the panel
}

- (MagicPresenterUISketchPanelCell *)MagicPresenterUISketchPanel:(MagicPresenterUISketchPanel *)panel itemForRowAtIndex:(NSUInteger)index {

    id layer = self.selection[index];

    if ([layer isMemberOfClass:NSClassFromString(@"MSArtboardGroup")]) {

        MagicPresenterUISketchPanelCellDefault *cell = (MagicPresenterUISketchPanelCellDefault *)[panel dequeueReusableCellForReuseIdentifier:@"artboardCell"];
        if ( ! cell) {
            cell = [MagicPresenterUISketchPanelCellDefault loadNibNamed:@"MagicPresenterUISketchPanelCellDefault"];
            cell.reuseIdentifier = @"artboardCell";
        }

        _renderer.context = self.context;

        [_renderer renderArtboard:layer scale:0.2 completion:^(NSImage *image) {
            cell.imageView.image = image;
        }];

        cell.aspectRatio = [(NSValue *)[layer valueForKeyPath:@"frame.size"] sizeValue];

        return cell;

    } else if ([layer isKindOfClass:NSClassFromString(@"MSLayer")]) {

        MagicPresenterUISketchPanelCellLayer *cell = (MagicPresenterUISketchPanelCellLayer *)[panel dequeueReusableCellForReuseIdentifier:@"layerCell"];
        if ( ! cell) {
            cell = [MagicPresenterUISketchPanelCellLayer loadNibNamed:@"MagicPresenterUISketchPanelCellLayer"];
            cell.reuseIdentifier = @"layerCell";
        }

        cell.context = self.context;
        cell.mslayer = layer;

        return cell;
    }

    return nil;
}

@end
