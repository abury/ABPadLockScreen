//
//  ABPadLockScreenViewController.h
//  ABPadLockScreen
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron's IT Consultancy. All rights reserved.
//

/**
 @author Aron Bury
 The ABPadLockScreenViewController presents a full screen pin to the user.
 Classess simply need to register as a delegate and implement the ABPadLockScreenViewControllerDelegate Protocol to recieve callbacks
 When a pin has been enteres successfully, unsuccessfully or when the entry has been cancelled.
 */

@protocol ABPadLockScreenViewControllerDelegate;

@interface ABPadLockScreenViewController : UIViewController

- (instancetype)initWithDelegate:(id<ABPadLockScreenViewControllerDelegate>)delegate pin:(NSString *)pin;

@property (nonatomic, strong, readonly) id<ABPadLockScreenViewControllerDelegate> delegate;
@property (nonatomic, strong, readonly) NSString *pin;
@property (nonatomic, assign, readonly) NSInteger totalAttempts;
@property (nonatomic, assign, readonly) NSInteger remainingAttempts;

- (void)setAllowedAttempts:(NSInteger)allowedAttempts;

@end

@protocol ABPadLockScreenViewControllerDelegate <NSObject>
@required
/**
 Called when the unlock was completed successfully
 @required
 */
- (void)unlockWasSuccessful;

/**
 Called when an unlock was unsuccessfully, providing the entry code and the attempt number
 @param falsePin The entry code that prompted the unssuccessful entry
 @param attemptNumber The attempt number
 @required
 */
- (void)unlockWasUnsuccessful:(NSString *)falsePin afterAttemptNumber:(NSInteger)attemptNumber;

/**
 Called when the user canclles the unlock
 @required
 */
- (void)unlockWasCancelled;

@optional

/**
 Called when the user has expired their attempts
 @optional
 */
- (void)attemptsExpired;

@end