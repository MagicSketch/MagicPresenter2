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
    _index = -1;
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
    _imageView.imageScaling = NSImageScaleProportionallyUpOrDown;
    [self reloadData];
}

- (void)reloadData {
    __weak __typeof (self) weakSelf = self;
    if ( ! _renderer.context) {
        return;
    }
    if ( ! _artboards) {
        return;
    }
    if ( _index == -1) {
        id selectedArtboardObjectID = [[_context valueForKeyPath:@"selection.parentArtboard.objectID"] firstObject];
        NSArray *artboardIDs = [self.artboards valueForKeyPath:@"objectID"];
        _index = [artboardIDs indexOfObject:selectedArtboardObjectID];
        if (_index == NSNotFound) {
            _index = 0;
        }
    }
    if ( _index >= [_artboards count]) {
        return;
    }
    id artboard = self.artboards[self.index];

    self.window.title = [NSString stringWithFormat:@"Page %@ of %@ (%@)", @(_index), @([self.artboards count] - 1), [_context valueForKeyPath:@"document.fileName"]];
    [_renderer renderArtboard:artboard completion:^(NSImage *image) {
        weakSelf.imageView.image = image;
    }];
}

- (void)goNext {
    self.index = MIN(_index + 1, [self.artboards count] - 1);
    [self reloadData];
}

- (void)goPrevious {
    self.index = MAX(_index - 1, 0);
    [self reloadData];
}

- (IBAction)leftButtonDidPress:(id)sender {
    [self goPrevious];
}

- (IBAction)rightButtonDidPress:(id)sender {
    [self goNext];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void)keyDown:(NSEvent *)event {
    NSLog(@"keyDown %@", @([event keyCode]));

    switch ([event keyCode]) {

        case 125: // down
        case 124: // right
            [self goNext];
            break;

        case 126: // top
        case 123: // left
            [self goPrevious];
            break;
        default:
            break;
    }
}

@end
