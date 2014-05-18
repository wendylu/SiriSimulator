//
//  PSMicView.m
//  SiriSimulator
//
//  Created by Wendy Lu on 11/18/13.
//  Copyright (c) 2013 Pinterest. All rights reserved.
//

#import "SiriMicView.h"

#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation SiriMicView

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
    CGPathAddArc(newPath, nil, centerX, centerY, radius, DEGREES_RADIANS(0), DEGREES_RADIANS(360), 1);
    
    CGContextAddPath(context, newPath);
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *micImage = [UIImage imageNamed:@"mic"];
    CGFloat originX = (CGRectGetWidth(rect) - micImage.size.width) / 2;
    CGFloat originY = (CGRectGetHeight(rect) - micImage.size.height) / 2;
    CGRect imageRect = CGRectMake(originX, originY, micImage.size.width, micImage.size.height);
    [micImage drawInRect:imageRect];
}

@end
