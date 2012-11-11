//
//  ABPadLockScreenView_iPhone.m
//  ABPadLockScreen
//
//  Created by Aron Bury on 10/11/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "ABPadLockScreenView_iPhone.h"

@interface ABPadLockScreenView_iPhone()



@end

@implementation ABPadLockScreenView_iPhone

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
        self.hiddenTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 20, 1)];
        self.hiddenTextField.keyboardAppearance = UIKeyboardAppearanceDefault;
        self.hiddenTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.hiddenTextField.hidden = YES;
        self.hiddenTextField.userInteractionEnabled = YES;
        self.hiddenTextField.text = @"####";        
        
        self.box1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EntryBox"]];
        self.box2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EntryBox"]];
        self.box3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EntryBox"]];
        self.box4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EntryBox"]];
        
        self.box1.tag = 1;
        self.box2.tag = 2;
        self.box3.tag = 3;
        self.box4.tag = 4;
        
        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.subtitleLabel.textColor = [UIColor whiteColor];
        self.subtitleLabel.backgroundColor = [UIColor clearColor];
        self.subtitleLabel.shadowColor = [UIColor blackColor];
        
        [self addSubview:self.box1];
        [self addSubview:self.box2];
        [self addSubview:self.box3];
        [self addSubview:self.box4];
        
        [self addSubview:self.subtitleLabel];
        [self addSubview:self.hiddenTextField];
    }
    return self;
}

- (void)layoutSubviews
{
    self.subtitleLabel.frame = CGRectMake(10, 20, self.frame.size.width - 20, 33);
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    float boxTop = self.subtitleLabel.frame.origin.y + self.subtitleLabel.frame.size.height + 10;
    float boxWidth = self.box1.frame.size.width;
    float boxLeft = 20;
    float boxPadding = 10;
    
    self.box1.frame = CGRectMake(boxLeft, boxTop, boxWidth, self.box1.frame.size.height);
    self.box2.frame = CGRectMake(boxLeft + boxWidth + boxPadding, boxTop, boxWidth, self.box1.frame.size.height);
    self.box3.frame = CGRectMake(boxLeft + (boxWidth*2) + (boxPadding * 2), boxTop, boxWidth, self.box1.frame.size.height);
    self.box4.frame = CGRectMake(boxLeft + (boxWidth*3) + (boxPadding * 3), boxTop, boxWidth, self.box1.frame.size.height);
}

@end
