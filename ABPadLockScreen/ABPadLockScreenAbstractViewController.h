// ABPadLockScreenAbstractViewController.h
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

/**
 Abstract Class that encapsulates common functionality between the lock and setup screen. It is not designed to be used directly
 */

@protocol ABPadLockScreenDelegate;
@class ABPadLockScreenView;

@interface ABPadLockScreenAbstractViewController : UIViewController
{
	ABPadLockScreenView* lockScreenView;
}

@property (nonatomic, strong) NSString *currentPin;
@property (nonatomic, weak) id<ABPadLockScreenDelegate> delegate;
@property (nonatomic, readonly, getter = isComplexPin) BOOL complexPin;
@property (nonatomic, assign) BOOL tapSoundEnabled; //No by Default
@property (nonatomic, assign) BOOL errorVibrateEnabled; //No by Default

- (id)initWithComplexPin:(BOOL)complexPin;

- (void)newPinSelected:(NSInteger)pinNumber;
- (void)deleteFromPin;

- (void)setLockScreenTitle:(NSString *)title;
- (void)setSubtitleText:(NSString *)text;
- (void)setCancelButtonText:(NSString *)text;
- (void)setDeleteButtonText:(NSString *)text;
- (void)setEnterPasscodeLabelText:(NSString *)text;

- (void)cancelButtonDisabled:(BOOL)disabled;

- (void)setBackgroundView:(UIView*)backgroundView;

- (void)processPin; //Called when the pin has reached maximum digits

@end

@protocol ABPadLockScreenDelegate <NSObject>
@required
- (void)unlockWasCancelledForPadLockScreenViewController:(ABPadLockScreenAbstractViewController *)padLockScreenViewController;

@end