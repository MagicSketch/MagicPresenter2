//
//  MagicPresenterArtboardRenderer.m
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenterArtboardRenderer.h"
#import <CocoaScript/COScript.h>
#import "MagicPresenterUtil.h"

@interface MagicPresenterArtboardRenderer ()

@property (nonatomic, strong) NSMutableDictionary *cache;

@end

@implementation MagicPresenterArtboardRenderer

- (instancetype)init {
    self = [super init];
    _cache = [[NSMutableDictionary alloc] init];
    return self;
}

- (NSString *)contentsOfFile:(NSString *)fileName {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:nil];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    return content;
}

- (void)renderArtboard:(id)artboard
                 scale:(CGFloat)scale
            completion:(MagicPresenterArtboardRendererCompletionHandler)completion {

    NSString *script = [self contentsOfFile:@"generateImage.js"];
    COScript *coscript = [[COScript alloc] init];

    id document = MagicPresenterUtilGetDocument(self.context);

    if ( ! document) {
        return;
    }

    // Read from Cache and Compare Diff
    NSMutableDictionary *artboardCache = _cache[[artboard objectID]];
    if ( ! artboardCache) {
        artboardCache = [[NSMutableDictionary alloc] init];
        _cache[[artboard objectID]] = artboardCache;
    }
    id lastSnapshot = artboardCache[@"snapshot"] ?: [NSNull null];
    NSImage *lastImage = artboardCache[@(scale)];
    [coscript executeString:script];
    id isEqual = [coscript callFunctionNamed:@"isEqual" withArguments:@[lastSnapshot, MagicPresenterUtilGetImmutableModal(artboard)]];
    if (isEqual && ! [isEqual boolValue]) {
        [artboardCache removeAllObjects];     // Know that snapshot is different, throw away everything cached
    }
    if ([isEqual boolValue] && lastImage) {
        completion(lastImage);
        return;
    }
    artboardCache[@"snapshot"] = MagicPresenterUtilGetImmutableModal(artboard);


    // Generate Image
    NSArray *arguments = @[document, artboard, @(scale)];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        id result = [coscript callFunctionNamed:@"generateImage" withArguments:arguments];

        dispatch_async(dispatch_get_main_queue(), ^{
            artboardCache[@(scale)] = result;       // After Generate, set to cache
            completion(result);
        });
    });
}

@end
