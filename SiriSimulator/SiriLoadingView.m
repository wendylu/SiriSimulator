//
//  PSLoadingView.m
//  SiriSimulator
//
//  Created by Wendy Lu on 11/18/13.
//  Copyright (c) 2013 Pinterest. All rights reserved.
//

#import "SiriLoadingView.h"

@implementation SiriLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat centerX = CGRectGetWidth(rect) / 2;
    CGFloat centerY = CGRectGetHeight(rect) / 2;
    CGFloat radius = 32;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGMutablePathRef newPath = CGPathCreateMutable();
    CGPathMoveToPoint(newPath, nil, centerX + radius, centerY);
    CGPathAddArc(newPath, nil, centerX, centerY, radius, DegreesToRadians(0), DegreesToRadians(110), 1);
    
    CGContextAddPath(context, newPath);
    CGContextDrawPath(context, kCGPathStroke);
    
    [self rotateCircle];
}

- (void)rotateCircle
{
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = @0.0f;
    animation.toValue = @(2*M_PI);
    animation.duration = 1.0f;             // this might be too fast
    animation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:animation forKey:@"rotation"];
}

CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}

@end
