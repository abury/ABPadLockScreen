//
//  ABPadLockScreenView.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPadLockScreenView.h"
#import "ABPadButton.h"
#import "ABPinSelectionView.h"

#define animationLength 0.15

@interface ABPadLockScreenView()

- (void)prepareApperance;
- (void)performLayout;
- (void)setUpButton:(UIButton *)button left:(CGFloat)left top:(CGFloat)top;
- (void)performAnimations:(void (^)(void))animations animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end

@implementation ABPadLockScreenView

#pragma mark -
#pragma mark - Init Methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _enterPasscodeLabelFont = [UIFont systemFontOfSize:18];
        _detailLabelFont = [UIFont systemFontOfSize:14];
        
        _enterPasscodeLabel = [self standardLabel];
        _enterPasscodeLabel.text = @"Enter Passcode";
        
        _detailLabel = [self standardLabel];
        
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
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        _deleteButton.alpha = 0.0f;
        
        _pinOneSelectionView = [[ABPinSelectionView alloc] initWithFrame:CGRectZero];
        _pinTwoSelectionView = [[ABPinSelectionView alloc] initWithFrame:CGRectZero];
        _pinThreeSelectionView = [[ABPinSelectionView alloc] initWithFrame:CGRectZero];
        _pinFourSelectionView = [[ABPinSelectionView alloc] initWithFrame:CGRectZero];
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
#pragma mark - Public Methods
- (NSArray *)buttonArray
{
    return @[self.buttonZero,
             self.buttonOne, self.buttonTwo, self.buttonThree,
             self.buttonFour, self.buttonFive, self.buttonSix,
             self.buttonSeven, self.buttonEight, self.buttonNine];
}

- (void)showCancelButtonAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    [self performAnimations:^{
        self.cancelButton.alpha = 1.0f;
        self.deleteButton.alpha = 0.0f;
    } animated:animated completion:completion];
}

- (void)showDeleteButtonAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    [self performAnimations:^{
        self.cancelButton.alpha = 0.0f;
        self.deleteButton.alpha = 1.0f;
    } animated:animated completion:completion];
}

- (void)updateDetailLabelWithString:(NSString *)string animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    CGFloat length = (animated) ? animationLength : 0.0;
    CGFloat labelWidth = [string sizeWithAttributes:@{NSFontAttributeName:self.detailLabelFont}].width + 15; //Padding
    
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.duration = length;
    [self.detailLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    
    // This will fade:
    self.detailLabel.text = string;
    self.detailLabel.frame = CGRectMake((self.frame.size.width/2) - 100, 80, labelWidth, 23);
}

- (void)lockViewAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    [self performAnimations:^{
        for (UIButton *button in [self buttonArray])
        {
            button.alpha = 0.2f;
            button.userInteractionEnabled = NO;
        }
        self.cancelButton.alpha = 0.0f;
        self.pinOneSelectionView.alpha = 0.0f;
        self.pinTwoSelectionView.alpha = 0.0f;
        self.pinThreeSelectionView.alpha = 0.0f;
        self.pinFourSelectionView.alpha = 0.0f;
    } animated:animated completion:completion];
}

- (void)resetAnimated:(BOOL)animated
{
    [self.pinOneSelectionView setSelected:NO animated:animated completion:nil];
    [self.pinTwoSelectionView setSelected:NO animated:animated completion:nil];
    [self.pinThreeSelectionView setSelected:NO animated:animated completion:nil];
    [self.pinFourSelectionView setSelected:NO animated:animated completion:nil];
    [self showCancelButtonAnimated:animated completion:nil];
}

#pragma mark -
#pragma mark - Helper Methods
- (void)prepareApperance
{
    self.enterPasscodeLabel.textColor = self.labelColour;
    self.enterPasscodeLabel.font = self.enterPasscodeLabelFont;
    
    self.detailLabel.textColor = self.labelColour;
    self.detailLabel.font = self.detailLabelFont;
    
    [self.cancelButton setTitleColor:self.labelColour forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:self.labelColour forState:UIControlStateNormal];
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
    
    [self setUpButton:self.buttonOne left:lefButtonLeft top:topRowTop];
    [self setUpButton:self.buttonTwo left:centerButtonLeft top:topRowTop];
    [self setUpButton:self.buttonThree left:rightButtonLeft top:topRowTop];
    
    [self setUpButton:self.buttonFour left:lefButtonLeft top:middleRowTop];
    [self setUpButton:self.buttonFive left:centerButtonLeft top:middleRowTop];
    [self setUpButton:self.buttonSix left:rightButtonLeft top:middleRowTop];
    
    [self setUpButton:self.buttonSeven left:lefButtonLeft top:bottomRowTop];
    [self setUpButton:self.buttonEight left:centerButtonLeft top:bottomRowTop];
    [self setUpButton:self.buttonNine left:rightButtonLeft top:bottomRowTop];
    
    [self setUpButton:self.buttonZero left:centerButtonLeft top:zeroRowTop];
    
    if (!self.cancelButtonDisabled)
    {
        self.cancelButton.frame = CGRectMake(rightButtonLeft, zeroRowTop + (ABPadButtonHeight/3), ABPadButtonWidth, 20);
        [self addSubview:self.cancelButton];
    }
    
    self.deleteButton.frame = CGRectMake(rightButtonLeft, zeroRowTop + (ABPadButtonHeight/3), ABPadButtonWidth, 20);
    [self addSubview:self.deleteButton];
    
    CGFloat pinPadding = 25;
    
    CGFloat selectionViewOneLeft = 100;
    CGFloat selectionViewTwoLeft = selectionViewOneLeft + ABPinSelectionViewWidth + pinPadding;
    CGFloat selectionViewThreeLeft = selectionViewTwoLeft + ABPinSelectionViewWidth + pinPadding;
    CGFloat selectionViewFourLeft = selectionViewThreeLeft + ABPinSelectionViewWidth + pinPadding;
    
    [self setUpPinSelectionView:self.pinOneSelectionView left:selectionViewOneLeft];
    [self setUpPinSelectionView:self.pinTwoSelectionView left:selectionViewTwoLeft];
    [self setUpPinSelectionView:self.pinThreeSelectionView left:selectionViewThreeLeft];
    [self setUpPinSelectionView:self.pinFourSelectionView left:selectionViewFourLeft];
    
    self.detailLabel.frame = CGRectMake((self.frame.size.width/2) - 100, 100, 200, 23);
    [self addSubview:self.detailLabel];
}

- (void)setUpButton:(UIButton *)button left:(CGFloat)left top:(CGFloat)top
{
    button.frame = CGRectMake(left, top, ABPadButtonWidth, ABPadButtonHeight);
    [self addSubview:button];
    [self setRoundedView:button toDiameter:75];
}

- (void)setUpPinSelectionView:(ABPinSelectionView *)selectionView left:(CGFloat)left;
{
    selectionView.frame = CGRectMake(left,
                                     self.enterPasscodeLabel.frame.origin.y + self.enterPasscodeLabel.frame.size.height + 10,
                                     ABPinSelectionViewWidth,
                                     ABPinSelectionViewHeight);
    [self addSubview:selectionView];
    [self setRoundedView:selectionView toDiameter:15];
}

- (void)performAnimations:(void (^)(void))animations animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    CGFloat length = (animated) ? animationLength : 0.0f;
    
    [UIView animateWithDuration:length delay:0.0f options:UIViewAnimationOptionCurveEaseIn
                     animations:animations
                     completion:completion];
}

#pragma mark -
#pragma mark - Default View Methods
- (UILabel *)standardLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
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