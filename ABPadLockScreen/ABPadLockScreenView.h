// ABPadLockScreenSetupView.h
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

#define SIMPLE_PIN_LENGTH 4

@class ABPinSelectionView;

@interface ABPadLockScreenView : UIView

@property (nonatomic, strong) UIFont *enterPasscodeLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *detailLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *deleteCancelLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *labelColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIView* backgroundView;

@property (nonatomic, assign) BOOL cancelButtonDisabled;

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

@property (nonatomic, strong, readonly) UIButton *okButton;

/*
 Lazy loaded array that returns all the buttons ordered from 0-9
 */
- (NSArray *)buttonArray;

/*
 The following are used to decide how to display the padlock view - complex (text field) or simple (digits)
 */
@property (nonatomic, assign, readonly, getter = isComplexPin) BOOL complexPin;
@property (nonatomic, strong, readonly) NSArray *digitsArray;
@property (nonatomic, strong, readonly) UITextField *digitsTextField;

- (void)showCancelButtonAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)showDeleteButtonAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)showOKButton:(BOOL)show animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)updateDetailLabelWithString:(NSString *)string animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)lockViewAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)animateFailureNotification;
- (void)resetAnimated:(BOOL)animated;

- (void)updatePinTextfieldWithLength:(NSUInteger)length;

- (id)initWithFrame:(CGRect)frame complexPin:(BOOL)complexPin;

@end