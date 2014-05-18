//
//  PSWaveView.m
//  SiriSimulator
//
//  Created by Wendy Lu on 11/16/13.
//  Copyright (c) 2013 Pinterest. All rights reserved.
//

#import "SiriWaveView.h"

@interface SiriWaveView ()
@property (nonatomic, assign) CGMutablePathRef path;
@property (nonatomic, assign) CGFloat currentWaveAmplitude;
@property (nonatomic, assign) CGFloat currentWaveWavelength;
@end
@implementation SiriWaveView

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
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGMutablePathRef newPath = CGPathCreateMutable();
    
    float y = 30.0;
    float x= self.wavelength;
    float yc= self.amplitude / 6;
    float w=0;
    while (w <= 640) {
        CGPathMoveToPoint(newPath, nil, w, y/2);
        CGPathAddQuadCurveToPoint(newPath, nil, w+x/4, -yc, w+ x/2, y/2);
        CGPathMoveToPoint(newPath, nil, w+x/2,y/2);
        CGPathAddQuadCurveToPoint(newPath, nil, w+3*x/4, y+yc, w+x, y/2);
        w+=x;
    }
    
    CGContextAddPath(context, newPath);
    CGContextDrawPath(context, kCGPathStroke);
    self.path = newPath;
    self.currentWaveAmplitude = self.amplitude;
    self.currentWaveWavelength = self.wavelength;
    
    [self moveWaveAnimation];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.currentWaveAmplitude != self.amplitude || self.currentWaveWavelength != self.wavelength) {
        [self setNeedsDisplay];
    } else {
        [self moveWaveAnimation];
    }
}

- (void)moveWaveAnimation
{
    CGMutablePathRef movement = CGPathCreateMutable();
    CGPathMoveToPoint(movement, nil, 0, CGRectGetMinY(self.frame) + (CGRectGetHeight(self.frame) / 2));
    CGPathAddLineToPoint(movement, nil, 320, CGRectGetMinY(self.frame) + (CGRectGetHeight(self.frame) / 2));
    
    CAKeyframeAnimation * theAnimation;
    
    // Create the animation object, specifying the position property as the key path.
    theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    theAnimation.path = movement;
    theAnimation.duration = 0.8;
    theAnimation.delegate = self;
    
    // Add the animation to the layer.
    [self.layer addAnimation:theAnimation forKey:@"position"];
}

@end
