//
//  Player.m
//  Black & White
//
//  Created by Kevin Su on 7/7/14.
//  Copyright (c) 2014 KSu Collective. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)initWithFrame:(CGRect)aRect
{
    if ((self = [super initWithFrame:aRect])) {
        [self commonInit];
    }
    return self;
}


// called when initialized from storyboard
- (id)initWithCoder:(NSCoder*)coder
{
    if ((self = [super initWithCoder:coder])) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    // do any initialization that's common to both -initWithFrame: and
    self.currentPoint = CGPointMake(screenWidth/2 - self.frame.size.width/2, screenHeight/2 - self.frame.size.height/2);
}


-(void)update:(NSTimeInterval)timeElapsed acceleration:(CMAcceleration)acc
{
    
    self.circleYVelocity = self.circleYVelocity - (acc.x * timeElapsed);
    self.circleXVelocity = self.circleXVelocity - (acc.y * timeElapsed);
    
    CGFloat xDelta = timeElapsed * self.circleXVelocity * 500;
    CGFloat yDelta = timeElapsed * self.circleYVelocity * 500;
    
    self.currentPoint = CGPointMake(self.currentPoint.x + xDelta,
                                    self.currentPoint.y + yDelta);
    
    [self moveCircle];
}

    
-(void)moveCircle{
    
    [self collisionWithBoundaries];
    
    self.previousPoint = self.currentPoint;
        
    CGRect frame = self.frame;
    frame.origin.x = self.currentPoint.x;
    frame.origin.y = self.currentPoint.y;
    
    self.frame = frame;
    
    CGFloat newAngle = (self.circleXVelocity + self.circleYVelocity) * M_PI * 4;
    self.angle += newAngle * kUpdateInterval;
        
    CABasicAnimation *rotate;
    rotate                     = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue           = [NSNumber numberWithFloat:0];
    rotate.toValue             = [NSNumber numberWithFloat:self.angle];
    rotate.duration            = kUpdateInterval;
    rotate.repeatCount         = 1;
    rotate.removedOnCompletion = NO;
    rotate.fillMode            = kCAFillModeForwards;
    [self.layer addAnimation:rotate forKey:@"10"];

}


- (void)collisionWithBoundaries {
    
    if (self.currentPoint.x < 0) {
        _currentPoint.x = 0;
        self.circleXVelocity = -(self.circleXVelocity / 2.0);
    }
    
    if (self.currentPoint.y < 0) {
        _currentPoint.y = 0;
        self.circleYVelocity = -(self.circleYVelocity / 2.0);
    }
    
    if (self.currentPoint.x > screenWidth - self.frame.size.width) {
        _currentPoint.x = screenWidth - self.frame.size.width;
        self.circleXVelocity = -(self.circleXVelocity / 2.0);
    }
    
    if (self.currentPoint.y > screenHeight - self.frame.size.height) {
        _currentPoint.y = screenHeight - self.frame.size.height;
        self.circleYVelocity = -(self.circleYVelocity / 2.0);
    }
    
}

@end
