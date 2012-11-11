//
//  YourViewController.m
//  ABPadLockScreen
//
//  Created by Aron Bury on 10/11/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "YourViewController.h"
#import "ABPadLockScreenController.h"

@interface YourViewController () <ABlockScreenDelegate>

@property (nonatomic, strong) ABPadLockScreenController *pinScreen;

- (void)lockScreenSelected:(id)sender;
@end

@implementation YourViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *lockButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lockButton setTitle:@"Enter Pin" forState:UIControlStateNormal];
    [lockButton addTarget:self action:@selector(lockScreenSelected:) forControlEvents:UIControlEventTouchUpInside];
    lockButton.frame = CGRectMake(20, 20, 100, 40);
    
    [self.view addSubview:lockButton];
}

- (void)lockScreenSelected:(id)sender
{
    if (!self.pinScreen)
    {
        self.pinScreen = [[ABPadLockScreenController alloc] initWithDelegate:self];
        self.pinScreen.pin = 1234;
        self.pinScreen.attemptLimit = 3;
        self.pinScreen.title = @"Enter Pin";
        self.pinScreen.subtitle = @"Please enter your PIN";
    }

    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:self.pinScreen];
    [self presentModalViewController:navCon animated:YES];
}

#pragma mark -
#pragma mark - ABParentScreenDelegate
- (void)unlockWasSuccessful
{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"Pin entry successfull");
}

- (void)unlockWasCancelled
{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"Pin entry cancelled");
}

- (void)unlockWasUnsuccessful:(NSInteger)falseEntryCode afterAttemptNumber:(NSInteger)attemptNumber
{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"Failed attempt number %d with pin: %d", falseEntryCode, attemptNumber);
}

@end
