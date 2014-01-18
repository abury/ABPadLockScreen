//
//  ABPadLockScreenView.h
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

@class ABPinSelectionView;

@interface ABPadLockScreenView : UIView

@property (nonatomic, strong) UIFont *enterPasscodeLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *detailLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *labelColour UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) BOOL cancelButtonDisabled;

@property (nonatomic, strong, readonly) ABPinSelectionView *pinOneSelectionView;
@property (nonatomic, strong, readonly) ABPinSelectionView *pinTwoSelectionView;
@property (nonatomic, strong, readonly) ABPinSelectionView *pinThreeSelectionView;
@property (nonatomic, strong, readonly) ABPinSelectionView *pinFourSelectionView;

@property (nonatomic, strong, readonly) UILabel *enterPasscodeLabel;
@property (nonatomic, strong, readonly) UILabel *detailLabel;

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

@property (nonatomic, strong, readonly) UIButton *cancelButton;
@property (nonatomic, strong, readonly) UIButton *deleteButton;

- (NSArray *)buttonArray; //Lazy loaded array that returns all the buttons ordered from 0-9
- (void)showCancelButtonAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)showDeleteButtonAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)updateDetailLabelWithString:(NSString *)string animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)lockViewAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end