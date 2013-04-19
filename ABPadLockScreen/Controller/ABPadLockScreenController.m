//
//  ABPadLockScreenController.m
//
//  Version 2.0
//
//  Created by Aron Bury on 09/09/2011.
//  Copyright 2011 Aron Bury. All rights reserved.
//
//  Get the latest version of ABLockScreen from this location:
//  https://github.com/abury/ABPadLockScreen
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//
#import "ABPadLockScreenController.h"
#import "ABPadLockScreenView_iPad.h"
#import "ABPadLockScreenView_iPhone.h"

#define ipadView ((ABPadLockScreenView_iPad *)[self view])
#define iPhoneView ((ABPadLockScreenView_iPhone *)[self view])

#define kNoAttemptLimit -1


typedef enum {
    ABLockPadDeviceTypeiPhone = 0,
    ABLockPadDeviceTypeiPad = 1
    
}ABLockPadDeviceType;

@interface ABPadLockScreenController() <UITextFieldDelegate>

/**
 Helper property to determine the device type the controller is currently running on
 */
@property (nonatomic, assign, readonly) ABLockPadDeviceType deviceType;

/**
 The current pin value
 */
@property (nonatomic, strong) NSString *currentPin;

/**
 How many unlock attempts the user has performed
 */
@property (nonatomic, assign) NSInteger attempts;

/**
 Called when the user selects the cancel button
 */
- (void)cancelButtonSelected:(id)sender;

/**
 Called when a user selects a 'digit' button (iPad only, iPhone uses a numberpad keyboard)
 */
- (void)digitButtonselected:(id)sender;

/**
 Called when a user preses the back button to delete a character
 */
- (void)backButtonSelected:(id)sender;

/**
 Called when the user has entered 4 digits the controller checks to see if the pin matches
 */
- (void)checkPin;

/**
 Locks the pad from further use after the user has expired their allowed attempts
 */
- (void)lockPad;

/**
 Performs the relevant actions when a user fails a PIN entry attempt that is not their last
 @param remainingAttempts The reamining attempts to display to the user
 */
- (void)failedAttemptWithRemaningAttempts:(NSInteger)remainingAttempts;

/**
 Performs the relevant actions when a user fails their final PIN entry attempt
 */
- (void)failedFinalAttempt;

@end

@implementation ABPadLockScreenController

#pragma mark -
#pragma mark - init Methods
- (id)initWithDelegate:(id<ABLockScreenDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        _currentPin = @"";
        _attemptLimit = 0;
    }
    
    return self;
}


