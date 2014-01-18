//
//  ABPadButton.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPadButton.h"
#import <QuartzCore/QuartzCore.h>

@interface ABPadButton()

@property (nonatomic, strong) UIView *selectedView;

- (void)setDefaultStyles;
- (void)prepareApperance;
- (void)performLayout;

@end

@implementation ABPadButton {
    BOOL _isInitializing;
}

#pragma mark -
#pragma mark - Init Methods
- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number letters:(NSString *)letters
{
    self = [super initWithFrame:frame];
    _isInitializing = YES;
    if (self)
    {
        [self setDefaultStyles];
        
        self.layer.borderWidth = 1.5f;
        _numberLabel = ({
            UILabel *label = [self standardLabel];
            label.text = [NSString stringWithFormat:@"%ld", (long)number];
            label.font = _numberLabelFont;
            label;
        });
        _lettersLabel = ({
            UILabel *label = [self standardLabel];
            label.text = letters;
            label.font = _letterLabelFont;
            label;
        });
        self.accessibilityValue = [NSString stringWithFormat:@"%ld", (long)number];
        
        _selectedView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.alpha = 0.0f;
            view.backgroundColor = _selectedColor;
            view;
        });
    }
    _isInitializing = NO;
    return self;
}

#pragma mark -
#pragma mark - Lifecycle Methods
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self prepareApperance];
    [self performLayout];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self prepareApperance];
}

#pragma mark -
#pragma mark - Helper Methods
- (void)setDefaultStyles
{
    _borderColor = [UIColor whiteColor];
    _selectedColor = [UIColor grayColor];
    _textColor = [UIColor whiteColor];
    _numberLabelFont = [UIFont systemFontOfSize:30];
    _letterLabelFont = [UIFont systemFontOfSize:10];
}

- (void)prepareApperance
{
    self.selectedView.backgroundColor = self.selectedColor;
    self.layer.borderColor = [self.borderColor CGColor];
    self.numberLabel.textColor = self.textColor;
    self.lettersLabel.textColor = self.textColor;
}

- (void)performLayout
{
    self.selectedView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.selectedView];
    
    self.numberLabel.frame = CGRectMake(0, 15, self.frame.size.width, self.frame.size.height/2.5);
    [self addSubview:self.numberLabel];
    
    self.lettersLabel.frame = CGRectMake(0, self.numberLabel.frame.origin.y + self.numberLabel.frame.size.height, self.frame.size.width, 10);
    [self addSubview:self.lettersLabel];
}

#pragma mark -
#pragma mark - Button Overides
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [UIView animateWithDuration:0.15 delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.selectedView.alpha = 1.0f;
    } completion:nil];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [UIView animateWithDuration:0.15 delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.selectedView.alpha = 0.0f;
    } completion:nil];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
}

#pragma mark -
#pragma mark - Default View Methods
- (UILabel *)standardLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

@end

CGFloat const ABPadButtonHeight = 75;
CGFloat const ABPadButtonWidth = 75;