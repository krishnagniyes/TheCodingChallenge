//
//  IGCustomAlertView
//
//  Created by intelliswift on 10/18/16.
//  Copyright © 2016 Krishna. All rights reserved.
//



// =================================================================================================
// Imports
// =================================================================================================


#import <Foundation/Foundation.h>
@import UIKit;


typedef void (^ActionBlock)();


@interface IGCustomAlertView : NSObject <UIAlertViewDelegate>

/*
 Sample to display Alert
 IGCustomAlertView *alert =
    [IGCustomAlertView alertWithTitle:title
    message:message];
 [alert addButtonWithTitle:buttonTitle action:nil];
 [alert show];
 */

/**
 * Displays alert.
 *
 * @param title Alert title.
 * @param message Alert message.
 * @returns returns alertView.
 */
+ (IGCustomAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message;



/**
 * Adds a regular button and uses a block to handle clicks.
 */
- (void)addButtonWithTitle:(NSString *)title action:(ActionBlock)actionBlock;


/**
 * Shows the alert view.
 */
- (void)show;


/**
 * shows custom alert
 *
 * @param title alert title.
 * @param message alert message.
 */
+ (void)showCustomAlert:(NSString *)title withMessage:(NSString *)message;


@end
