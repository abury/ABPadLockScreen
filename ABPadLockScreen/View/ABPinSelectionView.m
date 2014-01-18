//
//  ABPinSelectionView.m
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

#import "ABPinSelectionView.h"
#import <QuartzCore/QuartzCore.h>

#define animationLength 0.15

@interface ABPinSelectionView()

@property (nonatomic, strong) UIView *selectedView;

- (void)setDefaultStyles;
- (void)prepareApperance;
- (void)performLayout;

@end

@implementation ABPinSelectionView

#pragma mark -
#pragma mark - Init methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setDefaultStyles];
        self.layer.borderWidth = 1.5f;
        
        _selectedView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.alpha = 0.0f;
            view.backgroundColor = _selectedColor;
            view;
        });
    }
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
    _selectedColor = [UIColor grayColor];
}

- (void)prepareApperance
{
    self.selectedView.backgroundColor = self.selectedColor;
    self.layer.borderColor = [self.selectedColor CGColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)performLayout
{
    self.selectedView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.selectedView];
}

#pragma mark -
#pragma mark - Appearnce Methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    CGFloat length = (animated) ? animationLength : 0.0f;
    CGFloat alpha = (selected) ? 1.0f : 0.0f;
    
    [UIView animateWithDuration:length delay:0.0f options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.selectedView.alpha = alpha;
                     }
                     completion:completion];
}

@end

CGFloat const ABPinSelectionViewWidth = 10;
CGFloat const ABPinSelectionViewHeight = 10;