#pragma mark -
#pragma mark - View Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.deviceType == ABLockPadDeviceTypeiPhone)
        self.view = [[ABPadLockScreenView_iPhone alloc] initWithFrame:self.view.frame];
    
    if (self.deviceType == ABLockPadDeviceTypeiPad)
        self.view = [[ABPadLockScreenView_iPad alloc] initWithFrame:self.view.frame];
    
    UIBarButtonItem *cancelBarButtonitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonSelected:)];
    [[self navigationItem] setRightBarButtonItem:cancelBarButtonitem animated:NO];
    
    if (self.deviceType == ABLockPadDeviceTypeiPhone)
    {
        iPhoneView.hiddenTextField.delegate = self;
        iPhoneView.subtitleLabel.text = self.subtitle;
    }
    else if (self.deviceType == ABLockPadDeviceTypeiPad)
    {
        ipadView.subtitleLabel.text = self.subtitle;
        
        [ipadView.one addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.two addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.three addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.four addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.five addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.six addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.seven addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.eight addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.nine addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.zero addTarget:self action:@selector(digitButtonselected:) forControlEvents:UIControlEventTouchUpInside];
        [ipadView.back addTarget:self action:@selector(backButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.deviceType == ABLockPadDeviceTypeiPhone)
        [iPhoneView.hiddenTextField becomeFirstResponder];
}

#pragma mark -
#pragma mark - Public Methods
- (void)resetAttempts
{
    self.attempts = 0;
    
    if (self.deviceType == ABLockPadDeviceTypeiPhone)
    {
        iPhoneView.remainingAttemptsLabel.text = @"";
        iPhoneView.errorbackView.alpha = 0.0f;
        iPhoneView.subtitleLabel.text = self.subtitle;
    }
    else if (self.deviceType == ABLockPadDeviceTypeiPad)
    {
        ipadView.remainingAttemptsLabel.text = @"";
        ipadView.errorbackView.alpha = 0.0f;
        ipadView.subtitleLabel.text = self.subtitle;
    }
}

- (void)resetLockScreen
{
    self.currentPin = @"";
    
    UIView *relevantVeiw = iPhoneView;
    NSInteger startingPoint = 1;
    NSInteger endingPoint = 5;
    
    if (self.deviceType == ABLockPadDeviceTypeiPad)
    {
        relevantVeiw = ipadView;
        startingPoint = 11;
        endingPoint = 15;
    }
    
    for (int i = startingPoint; i < endingPoint; i++)
    {
        if ([[relevantVeiw viewWithTag:i] isKindOfClass:[UIImageView class]])
        {
            UIImageView *relevantPinImage = (UIImageView *)[relevantVeiw viewWithTag:i];
            relevantPinImage.image = [UIImage imageNamed:@"EntryBox"];
        }
    }
}

- (void)setAttemptLimit:(NSInteger)attemptLimit
{
    if (attemptLimit == 0)
    {
        _attemptLimit = -1;
        return;
    }
    
    _attemptLimit = attemptLimit;
}

#pragma mark -
#pragma mark - Private Methods

- (ABLockPadDeviceType)deviceType
{
    NSString *deviceModel = [[UIDevice currentDevice] model];
    
    if ([deviceModel rangeOfString:@"iPhone"].location != NSNotFound)
        return ABLockPadDeviceTypeiPhone;
    
    if ([deviceModel rangeOfString:@"iPad"].location != NSNotFound)
        return ABLockPadDeviceTypeiPad;
    
    return ABLockPadDeviceTypeiPhone;
}

- (void)cancelButtonSelected:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(unlockWasCancelled)])
    {
        [self.delegate unlockWasCancelled];
        [self resetLockScreen];
        [self resetAttempts];
    }
}

- (void)digitButtonselected:(id)sender
{
    UIButton *digitButton = (UIButton *)sender;
    
    NSString *digitAsString = [NSString stringWithFormat:@"%d", digitButton.tag];

    if ([[ipadView viewWithTag:self.currentPin.length + 11] isKindOfClass:[UIImageView class]])
    {
        UIImageView *relevantPinImage = (UIImageView *)[ipadView viewWithTag:self.currentPin.length + 11];
        relevantPinImage.image = [UIImage imageNamed:@"EntryBox_entry"];
    }
    
    self.currentPin = [NSString stringWithFormat:@"%@%@", self.currentPin, digitAsString];

    if (self.currentPin.length == 4)
        [self performSelector:@selector(checkPin) withObject:Nil afterDelay:0.1];
}

- (void)backButtonSelected:(id)sender
{   
    if ([[ipadView viewWithTag:self.currentPin.length + 10] isKindOfClass:[UIImageView class]])
    {
        UIImageView *relevantPinImage = (UIImageView *)[ipadView viewWithTag:self.currentPin.length + 10];
        relevantPinImage.image = [UIImage imageNamed:@"EntryBox"];
    }
    
    if (self.currentPin.length > 0)
        self.currentPin = [self.currentPin substringWithRange:NSMakeRange(0, self.currentPin.length - 1)];
}

- (void)checkPin
{
    self.attempts ++;
    
    if ([self.currentPin isEqualToString:self.pin])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(unlockWasSuccessful)])
        {
            [self.delegate unlockWasSuccessful];
            [self resetAttempts];
        }

    }
    else
    {
        if (self.attemptLimit != kNoAttemptLimit)
        {
            [self failedAttemptWithRemaningAttempts:self.attemptLimit - self.attempts];
        }
        else
        {
            [self failedFinalAttempt];
        }

        if (self.delegate && [self.delegate respondsToSelector:@selector(unlockWasUnsuccessful:afterAttemptNumber:)])
        {
            [self.delegate unlockWasUnsuccessful:self.currentPin afterAttemptNumber:self.attempts];
        }
        
        if (self.attempts == self.attemptLimit)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(attemptsExpired)])
                [self.delegate attemptsExpired];
            [self lockPad];
        }
    }
   
    [self resetLockScreen];    
}

