// ABPadLockScreenViewController.m
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

#import "ABPadLockScreenViewController.h"
#import "ABPadLockScreenView.h"
#import "ABPinSelectionView.h"

#define lockScreenView ((ABPadLockScreenView *) [self view])

@interface ABPadLockScreenViewController ()

- (BOOL)isPinValid:(NSString *)pin;

- (void)unlockScreen;
- (void)processFailure;
- (void)lockScreen;

@end

@implementation ABPadLockScreenViewController
#pragma mark -
#pragma mark - Init Methods
- (instancetype)initWithDelegate:(id<ABPadLockScreenViewControllerDelegate>)delegate pin:(NSString *)pin
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        _lockScreenDelegate = delegate;
        _pin = pin;
        _remainingAttempts = -1;
    }
    return self;
}

#pragma mark -
#pragma mark - Attempts
- (void)setAllowedAttempts:(NSInteger)allowedAttempts
{
    _totalAttempts = 0;
    _remainingAttempts = allowedAttempts;
}

#pragma mark -
#pragma mark - Pin Processing
- (void)processPin
{
    if ([self isPinValid:self.currentPin])
    {
        [self unlockScreen];
    }
    else
    {
        [self processFailure];
    }
}

- (void)unlockScreen
{
    if ([self.lockScreenDelegate respondsToSelector:@selector(unlockWasSuccessfulForPadLockScreenViewController:)])
    {
        [self.lockScreenDelegate unlockWasSuccessfulForPadLockScreenViewController:self];
    }
}

- (void)processFailure
{
    _remainingAttempts --;
    _totalAttempts ++;
    [lockScreenView resetAnimated:YES];
    
    if (self.remainingAttempts > 1) [lockScreenView updateDetailLabelWithString:[NSString stringWithFormat:@"%ld attempts left", (long)self.remainingAttempts] animated:YES completion:nil];
    else if (self.remainingAttempts == 1) [lockScreenView updateDetailLabelWithString:[NSString stringWithFormat:@"%ld attempt left", (long)self.remainingAttempts] animated:YES completion:nil];
    else if (self.remainingAttempts == 0) [self lockScreen];
    
    if ([self.lockScreenDelegate respondsToSelector:@selector(unlockWasUnsuccessful:afterAttemptNumber:padLockScreenViewController:)])
    {
        [self.lockScreenDelegate unlockWasUnsuccessful:self.currentPin afterAttemptNumber:self.totalAttempts padLockScreenViewController:self];
    }
    self.currentPin = @"";
}

- (BOOL)isPinValid:(NSString *)pin
{
    if ([_pin isEqualToString:pin]) return YES;
    return NO;
}

#pragma mark -
#pragma mark - Pin Selection
- (void)lockScreen
{
    [lockScreenView updateDetailLabelWithString:@"You have been locked out" animated:YES completion:nil];
    [lockScreenView lockViewAnimated:YES completion:nil];
    
    if ([self.lockScreenDelegate respondsToSelector:@selector(attemptsExpiredForPadLockScreenViewController:)])
    {
        [self.lockScreenDelegate attemptsExpiredForPadLockScreenViewController:self];
    }
}

#pragma mark -
#pragma mark - Button Selection
- (void)buttonSelected:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    [self newPinSelected:tag];
}

- (void)cancelButtonSelected:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(unlockWasCancelledForPadLockScreenViewController:)])
    {
        [self.delegate unlockWasCancelledForPadLockScreenViewController:self];
    }
}

- (void)deleteButtonSeleted:(UIButton *)sender
{
    [self deleteFromPin];
}

@end