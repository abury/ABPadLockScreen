//
//  ABPadLockScreenView_iPad.m
//  ABPadLockScreen
//
//  Created by Aron Bury on 10/11/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "ABPadLockScreenView_iPad.h"

@interface ABPadLockScreenView_iPad()

- (UIButton *)getStyledButtonForNumber:(NSInteger)number;

@end

@implementation ABPadLockScreenView_iPad

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
        self.box1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EntryBox"]];
        self.box2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EntryBox"]];
        self.box3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EntryBox"]];
        self.box4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EntryBox"]];
        
        self.box1.tag = 11;
        self.box2.tag = 12;
        self.box3.tag = 13;
        self.box4.tag = 14;
        
        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.subtitleLabel.textColor = [UIColor whiteColor];
        self.subtitleLabel.backgroundColor = [UIColor clearColor];
        self.subtitleLabel.shadowColor = [UIColor blackColor];
        
        self.remainingAttemptsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.remainingAttemptsLabel.textColor = [UIColor whiteColor];
        self.remainingAttemptsLabel.backgroundColor = [UIColor clearColor];
        self.remainingAttemptsLabel.shadowColor = [UIColor blackColor];
        
        self.errorbackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error-box"]];
        self.errorbackView.alpha = 0.0f;
        
        self.one = [self getStyledButtonForNumber:1];
        self.two = [self getStyledButtonForNumber:2];
        self.three = [self getStyledButtonForNumber:3];
        self.four = [self getStyledButtonForNumber:4];
        self.five = [self getStyledButtonForNumber:5];
        self.six = [self getStyledButtonForNumber:6];
        self.seven = [self getStyledButtonForNumber:7];
        self.eight = [self getStyledButtonForNumber:8];
        self.nine = [self getStyledButtonForNumber:9];
        self.zero = [self getStyledButtonForNumber:0];
        self.back = [self getStyledButtonForNumber:11];
        [self.back setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
        [self.back setBackgroundImage:[UIImage imageNamed:@"clear-selected"] forState:UIControlStateHighlighted];
        self.back.tag = clearTag;
        
        self.blank = [self getStyledButtonForNumber:11];
        [self.blank setBackgroundImage:[UIImage imageNamed:@"blank"] forState:UIControlStateNormal];
        [self.blank setBackgroundImage:[UIImage imageNamed:@"blank"] forState:UIControlStateHighlighted];
        
        [self addSubview:self.box1];
        [self addSubview:self.box2];
        [self addSubview:self.box3];
        [self addSubview:self.box4];
        [self addSubview:self.errorbackView];
        [self.errorbackView addSubview:self.remainingAttemptsLabel];
        [self addSubview:self.one];
        [self addSubview:self.two];
        [self addSubview:self.three];
        [self addSubview:self.four];
        [self addSubview:self.five];
        [self addSubview:self.six];
        [self addSubview:self.seven];
        [self addSubview:self.eight];
        [self addSubview:self.nine];
        [self addSubview:self.zero];
        [self addSubview:self.back];
        [self addSubview:self.blank];
        
        [self addSubview:self.subtitleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    self.subtitleLabel.frame = CGRectMake(10, 20, self.frame.size.width - 20, 33);
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    
    float boxTop = self.subtitleLabel.frame.origin.y + self.subtitleLabel.frame.size.height + 10;
    float boxWidth = self.box1.frame.size.width;
    float boxLeft = 20;
    float boxPadding = 10;
    
    self.box1.frame = CGRectMake(boxLeft, boxTop, boxWidth, self.box1.frame.size.height);
    self.box2.frame = CGRectMake(boxLeft + boxWidth + boxPadding, boxTop, boxWidth, self.box1.frame.size.height);
    self.box3.frame = CGRectMake(boxLeft + (boxWidth*2) + (boxPadding * 2), boxTop, boxWidth, self.box1.frame.size.height);
    self.box4.frame = CGRectMake(boxLeft + (boxWidth*3) + (boxPadding * 3), boxTop, boxWidth, self.box1.frame.size.height);
    
    self.errorbackView.center = self.center;
    self.errorbackView.frame = CGRectMake(self.errorbackView.frame.origin.x, self.box1.frame.origin.y + self.box1.frame.size.height + 20.0f, self.errorbackView.frame.size.width, self.errorbackView.frame.size.height);
    
    self.remainingAttemptsLabel.center = self.errorbackView.center;
    self.remainingAttemptsLabel.frame = CGRectMake(0, 0, self.errorbackView.frame.size.width, self.errorbackView.frame.size.height);
    self.remainingAttemptsLabel.textAlignment = NSTextAlignmentCenter;
    self.remainingAttemptsLabel.font = [UIFont systemFontOfSize:14.0f];
    
    //Add buttons
    CGFloat buttonTop = 200.0f;
    CGFloat buttonHeight = 55.0f;
    CGFloat leftButtonWidth = 106.0f;
    CGFloat middleButtonWidth = 109.0f;
    CGFloat rightButtonWidth = 105.0f;
    
    self.one.frame = CGRectMake(0.0f, buttonTop, leftButtonWidth, buttonHeight);
    self.two.frame = CGRectMake(self.one.frame.origin.x + self.one.frame.size.width, buttonTop, middleButtonWidth, buttonHeight);
    self.three.frame = CGRectMake(self.two.frame.origin.x + self.two.frame.size.width, buttonTop, rightButtonWidth, buttonHeight);
    self.four.frame = CGRectMake(self.one.frame.origin.x, self.one.frame.origin.y + self.one.frame.size.height, leftButtonWidth, buttonHeight);
    self.five.frame = CGRectMake(self.two.frame.origin.x, self.four.frame.origin.y, middleButtonWidth, buttonHeight);
    self.six.frame = CGRectMake(self.three.frame.origin.x, self.four.frame.origin.y, rightButtonWidth, buttonHeight);
    self.seven.frame = CGRectMake(self.one.frame.origin.x, self.six.frame.origin.y + self.six.frame.size.height, leftButtonWidth, buttonHeight);
    self.eight.frame = CGRectMake(self.two.frame.origin.x, self.seven.frame.origin.y, middleButtonWidth, buttonHeight);
    self.nine.frame = CGRectMake(self.three.frame.origin.x, self.seven.frame.origin.y, rightButtonWidth, buttonHeight);
    self.blank.frame = CGRectMake(self.one.frame.origin.x, self.nine.frame.origin.y + self.nine.frame.size.height, leftButtonWidth, buttonHeight);
    self.zero.frame = CGRectMake(self.two.frame.origin.x, self.blank.frame.origin.y, middleButtonWidth, buttonHeight);
    self.back.frame = CGRectMake(self.three.frame.origin.x, self.blank.frame.origin.y, rightButtonWidth, buttonHeight);

    
    
    
}

#pragma mark -
#pragma mark - Private Methods
- (UIButton *)getStyledButtonForNumber:(NSInteger)number
{
    UIButton * returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *imageName = [NSString stringWithFormat:@"%d", number];
    NSString *altImageName = [NSString stringWithFormat:@"%@-selected", imageName];
    [returnButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:altImageName] forState:UIControlStateHighlighted];
    returnButton.tag = number;
    
    return returnButton;
}

@end
