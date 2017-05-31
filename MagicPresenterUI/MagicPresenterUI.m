//
//  MagicPresenterUI.m
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicPresenterUI.h"
#import <CocoaScript/COScript.h>
#import "MagicPresenterUISketchPanelController.h"
@import JavaScriptCore;
#import <Mocha/Mocha.h>
#import <Mocha/MOClosure.h>
#import <Mocha/MOJavaScriptObject.h>
#import <Mocha/MochaRuntime_Private.h>


@interface MagicPresenterUI : NSObject

@property (nonatomic, strong) MagicPresenterUISketchPanelController *panelController;
@property (nonatomic, strong) id <MagicPresenterUIMSDocument> document;
@property (nonatomic, copy) NSString *panelControllerClassName;

+ (instancetype)onSelectionChanged:(id)context;
- (void)onSelectionChange:(NSArray *)selection;
+ (void)setSharedCommand:(id)command;

@end



@implementation MagicPresenterUI

static id _command;

+ (void)setSharedCommand:(id)command {
    _command = command;
}

+ (id)sharedCommand {
    return _command;
}

+ (instancetype)onSelectionChanged:(id)context {

//    COScript *coscript = [COScript currentCOScript];

    id <MagicPresenterUIMSDocument> document = [context valueForKeyPath:@"actionContext.document"];
    if ( ! [document isKindOfClass:NSClassFromString(@"MSDocument")]) {
        document = nil;  // be safe
        return nil;
    }

    if ( ! [self sharedCommand]) {
        [self setSharedCommand:[context valueForKeyPath:@"command"]]; // MSPluginCommand
    }

    NSString *key = [NSString stringWithFormat:@"%@-MagicPresenterUI", [document description]];
    __block MagicPresenterUI *instance = [[Mocha sharedRuntime] valueForKey:key];

    if ( ! instance) {
//        [coscript setShouldKeepAround:YES];
        instance = [[self alloc] initWithDocument:document];
        [[Mocha sharedRuntime] setValue:instance forKey:key];
    }

    NSArray *selection = [context valueForKeyPath:@"actionContext.document.selectedLayers"];
//    NSLog(@"selection %p %@ %@", instance, key, selection);
    [instance onSelectionChange:selection];
    return instance;
}

- (instancetype)initWithDocument:(id <MagicPresenterUIMSDocument>)document {
    if (self = [super init]) {
        _document = document;
        _panelController = [[MagicPresenterUISketchPanelController alloc] initWithDocument:_document];
    }
    return self;
}

- (void)onSelectionChange:(NSArray *)selection {
    [_panelController selectionDidChange:selection];
}

@end
