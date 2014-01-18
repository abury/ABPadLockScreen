//
//  YourViewController.m
//  ABPadLockScreen
//
//  Created by Aron Bury on 10/11/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "YourViewController.h"
#import "ABPadLockScreenViewController.h"
#import "ABPadLockScreenView.h"
#import "ABPadButton.h"

@interface YourViewController () <ABPadLockScreenViewControllerDelegate>

@property (nonatomic, strong) ABPadLockScreenViewController *pinScreen;

- (void)lockScreenSelected:(id)sender;
@end

@implementation YourViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *lockButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lockButton setTitle:@"Enter Pin" forState:UIControlStateNormal];
    [lockButton addTarget:self action:@selector(lockScreenSelected:) forControlEvents:UIControlEventTouchUpInside];
    lockButton.frame = CGRectMake(80, 80, 100, 40);
    
    [self.view addSubview:lockButton];
}

- (void)lockScreenSelected:(id)sender
{
    if (!self.pinScreen)
    {
        self.pinScreen = [[ABPadLockScreenViewController alloc] initWithDelegate:self pin:@"1234"];
    }
    
    [[ABPadLockScreenView appearance] setLabelColour:[UIColor whiteColor]];
    [[ABPadLockScreenView appearance] setBackgroundColor:[UIColor blackColor]];
    
    [[ABPadButton appearance] setBackgroundColor:[UIColor clearColor]];

    self.pinScreen.modalPresentationStyle = UIModalPresentationFullScreen;
    self.pinScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:self.pinScreen animated:YES completion:nil];
}

#pragma mark -
#pragma mark - ABLockScreenDelegate Methods
- (void)unlockWasSuccessfulForPadLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Pin entry successfull");
}

- (void)unlockWasCancelledForPadLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Pin entry cancelled");
}

- (void)unlockWasUnsuccessful:(NSString *)falsePin afterAttemptNumber:(NSInteger)attemptNumber padLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController
{
    NSLog(@"Failed attempt number %ld with pin: %@", (long)attemptNumber, falsePin);
}

@end