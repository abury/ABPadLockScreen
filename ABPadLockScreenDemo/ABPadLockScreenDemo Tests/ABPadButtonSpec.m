//
//  ABPadButtonSpec.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPadButton.h"
#import <UIKit/UIKit.h>

@interface ABPadButtonSpec : XCTestCase

@end

@implementation ABPadButtonSpec

- (void)testInit
{
    ABPadButton *button = [[ABPadButton alloc] initWithFrame:CGRectZero number:2 letters:@"ABC"];
    XCTAssert([button.numberLabel.text isEqualToString:@"2"], @"Button number label does not have it's text displayed properly");
    XCTAssert([button.lettersLabel.text isEqualToString:@"ABC"], @"Button letters label does not have it's text displayed properly");
    XCTAssert([button.accessibilityValue isEqualToString:@"PinButton2"], @"Butons accessability value is not set correctly");
}
@end
