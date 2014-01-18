//
//  ABPadLockScreenSetupViewController.h
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

/**
 This class should be presented to the user to perform the initial pin setup, usually when they open the app for the first time or
 when they wish to reset their pin.
 
 This class will not store the pin for you, you are responsible for taking the pin and saving it SECURELY to later be compared with values from ABPadLockScreenViewController
 */
#import "ABPadLockScreenAbstractViewController.h"

@class ABPadLockScreenSetupViewController;
@protocol ABPadLockScreenSetupViewControllerDelegate;

@interface ABPadLockScreenSetupViewController : ABPadLockScreenAbstractViewController

- (instancetype)initWithDelegate:(id<ABPadLockScreenSetupViewControllerDelegate>)delegate;

@property (nonatomic, weak, readonly) id<ABPadLockScreenSetupViewControllerDelegate> setupScreenDelegate;

@end

@protocol ABPadLockScreenSetupViewControllerDelegate <ABPadLockScreenDelegate>
@required
- (void)pinSet:(NSString *)pin padLockScreenSetupViewController:(ABPadLockScreenSetupViewController *)padLockScreenViewController;

@end