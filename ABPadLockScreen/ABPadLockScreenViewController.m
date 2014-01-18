//
//  ABPadLockScreenViewController.m
//  ABPadLockScreen
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron's IT Consultancy. All rights reserved.
//

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