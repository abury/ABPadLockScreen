//
//  ABPadLockScreenController.h
//
//  Version 2.0
//
//  Created by Aron Bury on 09/09/2011.
//  Copyright 2011 Aron Bury. All rights reserved.
//
//  Get the latest version of ABLockScreen from this location:
//  https://github.com/abury/ABPadLockScreen
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import <UIKit/UIKit.h>

#define lockScreenWidth 320
#define lockScreenHeight 490

/**
 Methods that the Lock Screen will fire when it has completed an important action
 */
@protocol ABLockScreenDelegate <NSObject>
@required
/**
 Called when the unlock was completed successfully
 @required
 */
- (void)unlockWasSuccessful;

/**
 Called when an unlocke was unsuccessfully, providing the entry code and the attempt number
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

/**
 The ABLockScreenController responsible for providing a pin entry screen for the user. Depending on the device type the controller will render an iPhone or iPad based view
 It is designed to be implemented from within a UInavigtaionController. See the example code for more detail.
 */
@interface ABPadLockScreenController : UIViewController

/**
 The passcode required to unlock the pin screen
 */
@property (nonatomic, strong) NSString *pin;

/**
 The title text for the lock screen
 */
@property (nonatomic, strong) NSString *lockScreenTitle;

/**
 The subtitle text for the lock screen
 */
@property (nonatomic, strong) NSString *subtitle;

/**
 The attempt limit for the lock screen. A value of '0' indicates no limit.
 Defaults to 0
 */
@property (nonatomic, assign) NSInteger attemptLimit;

/**
 The callback object responsible for recieving calls from the LockScreenController
 */
@property (nonatomic, weak) id<ABLockScreenDelegate> delegate;


/**
 Convenience method to init with a set delegate
 */
- (id)initWithDelegate:(id<ABLockScreenDelegate>)delegate;

/**
 Resets the attempts for the controller. If there is no attempt limit this will do nothing
 */
- (void)resetAttempts;

/**
 Resets the lock screen to it's inital value (clears all digits inputted). Does not reset attempts
 */
- (void)resetLockScreen;


@end
