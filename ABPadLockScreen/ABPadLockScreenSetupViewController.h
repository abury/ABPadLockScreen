// ABPadLockScreenSetupViewController.h
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

/**
 This class should be presented to the user to perform the initial pin setup, usually when they open the app for the first time or
 when they wish to reset their pin.
 
 This class will not store the pin for you, you are responsible for taking the pin and saving it SECURELY to later be compared with values from ABPadLockScreenViewController
 */
#import "ABPadLockScreenAbstractViewController.h"

@class ABPadLockScreenSetupViewController;
@protocol ABPadLockScreenSetupViewControllerDelegate;

@interface ABPadLockScreenSetupViewController : ABPadLockScreenAbstractViewController

@property (nonatomic, weak, readonly) id<ABPadLockScreenSetupViewControllerDelegate> setupScreenDelegate;
@property (nonatomic, strong, readonly) NSString *subtitleLabelText;
@property (nonatomic, strong) NSString *pinNotMatchedText;
@property (nonatomic, strong) NSString *pinConfirmationText;

- (instancetype)initWithDelegate:(id<ABPadLockScreenSetupViewControllerDelegate>)delegate;
- (instancetype)initWithDelegate:(id<ABPadLockScreenSetupViewControllerDelegate>)delegate complexPin:(BOOL)complexPin;
- (instancetype)initWithDelegate:(id<ABPadLockScreenSetupViewControllerDelegate>)delegate complexPin:(BOOL)complexPin subtitleLabelText:(NSString *)subtitleLabelText;

@end

@protocol ABPadLockScreenSetupViewControllerDelegate <ABPadLockScreenDelegate>
@required
- (void)pinSet:(NSString *)pin padLockScreenSetupViewController:(ABPadLockScreenSetupViewController *)padLockScreenViewController;

@end