//
//  ABPadLockScreenAbstractViewController.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPadLockScreenAbstractViewController.h"
#import "ABPadLockScreenView.h"
#import "ABPinSelectionView.h"

#define lockScreenView ((ABPadLockScreenView *) [self view])

@interface ABPadLockScreenAbstractViewController ()

- (void)setUpButtonMapping;
- (void)buttonSelected:(UIButton *)sender;
- (void)cancelButtonSelected:(UIButton *)sender;
- (void)deleteButtonSeleted:(UIButton *)sender;

@end

@implementation ABPadLockScreenAbstractViewController

#pragma mark -
#pragma mark - View Controller Lifecycele Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[ABPadLockScreenView alloc] initWithFrame:self.view.frame];
    [self setUpButtonMapping];
    [lockScreenView.cancelButton addTarget:self action:@selector(cancelButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [lockScreenView.deleteButton addTarget:self action:@selector(deleteButtonSeleted:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSUInteger)supportedInterfaceOrientations
{
    UIUserInterfaceIdiom interfaceIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (interfaceIdiom == UIUserInterfaceIdiomPad) return UIInterfaceOrientationMaskAll;
    if (interfaceIdiom == UIUserInterfaceIdiomPhone) return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    
    return UIInterfaceOrientationMaskAll;
}

#pragma mark -
#pragma mark - Helper Methods
- (void)setUpButtonMapping
{
    for (UIButton *button in [lockScreenView buttonArray])
    {
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setLockScreenTitle:(NSString *)title
{
    self.title = title;
    lockScreenView.enterPasscodeLabel.text = title;
}

- (void)cancelButtonDisabled:(BOOL)disabled
{
    lockScreenView.cancelButtonDisabled = disabled;
}

#pragma mark -
#pragma mark - Button Methods
- (void)newPinSelected:(NSInteger)pinNumber
{
    if ([self.currentPin length] >= 4)
    {
        return;
    }
    
    self.currentPin = [NSString stringWithFormat:@"%@%ld", self.currentPin, (long)pinNumber];
    
    if ([self.currentPin length] == 1)
    {
        [lockScreenView.pinOneSelectionView setSelected:YES animated:YES completion:nil];
        [lockScreenView showDeleteButtonAnimated:YES completion:nil];
    }
    else if ([self.currentPin length] == 2)
    {
        [lockScreenView.pinTwoSelectionView setSelected:YES animated:YES completion:nil];
    }
    else if ([self.currentPin length] == 3)
    {
        [lockScreenView.pinThreeSelectionView setSelected:YES animated:YES completion:nil];
    }
    else if ([self.currentPin length] == 4)
    {
        [lockScreenView.pinFourSelectionView setSelected:YES animated:YES completion:nil];
    }
}

- (void)deleteFromPin
{
    if ([self.currentPin length] == 0)
    {
        return;
    }
    
    self.currentPin = [self.currentPin substringWithRange:NSMakeRange(0, [self.currentPin length] - 1)];
    
    if ([self.currentPin length] == 2)
    {
        [lockScreenView.pinThreeSelectionView setSelected:NO animated:YES completion:nil];
    }
    else if ([self.currentPin length] == 1)
    {
        [lockScreenView.pinTwoSelectionView setSelected:NO animated:YES completion:nil];
    }
    else if ([self.currentPin length] == 0)
    {
        [lockScreenView.pinOneSelectionView setSelected:NO animated:YES completion:nil];
        [lockScreenView showCancelButtonAnimated:YES completion:nil];
    }
}

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