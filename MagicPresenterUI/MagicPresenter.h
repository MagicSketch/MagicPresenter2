//
//  MagicPresenter.h
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagicPresenter : NSObject

//- (void)playSlides:(NSArray *)slides atIndex:(NSUInteger)index;

- (instancetype)initWithContext:(id)context;
- (void)play:(id)context;
+ (NSURL *)bundleURL;

@end
