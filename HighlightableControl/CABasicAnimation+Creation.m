//
//  CABasicAnimation+CABasicAnimation_Creation.m
//  HighlightableControl
//
//  Created by Andrew Seregin on 26.06.2018.
//  Copyright © 2018 Andrew Seregin. All rights reserved.
//

#import "CABasicAnimation+Creation.h"

@implementation CABasicAnimation (Creation)

+ (instancetype) animationWithKeyPath:(NSString *)path duration:(float)duration timingFunction:(NSString *)name {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:path];
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:name];
    return animation;
}

@end
