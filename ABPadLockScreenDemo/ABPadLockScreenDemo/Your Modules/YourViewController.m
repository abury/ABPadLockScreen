//
//  YourViewController.m
//  ABPadLockScreen
//
//  Created by Aron Bury on 10/11/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "YourViewController.h"
#import "ABPadLockScreenView.h"
#import "ABPadButton.h"
#import "ABPinSelectionView.h"
#import "UIColor+HexValue.h"

@interface YourViewController ()

@property (nonatomic, strong) NSString *pin;


- (void)lockScreenSelected:(id)sender;
- (void)setUpLockScreenSelected:(id)sender;
@end

@implementation YourViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Your Amazing App";
    
    [[ABPadLockScreenView appearance] setLabelColour:[UIColor whiteColor]];
    [[ABPadLockScreenView appearance] setBackgroundColor:[UIColor colorWithHexValue:@"4B67A1"]];
    
    [[ABPadButton appearance] setBackgroundColor:[UIColor clearColor]];
    [[ABPadButton appearance] setBorderColor:[UIColor colorWithHexValue:@"282B35"]];
    [[ABPadButton appearance] setSelectedColor:[UIColor colorWithHexValue:@"282B35"]];
    
    [[ABPinSelectionView appearance] setSelectedColor:[UIColor colorWithHexValue:@"282B35"]];
    
    UIButton *lockButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lockButton setTitle:@"Lock App" forState:UIControlStateNormal];
    [lockButton addTarget:self action:@selector(lockScreenSelected:) forControlEvents:UIControlEventTouchUpInside];
    lockButton.frame = CGRectMake(80, 80, 100, 40);
    
    UIButton *setupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [setupButton setTitle:@"Setup Pin" forState:UIControlStateNormal];
    [setupButton addTarget:self action:@selector(setUpLockScreenSelected:) forControlEvents:UIControlEventTouchUpInside];
    setupButton.frame = CGRectMake(80, 120, 100, 40);
    
    [self.view addSubview:lockButton];
    [self.view addSubview:setupButton];
}

- (void)lockScreenSelected:(id)sender
{
    if (!self.pin)
    {
        [[[UIAlertView alloc] initWithTitle:@"No Pin" message:@"Please Set a pin before trying to unlock" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    ABPadLockScreenViewController *lockScreen = [[ABPadLockScreenViewController alloc] initWithDelegate:self pin:self.pin];
    [lockScreen setAllowedAttempts:2];

    lockScreen.modalPresentationStyle = UIModalPresentationFullScreen;
    lockScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:lockScreen animated:YES completion:nil];
}

- (void)setUpLockScreenSelected:(id)sender
{
    ABPadLockScreenSetupViewController *lockScreen = [[ABPadLockScreenSetupViewController alloc] initWithDelegate:self];
    
    lockScreen.modalPresentationStyle = UIModalPresentationFullScreen;
    lockScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:lockScreen animated:YES completion:nil];
}

#pragma mark -
#pragma mark - ABLockScreenDelegate Methods
- (void)unlockWasSuccessfulForPadLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Pin entry successfull");
}

- (void)unlockWasUnsuccessful:(NSString *)falsePin afterAttemptNumber:(NSInteger)attemptNumber padLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController
{
    NSLog(@"Failed attempt number %ld with pin: %@", (long)attemptNumber, falsePin);
}

- (void)unlockWasCancelledForPadLockScreenViewController:(ABPadLockScreenAbstractViewController *)padLockScreenViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Pin entry cancelled");
}

#pragma mark -
#pragma mark - ABPadLockScreenSetupViewControllerDelegate Methods
- (void)pinSet:(NSString *)pin padLockScreenSetupViewController:(ABPadLockScreenSetupViewController *)padLockScreenViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.pin = pin;
    NSLog(@"Pin Set to pin");
}

@end