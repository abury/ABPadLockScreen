//
//  ABPadLockScreenSetupViewControllerSpec.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPadLockScreenSetupViewController.h"
#import "ExampleViewController.h"

@interface ABPadLockScreenSetupViewControllerSpec : XCTestCase

@end

@implementation ABPadLockScreenSetupViewControllerSpec

#pragma mark -
#pragma mark - Public Methods
- (void)testInit
{
    ExampleViewController *vc = [[ExampleViewController alloc] init];
    ABPadLockScreenSetupViewController *setupLockVC = [[ABPadLockScreenSetupViewController alloc] initWithDelegate:vc];
    XCTAssert([setupLockVC isKindOfClass:[ABPadLockScreenSetupViewController class]], @"Init Method didnt return the right class");
    XCTAssert(setupLockVC.delegate == vc, @"Init Method assign delegate correctly");
}

@end