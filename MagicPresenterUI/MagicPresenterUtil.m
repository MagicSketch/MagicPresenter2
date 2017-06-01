//
//  MagicPresenterUtil.m
//  MagicPresenter2
//
//  Created by James Tang on 1/6/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import "MagicPresenterUtil.h"

#import <Cocoa/Cocoa.h>

id MagicPresenterUtilRunPluginCommand(id context, NSString *actionID) {
    NSObject *appController = [[NSApplication sharedApplication] valueForKey:@"delegate"];

    NSURL *url = MagicPresenterUtilGetBundleURL(context);

    id result = nil;
    MagicPresenterSurpressLeakWarning(
                                      result = [appController performSelector:NSSelectorFromString(@"runPluginCommandWithIdentifier:fromBundleAtURL:") withObject:actionID withObject:url];
                                      );
    return result;
}


@implementation MagicPresenterUtil

@end
