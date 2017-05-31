//
//  MagicPresenterUIMSInspectorStackView.h
//  MagicPresenter2
//
//  Created by James Tang on 31/5/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#ifndef MagicPresenterUIMSInspectorStackView_h
#define MagicPresenterUIMSInspectorStackView_h

@protocol MagicPresenterUIMSInspectorStackView <NSObject>

@property (nonatomic, strong) NSArray *sectionViewControllers;
- (void)reloadWithViewControllers:(NSArray *)controllers;

@end

#endif /* MagicPresenterUIMSInspectorStackView_h */
