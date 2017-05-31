//
//  MagicPresenterWindowController.m
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenterWindowController.h"
#import "MagicPresenterArtboardRenderer.h"

@interface MagicPresenterWindowController ()

@property (nonatomic, strong) MagicPresenterArtboardRenderer *renderer;

@end

@implementation MagicPresenterWindowController

- (void)commonInit {
    _renderer = [[MagicPresenterArtboardRenderer alloc] init];
    _index = 0;
}

- (instancetype)initWithWindowNibName:(NSString *)windowNibName {
    self = [super initWithWindowNibName:windowNibName];
    [self commonInit];
    return self;
}

- (void)setArtboards:(NSArray *)artboards {
    _artboards = [artboards copy];
    [self reloadData];
}

- (void)setContext:(id)context {
    _context = context;
    _renderer.context = self.context;
    [self reloadData];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [self reloadData];
}

- (void)reloadData {
    __weak __typeof (self) weakSelf = self;
    id artboard = self.artboards[self.index];
    if ( ! _renderer.context) {
        return;
    }
    if ( ! artboard) {
        return;
    }
    [_renderer renderArtboard:artboard completion:^(NSImage *image) {
        weakSelf.imageView.image = image;
    }];
}

- (IBAction)leftButtonDidPress:(id)sender {
    self.index = MAX(_index - 1, 0);
    [self reloadData];
}

- (IBAction)rightButtonDidPress:(id)sender {
    self.index = MIN(_index + 1, [self.artboards count] - 1);
    [self reloadData];
}

@end
