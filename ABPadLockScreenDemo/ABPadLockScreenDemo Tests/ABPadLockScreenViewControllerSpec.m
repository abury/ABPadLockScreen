//
//  ABPadLockScreenViewControllerSpec.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPadLockScreenViewController+Private.h"
#import "ExampleViewController.h"

#define pinValue @"1111"
#define attempts 3

@interface ABPadLockScreenViewControllerSpec : XCTestCase

@end

@implementation ABPadLockScreenViewControllerSpec

#pragma mark -
#pragma mark - Public Methods
- (void)testInit
{
    ExampleViewController *yourViewController = [[ExampleViewController alloc] init];
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:yourViewController complexPin:NO];
    XCTAssert([padLockScreenVC isKindOfClass:[padLockScreenVC class]], @"Pad Lock Screen VC is not correct type");
    XCTAssert(padLockScreenVC.delegate == yourViewController, @"Pad Lock Screen delegate is not correct type");
    XCTAssert(padLockScreenVC.totalAttempts == 0, @"Total attempts do not start at 0");
    XCTAssert([padLockScreenVC.currentPin isEqualToString:@""], @"Current pin starts off as null");
}

- (void)testSettingAllowedAttempts
{
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:nil complexPin:NO];
    [padLockScreenVC setAllowedAttempts:attempts];
    XCTAssert(padLockScreenVC.totalAttempts == 0, @"Allowed attempts not set properly");
    XCTAssert(padLockScreenVC.remainingAttempts == attempts, @"Remaining attempts not set properly");
}

#pragma mark -
#pragma mark - Private Methods
- (void)testThatAllowedAttemptsDecrease
{
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:nil complexPin:NO];
    [padLockScreenVC setAllowedAttempts:attempts];
    [padLockScreenVC processPin];
    XCTAssert(padLockScreenVC.remainingAttempts == attempts - 1, @"Pad lock screen remaining attempts did not decrease");
}

- (void)testPinSelection
{
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:nil complexPin:NO];
    [padLockScreenVC newPinSelected:1];
    XCTAssert([padLockScreenVC.currentPin isEqualToString:@"1"], @"First pin entry failed");
    [padLockScreenVC newPinSelected:2];
    [padLockScreenVC newPinSelected:3];
    XCTAssert([padLockScreenVC.currentPin isEqualToString:@"123"], @"Pin Entry failed");
    [padLockScreenVC newPinSelected:4];
    [padLockScreenVC newPinSelected:4];
    XCTAssert([padLockScreenVC.currentPin length] != 5, @"Pin was able to get past a length of 4");
}

- (void)testPinDeletion
{
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:nil complexPin:NO];
    padLockScreenVC.currentPin = @"123";
    [padLockScreenVC deleteFromPin];
    XCTAssert([padLockScreenVC.currentPin isEqualToString:@"12"], @"Pin value wasnt deleted");
    [padLockScreenVC deleteFromPin];
    [padLockScreenVC deleteFromPin];
    XCTAssert([padLockScreenVC.currentPin isEqualToString:@""], @"Last pin values wernt deleted");
}

- (void)testPinProcessing
{
    ABPadLockScreenViewController *padLockScreenVC = [[ABPadLockScreenViewController alloc] initWithDelegate:nil complexPin:NO];
    padLockScreenVC.currentPin = @"1222";
    [padLockScreenVC processPin];
    XCTAssert([padLockScreenVC.currentPin isEqualToString:@""], @"Current Pin doesnt reset after processing");
}
@end