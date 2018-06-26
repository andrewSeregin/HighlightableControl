//
//  CABasicAnimation+CABasicAnimation_Creation.h
//  HighlightableControl
//
//  Created by Andrew Seregin on 26.06.2018.
//  Copyright © 2018 Andrew Seregin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CABasicAnimation (Creation)

+ (instancetype) animationWithKeyPath:(NSString *)path duration:(float)duration timingFunction:(NSString *)name;

@end
