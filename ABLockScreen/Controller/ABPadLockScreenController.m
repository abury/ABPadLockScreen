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


typedef enum {
    ABLockPadDeviceTypeiPhone = 0,
    ABLockPadDeviceTypeiPad = 1
    
}ABLockPadDeviceType;

@interface ABPadLockScreenController() <UITextFieldDelegate>

/**
 Helper property to determine the device type the controller is currently running on
 */
@property (nonatomic, readonly) ABLockPadDeviceType deviceType;

/**
 The current pin value
 */
@property (nonatomic) NSString *currentPin;

/**
 How many unlock attempts the user has performed
 */
@property (nonatomic) NSInteger attempts;

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

@end

@implementation ABPadLockScreenController

#pragma mark -
#pragma mark - init Methods
- (id)initWithDelegate:(id<ABlockScreenDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        self.currentPin = @"";
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
    
    
    if ([self.view isKindOfClass:[ABPadLockScreenView_iPhone class]])
    {
        ABPadLockScreenView_iPhone *phoneView = (ABPadLockScreenView_iPhone *)self.view;
        phoneView.hiddenTextField.delegate = self;
        phoneView.subtitleLabel.text = self.subtitle;
        
        UIBarButtonItem *cancelBarButtonitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonSelected:)];
        [[self navigationItem] setRightBarButtonItem:cancelBarButtonitem animated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.view isKindOfClass:[ABPadLockScreenView_iPhone class]])
    {
        ABPadLockScreenView_iPhone *phoneView = (ABPadLockScreenView_iPhone *)self.view;
        [phoneView.hiddenTextField becomeFirstResponder];
    }
    
}
#pragma mark -
#pragma mark - Public Methods
- (void)resetAttempts
{

}

- (void)resetLockScreen
{
    
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
        [self.delegate unlockWasCancelled];
}


- (void)digitButtonselected:(id)sender
{
    
}

- (void)backButtonSelected:(id)sender
{
    
}

- (void)checkPin
{
    
}

- (void)lockPad
{
    
}

#pragma mark -
#pragma mark - UITextFieldDelegate Methods
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length > 0)
    {
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
        
        self.currentPin = [self.currentPin substringWithRange:NSMakeRange(0, self.currentPin.length - 1)];
    }
    
    if
    
    return NO;
}

@end
