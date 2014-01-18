//
//  ABPadLockScreenViewController.m
//  ABPadLockScreen
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron's IT Consultancy. All rights reserved.
//

#import "ABPadLockScreenViewController.h"
#import "ABPadLockScreenView.h"

#define lockScreenView ((ABPadLockScreenView *) [self view])

@interface ABPadLockScreenViewController ()

- (BOOL)isPinValid:(NSString *)pin;
- (void)buttonSelected:(UIButton *)sender;

@end

@implementation ABPadLockScreenViewController
#pragma mark -
#pragma mark - Init Methods
- (instancetype)initWithDelegate:(id<ABPadLockScreenViewControllerDelegate>)delegate pin:(NSString *)pin
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        _pin = pin;
    }
    return self;
}

#pragma mark -
#pragma mark - View Controller Lifecycele Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[ABPadLockScreenView alloc] initWithFrame:self.view.frame];
    [lockScreenView.buttonOne addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSUInteger)supportedInterfaceOrientations
{
    UIUserInterfaceIdiom interfaceIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (interfaceIdiom == UIUserInterfaceIdiomPad) return UIInterfaceOrientationMaskAll;
    if (interfaceIdiom == UIUserInterfaceIdiomPhone) return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    
    return UIInterfaceOrientationMaskAll;
}

#pragma mark -
#pragma mark - Attempts
- (void)setAllowedAttempts:(NSInteger)allowedAttempts
{
    _totalAttempts = allowedAttempts;
    _remainingAttempts = allowedAttempts;
}

#pragma mark -
#pragma mark - Pin Validation
- (BOOL)isPinValid:(NSString *)pin
{
    if ([_pin isEqualToString:pin]) return YES;
    
    _remainingAttempts --;
    return NO;
}

#pragma mark -
#pragma mark - Pin Selection
- (void)buttonSelected:(UIButton *)sender
{

}

@end