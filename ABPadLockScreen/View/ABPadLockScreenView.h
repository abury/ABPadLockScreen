//
//  ABPadLockScreenView.h
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

@interface ABPadLockScreenView : UIView

@property (nonatomic, strong) UIFont *labelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *labelColour UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong, readonly) UILabel *enterPasscodeLabel;

@property (nonatomic, strong, readonly) UIButton *buttonOne;
@property (nonatomic, strong, readonly) UIButton *buttonTwo;
@property (nonatomic, strong, readonly) UIButton *buttonThree;

@property (nonatomic, strong, readonly) UIButton *buttonFour;
@property (nonatomic, strong, readonly) UIButton *buttonFive;
@property (nonatomic, strong, readonly) UIButton *buttonSix;

@property (nonatomic, strong, readonly) UIButton *buttonSeven;
@property (nonatomic, strong, readonly) UIButton *buttonEight;
@property (nonatomic, strong, readonly) UIButton *buttonNine;

@property (nonatomic, strong, readonly) UIButton *buttonZero;

@end