- (void)lockPad
{
    if (self.deviceType == ABLockPadDeviceTypeiPhone)
    {
        [iPhoneView.hiddenTextField resignFirstResponder];
        iPhoneView.remainingAttemptsLabel.text = @"Attempts expired";
        iPhoneView.subtitleLabel.text = @"PIN Entry Locked";
    }
    else if (self.deviceType == ABLockPadDeviceTypeiPad)
    {
        ipadView.remainingAttemptsLabel.text = @"Attempts expired";
        ipadView.subtitleLabel.text = @"PIN Entry Locked";
    }
}

- (void)failedAttemptWithRemaningAttempts:(NSInteger)remainingAttempts
{
    if (self.deviceType == ABLockPadDeviceTypeiPhone)
    {
        iPhoneView.remainingAttemptsLabel.text = [NSString stringWithFormat:@"%d Attempts Remaining", remainingAttempts];
        if (iPhoneView.errorbackView.alpha == 0.0f)
        {
            [UIView animateWithDuration:0.4f animations:^{
                iPhoneView.errorbackView.alpha = 1.0f;
            }];
        }
    }
    else if (self.deviceType == ABLockPadDeviceTypeiPad)
    {
        ipadView.remainingAttemptsLabel.text = [NSString stringWithFormat:@"%d Attempts Remaining", remainingAttempts];
        if (ipadView.errorbackView.alpha == 0.0f)
        {
            [UIView animateWithDuration:0.4f animations:^{
                ipadView.errorbackView.alpha = 1.0f;
            }];
        }
    }
}

- (void)failedFinalAttempt
{
    if (self.deviceType == ABLockPadDeviceTypeiPhone)
    {
        iPhoneView.remainingAttemptsLabel.text = [NSString stringWithFormat:@"%d Failed Passcode Attempts", self.attempts];
        if (iPhoneView.errorbackView.alpha == 0.0f)
        {
            [UIView animateWithDuration:0.4f animations:^{
                iPhoneView.errorbackView.alpha = 1.0f;
            }];
        }
    }
    else if (self.deviceType == ABLockPadDeviceTypeiPad)
    {
        ipadView.remainingAttemptsLabel.text = [NSString stringWithFormat:@"%d Failed Passcode Attempts", self.attempts];
        if (ipadView.errorbackView.alpha == 0.0f)
        {
            [UIView animateWithDuration:0.4f animations:^{
                ipadView.errorbackView.alpha = 1.0f;
            }];
        }
    }
}

#pragma mark -
#pragma mark - UITextFieldDelegate Methods
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length > 0)
    {
        // Allow only numbers
        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    	if(![string stringByTrimmingCharactersInSet:nonNumberSet].length)
	    	return NO;
        
        //Currently code in here is ony for iPhone. May change if future enhancement allows iPad text entry.
        if ([[iPhoneView viewWithTag:self.currentPin.length + 1] isKindOfClass:[UIImageView class]])
        {
            UIImageView *relevantPinImage = (UIImageView *)[iPhoneView viewWithTag:self.currentPin.length + 1];
            relevantPinImage.image = [UIImage imageNamed:@"EntryBox_entry"];
        }
        self.currentPin = [NSString stringWithFormat:@"%@%@", self.currentPin, string];
    }
    else
    {
        //Currently code in here is ony for iPhone. May change if future enhancement allows iPad text entry.
        if ([[iPhoneView viewWithTag:self.currentPin.length] isKindOfClass:[UIImageView class]])
        {
            UIImageView *relevantPinImage = (UIImageView *)[iPhoneView viewWithTag:self.currentPin.length];
            relevantPinImage.image = [UIImage imageNamed:@"EntryBox"];
        }
        
        if (self.currentPin.length > 0)
            self.currentPin = [self.currentPin substringWithRange:NSMakeRange(0, self.currentPin.length - 1)];
    }
    
    if (self.currentPin.length == 4)
        [self performSelector:@selector(checkPin) withObject:Nil afterDelay:0.1];
    
    return NO;
}

#pragma mark - Interface orientation for iOS 5

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        return YES;
    }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)  {
        return YES;
    }else {
        return NO;
    }
}

@end
