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
#import <AudioToolbox/AudioToolbox.h>

#define lockScreenView ((ABPadLockScreenView *) [self view])

@interface ABPadLockScreenViewController ()

@property (nonatomic, strong) NSString *lockedOutString;
@property (nonatomic, strong) NSString *pluralAttemptsLeftString;
@property (nonatomic, strong) NSString *singleAttemptLeftString;

- (BOOL)isPinValid:(NSString *)pin;

- (void)unlockScreen;
- (void)processFailure;
- (void)lockScreen;

@end

@implementation ABPadLockScreenViewController
#pragma mark -
#pragma mark - Init Methods
- (instancetype)initWithDelegate:(id<ABPadLockScreenViewControllerDelegate>)delegate complexPin:(BOOL)complexPin
{
    self = [super initWithComplexPin:complexPin];
    if (self)
    {
        self.delegate = delegate;
        _lockScreenDelegate = delegate;
        _remainingAttempts = -1;
        
        _lockedOutString = NSLocalizedString(@"You have been locked out.", @"");
        _pluralAttemptsLeftString = NSLocalizedString(@"attempts left", @"");
        _singleAttemptLeftString = NSLocalizedString(@"attempt left", @"");
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
#pragma mark - Localisation Methods
- (void)setLockedOutText:(NSString *)title
{
    _lockedOutString = title;
}

- (void)setPluralAttemptsLeftText:(NSString *)title
{
    _pluralAttemptsLeftString = title;
}

- (void)setSingleAttemptLeftText:(NSString *)title
{
    _singleAttemptLeftString = title;
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
	[lockScreenView animateFailureNotification];
    
    if (self.remainingAttempts > 1)
    {
        [lockScreenView updateDetailLabelWithString:[NSString stringWithFormat:@"%ld %@", (long)self.remainingAttempts, self.pluralAttemptsLeftString]
                                           animated:YES completion:nil];
    }
    else if (self.remainingAttempts == 1)
    {
        [lockScreenView updateDetailLabelWithString:[NSString stringWithFormat:@"%ld %@", (long)self.remainingAttempts, self.singleAttemptLeftString]
                                           animated:YES completion:nil];
    }
    else if (self.remainingAttempts == 0)
    {
        [self lockScreen];
    }
    
    if ([self.lockScreenDelegate respondsToSelector:@selector(unlockWasUnsuccessful:afterAttemptNumber:padLockScreenViewController:)])
    {
        [self.lockScreenDelegate unlockWasUnsuccessful:self.currentPin afterAttemptNumber:self.totalAttempts padLockScreenViewController:self];
    }
    self.currentPin = @"";
    
    if (self.errorVibrateEnabled)
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

- (BOOL)isPinValid:(NSString *)pin
{
    if ([self.lockScreenDelegate respondsToSelector:@selector(padLockScreenViewController:validatePin:)])
    {
        return [self.lockScreenDelegate padLockScreenViewController:self validatePin:pin];
    }
    return NO;
}

#pragma mark -
#pragma mark - Pin Selection
- (void)lockScreen
{
    [lockScreenView updateDetailLabelWithString:[NSString stringWithFormat:@"%@", self.lockedOutString] animated:YES completion:nil];
    [lockScreenView lockViewAnimated:YES completion:nil];
    
    if ([self.lockScreenDelegate respondsToSelector:@selector(attemptsExpiredForPadLockScreenViewController:)])
    {
        [self.lockScreenDelegate attemptsExpiredForPadLockScreenViewController:self];
    }
}

@end