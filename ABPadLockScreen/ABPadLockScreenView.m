// ABPadLockScreenSetupView.m
//
// Copyright (c) 2014 Aron Bury - http://www.aronbury.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ABPadLockScreenView.h"
#import "ABPadButton.h"
#import "ABPinSelectionView.h"

#define animationLength 0.15
#define IS_IPHONE5 ([UIScreen mainScreen].bounds.size.height==568)

@interface ABPadLockScreenView()

@property (nonatomic, assign) BOOL requiresRotationCorrection;

- (void)setDefaultStyles;
- (void)prepareApperance;
- (void)performLayout;
- (void)layoutTitleArea;
- (void)layoutButtonArea;

- (void)setUpButton:(UIButton *)button left:(CGFloat)left top:(CGFloat)top;
- (void)setUpPinSelectionView:(ABPinSelectionView *)selectionView left:(CGFloat)left top:(CGFloat)top;
- (void)performAnimations:(void (^)(void))animations animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (CGFloat)correctWidth;
- (CGFloat)correctHeight;

@end

@implementation ABPadLockScreenView

#pragma mark -
#pragma mark - Init Methods
- (id)initWithFrame:(CGRect)frame pinLength: (NSUInteger)digits
{
    self = [self initWithFrame:frame];
    if (self)
    {
        _pinLength = digits;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setDefaultStyles];
        
        _requiresRotationCorrection = NO;
        
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
        
        // default to 4
        _pinLength = 4;
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

- (NSArray *)digitsArray
{
    if (!_digitsArray)
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.pinLength];
        
        for (NSInteger i = 0; i < self.pinLength; i++)
        {
            ABPinSelectionView *view = [[ABPinSelectionView alloc] initWithFrame:CGRectZero];
            [array addObject:view];
        }
        
        _digitsArray = [array copy];
    }
    
    return _digitsArray;
}

- (void)showCancelButtonAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    __weak ABPadLockScreenView *weakSelf = self;
    [self performAnimations:^{
        weakSelf.cancelButton.alpha = 1.0f;
        weakSelf.deleteButton.alpha = 0.0f;
    } animated:animated completion:completion];
}

- (void)showDeleteButtonAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    __weak ABPadLockScreenView *weakSelf = self;
    [self performAnimations:^{
        weakSelf.cancelButton.alpha = 0.0f;
        weakSelf.deleteButton.alpha = 1.0f;
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
        
        for (ABPinSelectionView *view in self.digitsArray) {
            view.alpha = 0.0f;
        }
    } animated:animated completion:completion];
}

- (void)resetAnimated:(BOOL)animated
{
    for (ABPinSelectionView *view in self.digitsArray)
    {
        [view setSelected:NO animated:animated completion:nil];
    }
    
    [self showCancelButtonAnimated:animated completion:nil];
}

#pragma mark -
#pragma mark - Helper Methods
- (void)setDefaultStyles
{
    _enterPasscodeLabelFont = [UIFont systemFontOfSize:18];
    _detailLabelFont = [UIFont systemFontOfSize:14];
    
    _labelColour = [UIColor whiteColor];
}

- (void)prepareApperance
{
    self.enterPasscodeLabel.textColor = self.labelColour;
    self.enterPasscodeLabel.font = self.enterPasscodeLabelFont;
    
    self.detailLabel.textColor = self.labelColour;
    self.detailLabel.font = self.detailLabelFont;
    
    [self.cancelButton setTitleColor:self.labelColour forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:self.labelColour forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark - Leyout Methods
- (void)performLayout
{
    [self layoutTitleArea];
    [self layoutButtonArea];
    _requiresRotationCorrection = YES;
}

- (void)layoutTitleArea
{
    CGFloat top = ([self correctHeight]/2) - 300;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) top = 40;
    self.enterPasscodeLabel.frame = CGRectMake(([self correctWidth]/2) - 100, top, 200, 23);
    [self addSubview:self.enterPasscodeLabel];
    
    CGFloat pinPadding = 25;
    CGFloat pinRowWidth = (ABPinSelectionViewWidth * self.pinLength) + (pinPadding * (self.pinLength-1));
    
    
    CGFloat pinSelectionTop = self.enterPasscodeLabel.frame.origin.y + self.enterPasscodeLabel.frame.size.height + 10;
    
    CGFloat selectionViewLeft = ([self correctWidth]/2) - (pinRowWidth/2);

    for (ABPinSelectionView *view in self.digitsArray) {
        [self setUpPinSelectionView:view  left:selectionViewLeft top:pinSelectionTop];
        selectionViewLeft+=ABPinSelectionViewWidth + pinPadding;
    }
    
    self.detailLabel.frame = CGRectMake(([self correctWidth]/2) - 100, pinSelectionTop + 30, 200, 23);
    [self addSubview:self.detailLabel];
}

- (void)layoutButtonArea
{
    CGFloat horizontalButtonPadding = 20;
    CGFloat verticalButtonPadding = 10;
    
    CGFloat buttonRowWidth = (ABPadButtonWidth * 3) + (horizontalButtonPadding * 2);
    
    CGFloat lefButtonLeft = ([self correctWidth]/2) - (buttonRowWidth/2) + 0.5;
    CGFloat centerButtonLeft = lefButtonLeft + ABPadButtonWidth + horizontalButtonPadding;
    CGFloat rightButtonLeft = centerButtonLeft + ABPadButtonWidth + horizontalButtonPadding;
    
    CGFloat topRowTop = self.detailLabel.frame.origin.y + self.detailLabel.frame.size.height + 50;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        if (!IS_IPHONE5) topRowTop = self.detailLabel.frame.origin.y + self.detailLabel.frame.size.height + 10;
    
    CGFloat middleRowTop = topRowTop + ABPadButtonHeight + verticalButtonPadding;
    CGFloat bottomRowTop = middleRowTop + ABPadButtonHeight + verticalButtonPadding;
    CGFloat zeroRowTop = bottomRowTop + ABPadButtonHeight + verticalButtonPadding;
    
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
}

- (void)setUpButton:(UIButton *)button left:(CGFloat)left top:(CGFloat)top
{
    button.frame = CGRectMake(left, top, ABPadButtonWidth, ABPadButtonHeight);
    [self addSubview:button];
    [self setRoundedView:button toDiameter:75];
}

- (void)setUpPinSelectionView:(ABPinSelectionView *)selectionView left:(CGFloat)left top:(CGFloat)top
{
    selectionView.frame = CGRectMake(left,
                                     top,
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
#pragma mark - Orientation height helpers
- (CGFloat)correctWidth
{
    if (self.requiresRotationCorrection)
    {
        UIInterfaceOrientation realOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(realOrientation)) return self.frame.size.height;
    }
    
    return self.frame.size.width;
}

- (CGFloat)correctHeight
{
    if (self.requiresRotationCorrection)
    {
        UIInterfaceOrientation realOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(realOrientation)) return self.frame.size.width;
    }
    
    return self.frame.size.height;
}

#pragma mark -
#pragma mark -  View Methods
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