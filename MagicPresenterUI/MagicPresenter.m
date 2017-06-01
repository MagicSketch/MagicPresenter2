//
//  MagicPresenter.m
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenter.h"
#import "MagicPresenterWindowController.h"

@interface MagicPresenter ()

@property (nonatomic, strong) MagicPresenterWindowController *window;
@property (nonatomic, strong) id context;
@property (nonatomic, copy) NSURL *bundleURL;

@end

@implementation MagicPresenter

- (instancetype)initWithContext:(id)context {
    if (self = [super init]) {
        _bundleURL = [context valueForKeyPath:@"command.pluginBundle.url"];
    }
    return self;
}

- (void)play:(id)context {
    _context = context;

    id document = [context valueForKeyPath:@"document"];
    id slides = [document valueForKeyPath:@"currentPage.cachedArtboards"];
//    id slides = [document valueForKeyPath:@"immutableDocumentData.currentPage.artboards"];

    NSLog(@"slides %@", slides);

    MagicPresenterWindowController *window = [[MagicPresenterWindowController alloc] initWithWindowNibName:@"MagicPresenterWindowController"];
    window.context = context;
    window.artboards = slides;
    [window showWindow:window.window];
    [window.window toggleFullScreen:nil];
    _window = window;
}

@end
