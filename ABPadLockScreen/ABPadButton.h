// ABPadButton.h
//
// Copyright (c) 2015 Aron Bury - http://www.aronbury.com
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

@import UIKit;

/**
 A pin button designed to look like a telephone number button displaying the number, letters and handling it's
 own animation
 */
@interface ABPadButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number letters:(NSString *)letters;

@property (nonatomic, strong, readonly) UILabel *numberLabel;
@property (nonatomic, strong, readonly) UILabel *lettersLabel;

@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *selectedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *hightlightedTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *numberLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *letterLabelFont UI_APPEARANCE_SELECTOR;

@end

extern CGFloat const ABPadButtonHeight;
extern CGFloat const ABPadButtonWidth;
