//
//  ExampleViewController.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ExampleViewController.h"
#import "ABPadLockScreenView.h"
#import "ABPadButton.h"
#import "ABPinSelectionView.h"
#import "UIColor+HexValue.h"

@interface ExampleViewController ()

@property (nonatomic, strong) NSString *thePin;
- (IBAction)setPin:(id)sender;
- (IBAction)lockApp:(id)sender;

@end

@implementation ExampleViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Your Amazing App";
//    [[ABPadLockScreenView appearance] setLabelColour:[UIColor whiteColor]];
//    [[ABPadLockScreenView appearance] setBackgroundColor:[UIColor colorWithHexValue:@"4B67A1"]];
//    
//    [[ABPadButton appearance] setBackgroundColor:[UIColor clearColor]];
//    [[ABPadButton appearance] setBorderColor:[UIColor colorWithHexValue:@"282B35"]];
//    [[ABPadButton appearance] setSelectedColor:[UIColor colorWithHexValue:@"282B35"]];
//    
//    [[ABPinSelectionView appearance] setSelectedColor:[UIColor colorWithHexValue:@"282B35"]];
}

#pragma mark -
#pragma mark - Button Methods
- (IBAction)setPin:(id)sender
{
    ABPadLockScreenSetupViewController *lockScreen = [[ABPadLockScreenSetupViewController alloc] initWithDelegate:self];
    lockScreen.modalPresentationStyle = UIModalPresentationFullScreen;
    lockScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:lockScreen animated:YES completion:nil];
}

- (IBAction)lockApp:(id)sender
{
    if (!self.thePin)
    {
        [[[UIAlertView alloc] initWithTitle:@"No Pin" message:@"Please Set a pin before trying to unlock" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    ABPadLockScreenViewController *lockScreen = [[ABPadLockScreenViewController alloc] initWithDelegate:self pin:self.thePin];
    [lockScreen setAllowedAttempts:2];
    
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
    self.thePin = pin;
    NSLog(@"Pin Set to pin");
}
@end
