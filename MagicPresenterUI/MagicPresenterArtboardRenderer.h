//
//  MagicPresenterArtboardRenderer.h
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MagicPresenterArtboardRendererCompletionHandler)(NSImage *image);

@interface MagicPresenterArtboardRenderer : NSObject

@property (nonatomic, strong) id context;

- (void)renderArtboard:(id)artboard
            completion:(MagicPresenterArtboardRendererCompletionHandler)completion;    // MSArtboardGroup

@end
