//
//  IGCustomAlertView
//
//  Created by intelliswift on 10/18/16.
//  Copyright © 2016 Krishna. All rights reserved.
//


// =================================================================================================
// Imports
// =================================================================================================


#import "IGCustomAlertView.h"


static NSString * const buttonTitleKey = @"ButtonTitle";
static NSString * const buttonActionKey = @"ButtonAction";
static NSString * const buttonIndexKey = @"ButtonIndex";
static NSString * const buttonStyleKey = @"ButtonStyle";


@interface IGCustomAlertView()


@property (nonatomic, copy  , readwrite) NSString *title;
@property (nonatomic, copy  , readwrite) NSString *message;
@property (nonatomic, strong, readwrite) NSMutableOrderedSet *buttonSet;
@property (nonatomic, strong) NSMutableDictionary *cancelButtonDictionary;
@property (nonatomic, strong) NSMutableDictionary *actionLookupTable;


@end


@implementation IGCustomAlertView


#pragma mark Initialization

+ (IGCustomAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message {
    return [[IGCustomAlertView alloc] initWithTitle:title
                                            message:message];
}


- (id)init {
    if ((self = [super init])) {
        _actionLookupTable = [NSMutableDictionary dictionary];
        _buttonSet = [[NSMutableOrderedSet alloc] init];
    }
    return self;
}



- (id)initWithTitle:(NSString *)title
            message:(NSString *)message {
        self.title = title;
        self.message = message;
    _actionLookupTable = [NSMutableDictionary dictionary];
    _buttonSet = [[NSMutableOrderedSet alloc] init];
    return self;
}


- (void)addButtonWithTitle:(NSString *)title action:(ActionBlock)actionBlock {
    NSMutableDictionary *buttonInfo = [self buttonDictionaryWithTitle:title
                                                                style:UIAlertActionStyleDefault
                                                               action:actionBlock];
    [self.buttonSet addObject:buttonInfo];
    
}


- (NSMutableDictionary *)buttonDictionaryWithTitle:(NSString *)title
                                             style:(UIAlertActionStyle)style
                                            action:(ActionBlock)actionBlock {
    NSMutableDictionary *buttonInfo = [[NSMutableDictionary alloc] init];
    [buttonInfo setObject:title forKey:buttonTitleKey];
    [buttonInfo setObject:[NSNumber numberWithInteger:style] forKey:buttonStyleKey];
    
    if (actionBlock) {
        ActionBlock actionCopy = [actionBlock copy];
        [buttonInfo setObject:actionCopy forKey:buttonActionKey];
    }
    
    return buttonInfo;
}


- (void)show {
        UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:self.title
                                                message:self.message
                                         preferredStyle:UIAlertControllerStyleAlert];
    
        for (NSMutableDictionary *buttonInfo in self.buttonSet) {
            UIAlertAction *buttonAction =
                [UIAlertAction actionWithTitle:buttonInfo[buttonTitleKey]
                                         style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action) {
                                           if (buttonInfo[buttonActionKey]) {
                                               dispatch_async(dispatch_get_main_queue(), buttonInfo[buttonActionKey]);
                                           }
                                       }];
                
            [alert addAction:buttonAction];
        }
        
        if (self.cancelButtonDictionary) {
            UIAlertAction *buttonAction =
            [UIAlertAction actionWithTitle:self.cancelButtonDictionary[buttonTitleKey]
                                     style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action) {
                                       if (self.cancelButtonDictionary[buttonActionKey]) {
                                           dispatch_async(dispatch_get_main_queue(), self.cancelButtonDictionary[buttonActionKey]);
                                       }
                                   }];
            
            [alert addAction:buttonAction];
        }
    
        [[[[UIApplication sharedApplication] keyWindow]rootViewController] presentViewController:alert
                                                                                     animated:YES
                                                                                   completion:NULL];
}


+ (void)showCustomAlert:(NSString *)title withMessage:(NSString *)message {
    UIButton *nameField =
        [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0, 50, 50.0)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [nameField setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [view addSubview:nameField];
    IGCustomAlertView *alert = [IGCustomAlertView alertWithTitle:title message:message];
    [alert setValue:view  forKey:@"accessoryView"];
    [alert show];
}

@end
