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

@end

@implementation MagicPresenterArtboardRenderer

- (NSString *)contentsOfFile:(NSString *)fileName {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:nil];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    return content;
}

- (void)renderArtboard:(id)artboard completion:(MagicPresenterArtboardRendererCompletionHandler)completion {

    NSString *script = [self contentsOfFile:@"generateImage.js"];
    COScript *coscript = [[COScript alloc] init];

    id document = MagicPresenterUtilGetDocument(self.context);

    if ( ! document) {
        return;
    }

    NSArray *arguments = @[document, artboard, @2];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [coscript executeString:script];
        id result = [coscript callFunctionNamed:@"generateImage" withArguments:arguments];

        dispatch_async(dispatch_get_main_queue(), ^{
            completion(result);
        });
    });
}

@end
