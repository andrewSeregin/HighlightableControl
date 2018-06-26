//
//  HighlightableControl.h
//  HighlightableControl
//
//  Created by Andrew Seregin on 26.06.2018.
//  Copyright © 2018 Andrew Seregin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CABasicAnimation+Creation.h"

@interface HighlightableControl : UIControl

@property (assign, nonatomic) CGFloat scaling;
@property (assign, nonatomic) float duration;
@property (assign, nonatomic) CGFloat offset;
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIColor *color;

- (instancetype)initWithContent:(UIView *)view;

@end
