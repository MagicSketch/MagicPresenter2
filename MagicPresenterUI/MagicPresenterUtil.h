//
//  MagicPresenterUtil.h
//  MagicPresenter2
//
//  Created by James Tang on 1/6/2017.
//  Copyright © 2017 MagicSketch. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MagicPresenterSurpressLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define MagicPresenterUtilGetBundleURL(context) [context valueForKeyPath:@"command.pluginBundle.url"]
#define MagicPresenterUtilGetDocument(context)  ([context valueForKeyPath:@"actionContext.document"] ?: [context valueForKeyPath:@"document"])
#define MagicPresenterUtilGetSelection(context) [MagicPresenterUtilGetDocument(context) valueForKeyPath:@"selectedLayers.layers"]
#define MagicPresenterUtilGetStackView(context) [MagicPresenterUtilGetDocument(context) valueForKeyPath:@"inspectorController.currentController.stackView"];
extern id MagicPresenterUtilRunPluginCommand(id context, NSString *actionID);

@interface MagicPresenterUtil : NSObject

@end
