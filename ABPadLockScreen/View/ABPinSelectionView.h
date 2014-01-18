//
//  ABPinSelectionView.h
//  ABPadLockScreenDemo
//
//  Created by Aron Bury on 18/01/2014.
//  Copyright (c) 2014 Aron Bury. All rights reserved.
//

/**
 A simple view that indicates if a pin has been selected or not.
 */
@interface ABPinSelectionView : UIView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end
