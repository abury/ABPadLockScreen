// ABPadLockScreenViewController.h
//
// Copyright (c) 2014 Aron Bury - http://www.aronbury.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ABPadLockScreenAbstractViewController.h"

/**
 The ABPadLockScreenViewController presents a full screen pin to the user.
 Classess simply need to register as a delegate and implement the ABPadLockScreenViewControllerDelegate Protocol to recieve callbacks
 When a pin has been enteres successfully, unsuccessfully or when the entry has been cancelled.
 
 You are responsible for storing the pin securely (use the keychain or some other form of secure storage, DO NOT STORE IN PLAINTEXT. If you need the user to set a pin, please use ABPadLockScreenSetupViewController
 */
@class ABPadLockScreenViewController;
@protocol ABPadLockScreenViewControllerDelegate;

@interface ABPadLockScreenViewController : ABPadLockScreenAbstractViewController

- (instancetype)initWithDelegate:(id<ABPadLockScreenViewControllerDelegate>)delegate complexPin:(BOOL)complexPin;

@property (nonatomic, weak, readonly) id<ABPadLockScreenViewControllerDelegate> lockScreenDelegate;
@property (nonatomic, assign, readonly) NSInteger totalAttempts;
@property (nonatomic, assign, readonly) NSInteger remainingAttempts;

- (void)setAllowedAttempts:(NSInteger)allowedAttempts;

- (void)setLockedOutText:(NSString *)title;
- (void)setPluralAttemptsLeftText:(NSString *)title;
- (void)setSingleAttemptLeftText:(NSString *)title;

@end

@protocol ABPadLockScreenViewControllerDelegate <ABPadLockScreenDelegate>
@required

/**
 Called when pin validation is needed
 */
- (BOOL)padLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController validatePin:(NSString*)pin;

/**
 Called when the unlock was completed successfully
 */
- (void)unlockWasSuccessfulForPadLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController;

/**
 Called when an unlock was unsuccessfully, providing the entry code and the attempt number
 */
- (void)unlockWasUnsuccessful:(NSString *)falsePin afterAttemptNumber:(NSInteger)attemptNumber padLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController;

/**
 Called when the user cancels the unlock
 */
- (void)unlockWasCancelledForPadLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController;

@optional
/**
 Called when the user has expired their attempts
 */
- (void)attemptsExpiredForPadLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController;

@end