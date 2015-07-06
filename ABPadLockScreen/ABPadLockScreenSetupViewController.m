// ABPadLockScreenSetupViewController.m
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

#import "ABPadLockScreenSetupViewController.h"
#import "ABPadLockScreenView.h"
#import "ABPinSelectionView.h"
#import <AudioToolbox/AudioToolbox.h>

#define lockScreenView ((ABPadLockScreenView *) [self view])

@interface ABPadLockScreenSetupViewController ()

@property (nonatomic, strong) NSString *enteredPin;

- (void)startPinConfirmation;
- (void)validateConfirmedPin;

@end

@implementation ABPadLockScreenSetupViewController

#pragma mark -
#pragma mark - Init Methods
- (instancetype)initWithDelegate:(id<ABPadLockScreenSetupViewControllerDelegate>)delegate
{
    self = [self initWithDelegate:delegate complexPin:NO];
    return self;
}

- (instancetype)initWithDelegate:(id<ABPadLockScreenSetupViewControllerDelegate>)delegate complexPin:(BOOL)complexPin
{
    self = [super initWithComplexPin:complexPin];
    if (self)
    {
        self.delegate = delegate;
        _setupScreenDelegate = delegate;
        _enteredPin = nil;
        [self setDefaultTexts];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<ABPadLockScreenSetupViewControllerDelegate>)delegate complexPin:(BOOL)complexPin subtitleLabelText:(NSString *)subtitleLabelText
{
    self = [self initWithDelegate:delegate complexPin:complexPin];
    if (self)
    {
        _subtitleLabelText = subtitleLabelText;
        dispatch_async(dispatch_get_main_queue(), ^{
            [lockScreenView updateDetailLabelWithString:_subtitleLabelText animated:NO completion:nil];
        });
    }
    return self;
}

- (void)setDefaultTexts
{
    _pinNotMatchedText = NSLocalizedString(@"Pincode did not match.", @"");
    _pinConfirmationText = NSLocalizedString(@"Re-enter your new pincode", @"");
}

#pragma mark -
#pragma mark - View Controller Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -
#pragma mark - Pin Processing
- (void)processPin
{
    if (!self.enteredPin)
    {
        [self startPinConfirmation];
    }
    else
    {
        [self validateConfirmedPin];
    }
}

- (void)startPinConfirmation
{
    self.enteredPin = self.currentPin;
    self.currentPin = @"";
    [lockScreenView updateDetailLabelWithString:self.pinConfirmationText animated:YES completion:nil];
    [lockScreenView resetAnimated:YES];
}
         
- (void)validateConfirmedPin
{
    if ([self.currentPin isEqualToString:self.enteredPin])
    {
        if ([self.setupScreenDelegate respondsToSelector:@selector(pinSet:padLockScreenSetupViewController:)])
        {
            [self.setupScreenDelegate pinSet:self.currentPin padLockScreenSetupViewController:self];
        }
    }
    else
    {
        [lockScreenView updateDetailLabelWithString:self.pinNotMatchedText animated:YES completion:nil];
		[lockScreenView animateFailureNotification];
        [lockScreenView resetAnimated:YES];
        self.enteredPin = nil;
        self.currentPin = @"";
        
        // viberate feedback
        if (self.errorVibrateEnabled)
        {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }
}

@end