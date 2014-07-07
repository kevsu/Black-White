//
//  Player.h
//  Black & White
//
//  Created by Kevin Su on 7/7/14.
//  Copyright (c) 2014 KSu Collective. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#define kUpdateInterval (1.0f / 60.0f)

@interface Player : UIImageView


@property (assign, nonatomic) CGPoint currentPoint;
@property (assign, nonatomic) CGPoint previousPoint;
@property (assign, nonatomic) CGFloat angle;
@property (assign, nonatomic) CGFloat circleXVelocity;
@property (assign, nonatomic) CGFloat circleYVelocity;


-(void)update:(NSTimeInterval)timeElapsed acceleration:(CMAcceleration)acc;
-(void)moveCircle;
-(void)collisionWithBoundaries;

@end
