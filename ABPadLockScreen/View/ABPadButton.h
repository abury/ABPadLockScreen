//
//  ABPadButton.h
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

/**
 A pin button designed to look like a telephone number button displaying the number, letters and handling it's
 own animation
 */
@interface ABPadButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number letters:(NSString *)letters;

@property (nonatomic, strong, readonly) UILabel *numberLabel;
@property (nonatomic, strong, readonly) UILabel *lettersLabel;

@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *selectedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *numberLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *letterLabelFont UI_APPEARANCE_SELECTOR;

@end

extern CGFloat const ABPadButtonHeight;
extern CGFloat const ABPadButtonWidth;