//
//  ABPadLockScreenViewControllerSpec.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPadLockScreenViewController+Private.h"
#import "YourViewController.h"

#define pinValue @"1111"
#define attempts 3

@interface ABPadLockScreenViewControllerSpec : XCTestCase

@end

@implementation ABPadLockScreenViewControllerSpec

#pragma mark -
#pragma mark - Public Methods
- (void)testInit
{
    YourViewController *yourViewController = [[YourViewController alloc] init];
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:yourViewController pin:pinValue];
    XCTAssert([padLockScreenVC isKindOfClass:[padLockScreenVC class]], @"Pad Lock Screen VC is not correct type");
    XCTAssert(padLockScreenVC.delegate == yourViewController, @"Pad Lock Screen delegate is not correct type");
    XCTAssert([padLockScreenVC.pin isEqualToString:pinValue], @"Pad Lock screen pin isnt set correctly");
    XCTAssert(padLockScreenVC.totalAttempts == 0, @"Total attempts do not start at 0");
}

- (void)testSettingAllowedAttempts
{
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:nil pin:pinValue];
    [padLockScreenVC setAllowedAttempts:attempts];
    XCTAssert(padLockScreenVC.totalAttempts == attempts, @"Allowed attempts not set properly");
    XCTAssert(padLockScreenVC.remainingAttempts == attempts, @"Remaining attempts not set properly");
}

#pragma mark -
#pragma mark - Private Methods
- (void)testThatAllowedAttemptsDecrease
{
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:nil pin:pinValue];
    [padLockScreenVC setAllowedAttempts:attempts];
    [padLockScreenVC isPinValid:@"1234"];
    XCTAssert(padLockScreenVC.remainingAttempts == attempts - 1, @"Pad lock screen remaining attempts did not decrease");
}

- (void)testThatPinCanValidate
{
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:nil pin:pinValue];
    BOOL isPinValid = [padLockScreenVC isPinValid:pinValue];
    XCTAssertTrue(isPinValid, @"Pin does not correctly report YES");
    isPinValid = [padLockScreenVC isPinValid:@"1234"];
    XCTAssertFalse(isPinValid, @"Pin does not correctly report NO");
}

@end