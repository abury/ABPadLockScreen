//
//  ABPadLockScreenView_iPhone.h
//  ABPadLockScreen
//
//  Created by Aron Bury on 10/11/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABPadLockScreenView_iPhone : UIView

/**
 The entry boxes for the view
 */
@property (nonatomic, strong) UIImageView *box1;
@property (nonatomic, strong) UIImageView *box2;
@property (nonatomic, strong) UIImageView *box3;
@property (nonatomic, strong) UIImageView *box4;

/**
 Displays the subittle text to the user
 */
@property (nonatomic, strong) UILabel *subtitleLabel;

/**
 A hidden text field to allow us to display the keyboard
 */
@property (nonatomic, strong) UITextField *hiddenTextField;

@end
