//
//  ABPadButton.h
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

@interface ABPadButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number letters:(NSString *)letters;

@property (nonatomic, strong, readonly) UILabel *numberLabel;
@property (nonatomic, strong, readonly) UILabel *lettersLabel;

@end

extern CGFloat const ABPadButtonHeight;
extern CGFloat const ABPadButtonWidth;