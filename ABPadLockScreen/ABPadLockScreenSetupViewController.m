//
//  ABPadLockScreenSetupViewController.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPadLockScreenSetupViewController.h"
#import "ABPadLockScreenView.h"
#import "ABPinSelectionView.h"

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
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        _setupScreenDelegate = delegate;
        _enteredPin = nil;
    }
    return self;
}

#pragma mark -
#pragma mark - Init Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [lockScreenView updateDetailLabelWithString:@"Please Enter your pin" animated:NO completion:nil];
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
    [lockScreenView updateDetailLabelWithString:@"Please confirm your pin" animated:YES completion:nil];
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
        [lockScreenView updateDetailLabelWithString:@"Not a match. Please try again" animated:YES completion:nil];
        [lockScreenView resetAnimated:YES];
        self.enteredPin = nil;
        self.currentPin = @"";
    }
}

@end