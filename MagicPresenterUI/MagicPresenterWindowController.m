//
//  MagicPresenterWindowController.m
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenterWindowController.h"
#import "MagicPresenterArtboardRenderer.h"
#import <MPTracker/TrackerManager.h>

@interface MagicPresenterWindowController () <NSWindowDelegate>

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

    self.window.delegate = self;
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

    [self.loadingIndicator startAnimation:nil];
    [_renderer renderArtboard:artboard scale:0.3 completion:^(NSImage *image) {
        weakSelf.imageView.image = image;
        [_renderer renderArtboard:artboard scale:2 completion:^(NSImage *image) {
            weakSelf.imageView.image = image;
            [weakSelf.loadingIndicator stopAnimation:nil];
            [weakSelf preloadNextPage];
        }];
    }];
}

- (void)preloadNextPage {
    NSUInteger index = self.index + 1;
    if (index >= [self.artboards count]) {
        return;
    }
    id artboard = self.artboards[index];
    [_renderer renderArtboard:artboard scale:0.3 completion:^(NSImage *image) {
        [_renderer renderArtboard:artboard scale:2 completion:^(NSImage *image) {
        }];
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
    [[TrackerManager sharedInstance] track:@"Clicked Left Button" properties:nil];
    [self goPrevious];
}

- (IBAction)rightButtonDidPress:(id)sender {
    [[TrackerManager sharedInstance] track:@"Clicked Right Button" properties:nil];
    [self goNext];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void)keyDown:(NSEvent *)event {
    NSLog(@"keyDown %@", @([event keyCode]));

    switch ([event keyCode]) {

        case 125: // down
            [[TrackerManager sharedInstance] track:@"Press DownArrow" properties:nil];
            [self goNext];
            break;
        case 124: // right
            [[TrackerManager sharedInstance] track:@"Press RightArrow" properties:nil];
            [self goNext];
            break;

        case 126: // top
            [[TrackerManager sharedInstance] track:@"Press TopArrow" properties:nil];
            [self goPrevious];
            break;
        case 123: // left
            [[TrackerManager sharedInstance] track:@"Press LeftArrow" properties:nil];
            [self goPrevious];
            break;
        default:
            break;
    }
}

#pragma mark NSWindowDelegate

- (void)windowDidEnterFullScreen:(NSNotification *)notification {
    [self.window makeKeyAndOrderFront:self];
}

- (void)windowWillExitFullScreen:(NSNotification *)notification {
    id artboard = self.artboards[self.index];
    if([artboard respondsToSelector:NSSelectorFromString(@"select:byExtendingSelection:")]){
        [artboard performSelector:NSSelectorFromString(@"select:byExtendingSelection:") withObject:@true withObject:@false];
        id view = nil;
        @try{
           view = [self.context valueForKeyPath:@"document.contentDrawView"];
        }@catch (NSException * e){
            
        }
        
        if(view == nil){
            @try{
                view = [self.context valueForKeyPath:@"document.currentView"];
            }@catch(NSException * e){
                
            }
        }
        
        if(view != nil){
            [view valueForKeyPath:@"centerSelectionInVisibleArea"];
        }
    }else{
        NSLog(@"Select artboard API changed?");
    }

}

- (void)windowDidExitFullScreen:(NSNotification *)notification {
    [self.window makeKeyAndOrderFront:self];
}

@end
