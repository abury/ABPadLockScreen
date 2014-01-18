//
//  ABPadLockScreenView.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPadLockScreenView.h"
#import "ABPadButton.h"

@interface ABPadLockScreenView()

- (void)prepareApperance;
- (void)performLayout;

@end

@implementation ABPadLockScreenView

#pragma mark -
#pragma mark - Init Methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _enterPasscodeLabel = [self standardLabel];
        _enterPasscodeLabel.text = @"Enter Passcode";
        
        _buttonOne = [[ABPadButton alloc] initWithFrame:CGRectZero number:1 letters:nil];
        _buttonTwo = [[ABPadButton alloc] initWithFrame:CGRectZero number:2 letters:@"ABC"];
        _buttonThree = [[ABPadButton alloc] initWithFrame:CGRectZero number:3 letters:@"DEF"];
        
        _buttonFour = [[ABPadButton alloc] initWithFrame:CGRectZero number:4 letters:@"GHI"];
        _buttonFive = [[ABPadButton alloc] initWithFrame:CGRectZero number:5 letters:@"JKL"];
        _buttonSix = [[ABPadButton alloc] initWithFrame:CGRectZero number:6 letters:@"MNO"];
        
        _buttonSeven = [[ABPadButton alloc] initWithFrame:CGRectZero number:7 letters:@"PQRS"];
        _buttonEight = [[ABPadButton alloc] initWithFrame:CGRectZero number:8 letters:@"TUV"];
        _buttonNine = [[ABPadButton alloc] initWithFrame:CGRectZero number:9 letters:@"WXYZ"];
        
        _buttonZero = [[ABPadButton alloc] initWithFrame:CGRectZero number:0 letters:nil];
    }
    return self;
}

#pragma mark -
#pragma mark - Lifecycle Methods
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self performLayout];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self prepareApperance];
}
#pragma mark -
#pragma mark - Helper Methods
- (void)prepareApperance
{
    self.enterPasscodeLabel.textColor = self.labelColour;
}

- (void)performLayout
{
    self.enterPasscodeLabel.frame = CGRectMake((self.frame.size.width/2) - 100, 40, 200, 23);
    [self addSubview:self.enterPasscodeLabel];
    
    CGFloat buttonPadding = 19;
    
    CGFloat lefButtonLeft = 29;
    CGFloat centerButtonLeft = lefButtonLeft + ABPadButtonWidth + buttonPadding;
    CGFloat rightButtonLeft = centerButtonLeft + ABPadButtonWidth + buttonPadding;
    
    CGFloat topRowTop = 150;
    CGFloat middleRowTop = topRowTop + ABPadButtonHeight + buttonPadding;
    CGFloat bottomRowTop = middleRowTop + ABPadButtonHeight + buttonPadding;
    CGFloat zeroRowTop = bottomRowTop + ABPadButtonHeight + buttonPadding;
    
    self.buttonOne.frame = CGRectMake(lefButtonLeft, topRowTop, ABPadButtonWidth, ABPadButtonHeight);
    self.buttonTwo.frame = CGRectMake(centerButtonLeft, topRowTop, ABPadButtonWidth, ABPadButtonHeight);
    self.buttonThree.frame = CGRectMake(rightButtonLeft, topRowTop, ABPadButtonWidth, ABPadButtonHeight);
    
    self.buttonFour.frame = CGRectMake(lefButtonLeft, middleRowTop, ABPadButtonWidth, ABPadButtonHeight);
    self.buttonFive.frame = CGRectMake(centerButtonLeft, middleRowTop, ABPadButtonWidth, ABPadButtonHeight);
    self.buttonSix.frame = CGRectMake(rightButtonLeft, middleRowTop, ABPadButtonWidth, ABPadButtonHeight);
    
    self.buttonSeven.frame = CGRectMake(lefButtonLeft, bottomRowTop, ABPadButtonWidth, ABPadButtonHeight);
    self.buttonEight.frame = CGRectMake(centerButtonLeft, bottomRowTop, ABPadButtonWidth, ABPadButtonHeight);
    self.buttonNine.frame = CGRectMake(rightButtonLeft, bottomRowTop, ABPadButtonWidth, ABPadButtonHeight);
    
    self.buttonZero.frame = CGRectMake(centerButtonLeft, zeroRowTop, ABPadButtonWidth, ABPadButtonHeight);
    
    [self addSubview:self.buttonOne];
    [self setRoundedView:self.buttonOne toDiameter:75];
    [self addSubview:self.buttonTwo];
    [self setRoundedView:self.buttonTwo toDiameter:75];
    [self addSubview:self.buttonThree];
    [self setRoundedView:self.buttonThree toDiameter:75];
    
    [self addSubview:self.buttonFour];
    [self setRoundedView:self.buttonFour toDiameter:75];
    [self addSubview:self.buttonFive];
    [self setRoundedView:self.buttonFive toDiameter:75];
    [self addSubview:self.buttonSix];
    [self setRoundedView:self.buttonSix toDiameter:75];
    
    [self addSubview:self.buttonSeven];
    [self setRoundedView:self.buttonSeven toDiameter:75];
    [self addSubview:self.buttonEight];
    [self setRoundedView:self.buttonEight toDiameter:75];
    [self addSubview:self.buttonNine];
    [self setRoundedView:self.buttonNine toDiameter:75];
    
    [self addSubview:self.buttonZero];
    [self setRoundedView:self.buttonZero toDiameter:75];
}

#pragma mark -
#pragma mark - Default View Methods
- (UILabel *)standardLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = _labelFont;
    label.textColor = _labelColour;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (void)setRoundedView:(UIView *)roundedView toDiameter:(CGFloat)newSize;
{
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.clipsToBounds = YES;
    roundedView.layer.cornerRadius = newSize / 2.0;
}

@end