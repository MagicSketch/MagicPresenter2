//
//  MagicPresenterWindowController.h
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MagicPresenterWindowController : NSWindowController

@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSProgressIndicator *loadingIndicator;
@property (weak) IBOutlet NSButton *leftButton;
@property (weak) IBOutlet NSButton *rightButton;
@property (nonatomic, copy) NSArray *artboards;
@property (nonatomic, strong) id context;
@property (nonatomic) NSInteger index;

@end
