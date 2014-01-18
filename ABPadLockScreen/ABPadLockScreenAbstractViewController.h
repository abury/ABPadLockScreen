//
//  ABPadLockScreenAbstractViewController.h
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

/**
 Abstract Class that encapsulates common functionality between the lock and setup screen
 */

@protocol ABPadLockScreenDelegate;

@interface ABPadLockScreenAbstractViewController : UIViewController

@property (nonatomic, strong) NSString *currentPin;
@property (nonatomic, weak) id<ABPadLockScreenDelegate> delegate;

- (void)newPinSelected:(NSInteger)pinNumber;
- (void)deleteFromPin;

- (void)setLockScreenTitle:(NSString *)title;
- (void)cancelButtonDisabled:(BOOL)disabled;

@end

@protocol ABPadLockScreenDelegate <NSObject>
@required
- (void)unlockWasCancelledForPadLockScreenViewController:(ABPadLockScreenAbstractViewController *)padLockScreenViewController;

@end