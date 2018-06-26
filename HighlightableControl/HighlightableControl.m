//
//  HighlightableControl.m
//  HighlightableControl
//
//  Created by Andrew Seregin on 26.06.2018.
//  Copyright © 2018 Andrew Seregin. All rights reserved.
//

#import "HighlightableControl.h"

@interface HighlightableControl ()

@property (strong, nonatomic) CAShapeLayer *describedShape;
@property (assign, nonatomic, readonly) CGPathRef path;

@end

@implementation HighlightableControl

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _view = [UIView new];
        _color = UIColor.grayColor;
        _duration = 0.5;
        _scaling = 10;
        [self prepareContant];
    }
    return self;
}

- (instancetype)initWithContent:(UIView *)view {
    self = [super initWithFrame:view.frame];
    if (self) {
        _view = view;
        _color = UIColor.grayColor;
        _duration = 0.5;
        _scaling = 10;
        [self prepareContant];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    BOOL oldValue = self.isHighlighted;
    [super setHighlighted:highlighted];
    if (oldValue != highlighted) {
        [self animateHighlight];
    }
    
}

- (void)setOffset:(CGFloat)offset {
    _offset = offset;
    _describedShape.path = self.path;
}

- (CGPathRef) path {
    return [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds,
                                                               -_offset,
                                                               -_offset)
                                      cornerRadius:self.bounds.size.height / 2].CGPath;
    
}

- (void) prepareContant {
    if (![self.subviews containsObject:_view]) {
        _view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_view];
        [NSLayoutConstraint activateConstraints:@[[_view.topAnchor constraintEqualToAnchor:self.topAnchor],
                                                  [_view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                                  [_view.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                                  [_view.rightAnchor constraintEqualToAnchor:self.rightAnchor]]];
    }
}

- (void) prepareHighlightableLayer {
    if (!self.describedShape) {
        _describedShape = [CAShapeLayer new];
        [self.layer insertSublayer:_describedShape atIndex:0];
    }
    _describedShape.frame = self.bounds;
    _describedShape.path = self.path;
    _describedShape.fillColor = _color.CGColor;
    _describedShape.hidden = YES;
    _describedShape.opacity = 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self prepareHighlightableLayer];
}

- (void) animateHighlight {
    
    CGFloat highligtTransformX = [self scale:_scaling scaled:-_describedShape.bounds.size.width];
    CGFloat highligtTransformY = [self scale:_scaling scaled:-_describedShape.bounds.size.height];
    
    CGFloat viewTransformX = [self scale:_scaling scaled:_view.bounds.size.width];
    CGFloat viewTransformY = [self scale:_scaling scaled:_view.bounds.size.height];
    
    CABasicAnimation *animationOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"
                                                                       duration:_duration
                                                                 timingFunction:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *animationHighligtX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"
                                                                         duration:_duration
                                                                   timingFunction:kCAMediaTimingFunctionEaseInEaseOut];
    CABasicAnimation *animationHighligtY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"
                                                                         duration:_duration
                                                                   timingFunction:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *animationViewX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"
                                                                     duration:_duration
                                                               timingFunction:kCAMediaTimingFunctionEaseInEaseOut];
    CABasicAnimation *animationViewY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"
                                                                     duration:_duration
                                                               timingFunction:kCAMediaTimingFunctionEaseInEaseOut];

    if (self.isHighlighted) {
        
        _describedShape.hidden = NO;
        
        animationOpacity.removedOnCompletion = false;
        animationOpacity.toValue = [NSNumber numberWithInt:1];
        animationOpacity.fillMode = kCAFillModeForwards;
        [_describedShape addAnimation:animationOpacity forKey:@"animationOpacity"];
        
        animationHighligtX.removedOnCompletion = NO;
        animationHighligtX.toValue = [NSNumber numberWithFloat:highligtTransformX];
        animationHighligtX.fillMode = kCAFillModeForwards;
        [_describedShape addAnimation:animationHighligtX forKey:@"animationHighligtX"];
        
        animationHighligtY.removedOnCompletion = NO;
        animationHighligtY.toValue = [NSNumber numberWithFloat:highligtTransformY];
        animationHighligtY.fillMode = kCAFillModeForwards;
        [_describedShape addAnimation:animationHighligtY forKey:@"animationHighligtY"];
        
        animationViewX.removedOnCompletion = NO;
        animationViewX.toValue = [NSNumber numberWithFloat:viewTransformX];
        animationViewX.fillMode = kCAFillModeForwards;
        [_view.layer addAnimation:animationViewX forKey:@"animationViewX"];
        
        animationViewY.removedOnCompletion = NO;
        animationViewY.toValue = [NSNumber numberWithFloat:viewTransformY];
        animationViewY.fillMode = kCAFillModeForwards;
        [_view.layer addAnimation:animationViewY forKey:@"animationViewY"];
        
    } else {
        
        animationOpacity.fromValue = [NSNumber numberWithInt:1];
        animationOpacity.toValue = [NSNumber numberWithInt:0];
        [_describedShape addAnimation:animationOpacity forKey:@"animationOpacity"];

        animationHighligtX.fromValue = [NSNumber numberWithFloat:highligtTransformX];
        animationHighligtX.toValue = [NSNumber numberWithFloat:1.0];
        animationHighligtX.fillMode = kCAFillModeForwards;
        [_describedShape addAnimation:animationHighligtX forKey:@"animationHighligtX"];
        
        animationHighligtY.fromValue = [NSNumber numberWithFloat:highligtTransformY];
        animationHighligtY.toValue = [NSNumber numberWithFloat:1.0];
        animationHighligtY.fillMode = kCAFillModeForwards;
        [_describedShape addAnimation:animationHighligtY forKey:@"animationHighligtY"];
        
        animationViewX.fromValue = [NSNumber numberWithFloat:viewTransformX];
        animationViewX.toValue = [NSNumber numberWithFloat:1.0];
        animationViewX.fillMode = kCAFillModeForwards;
        [_view.layer addAnimation:animationViewX forKey:@"animationViewX"];
        
        animationViewY.fromValue = [NSNumber numberWithFloat:viewTransformY];
        animationViewY.toValue = [NSNumber numberWithFloat:1.0];
        animationViewY.fillMode = kCAFillModeForwards;
        [_view.layer addAnimation:animationViewY forKey:@"animationViewY"];
        
    }
    
}

- (CGFloat) scale:(CGFloat)factor scaled:(CGFloat)value {
    return 1 - (factor / value);
}

@end
