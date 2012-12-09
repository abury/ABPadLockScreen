//
//  ABPadLockScreenView_iPad.h
//  ABPadLockScreen
//
//  Created by Aron Bury on 10/11/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define clearTag 1221

@interface ABPadLockScreenView_iPad : UIView

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
 Displays the remaining alerts to the user
 */
@property (nonatomic, strong) UILabel *remainingAttemptsLabel;

/**
 Displays the red alert background for the remainingAttemptsLabel
 */
@property (nonatomic, strong) UIImageView *errorbackView;

/** Emulated Keyboard Buttons */
@property (nonatomic, strong) UIButton *one;
@property (nonatomic, strong) UIButton *two;
@property (nonatomic, strong) UIButton *three;
@property (nonatomic, strong) UIButton *four;
@property (nonatomic, strong) UIButton *five;
@property (nonatomic, strong) UIButton *six;
@property (nonatomic, strong) UIButton *seven;
@property (nonatomic, strong) UIButton *eight;
@property (nonatomic, strong) UIButton *nine;
@property (nonatomic, strong) UIButton *zero;
@property (nonatomic, strong) UIButton *back;
@property (nonatomic, strong) UIButton *blank;


@end
