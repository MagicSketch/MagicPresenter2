//
//  MagicPresenter.m
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenter.h"
#import "MagicPresenterWindowController.h"
#import <MPTracker/MPTracker.h>
//#import <dlfcn.h>

@interface MagicPresenter ()

@property (nonatomic, strong) MagicPresenterWindowController *window;
@property (nonatomic, strong) id context;
@property (nonatomic, copy) NSURL *bundleURL;
@property (nonatomic, strong) TrackerManager *tracker;

@end

@implementation MagicPresenter

- (instancetype)initWithContext:(id)context {
    if (self = [super init]) {
        _bundleURL = [context valueForKeyPath:@"command.pluginBundle.url"];
        
//        NSString* s = @"/Users/makkit/Library/Application Support/com.bohemiancoding.sketch3/Plugins/MagicPresenter2.sketchplugin/Contents/Sketch/MagicPresenterUI.framework";
//        dlopen([s UTF8String], RTLD_LAZY);
        // tracker init
        NSLog(@"%@", [SegmentIOTracker class]);
        NSLog(@"%@", [TrackerManager class]);
        SegmentIOTracker *segmentIO = [[SegmentIOTracker alloc] initWithWriteKey:@"ndKZLO3VTiTuygTrmVKQ1Uh4QDdKXrme"];
        _tracker = [[TrackerManager alloc] initWithTrackers:@[segmentIO] identifier:@"io.magicsketch.presenter2.tracker"];
        NSBundle *pluginBundle = [NSBundle bundleForClass:[self class]];
        
        NSString *env = nil;
#ifdef DEBUG
        env = @"Development";
#else
        env = @"Production";
#endif
        [_tracker setSuperProperties:@{
                                       @"Plugin Version":[pluginBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                                       @"Plugin Build":[pluginBundle objectForInfoDictionaryKey:@"CFBundleVersion"],
                                       @"Plugin Environment":env,
                                       }];
        [_tracker setAsSharedInstance];
    }
    return self;
}

- (void)play:(id)context {
    _context = context;

    id document = [context valueForKeyPath:@"document"];
    id slides = [document valueForKeyPath:@"currentPage.cachedArtboards"];
//    id slides = [document valueForKeyPath:@"immutableDocumentData.currentPage.artboards"];

    NSLog(@"slides %@", slides);
    [_tracker track:@"Started" properties:@{}];

    MagicPresenterWindowController *window = [[MagicPresenterWindowController alloc] initWithWindowNibName:@"MagicPresenterWindowController"];
    window.context = context;
    window.artboards = slides;
    [window showWindow:window.window];
    [window.window toggleFullScreen:nil];
    _window = window;
}

@end
