//
//  ViewController.m
//  Black & White
//
//  Created by Kevin Su on 7/2/14.
//  Copyright (c) 2014 KSu Collective. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    self.lastUpdateTime = [[NSDate alloc] init];
    
    self.motionManager = [[CMMotionManager alloc]  init];
    self.queue         = [[NSOperationQueue alloc] init];
    
    self.motionManager.accelerometerUpdateInterval = kUpdateInterval;
    
    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:
     ^(CMAccelerometerData *accelerometerData, NSError *error) {
         [(id) self setAcceleration:accelerometerData.acceleration];
         [self performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:NO];
     }];
    
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    titleLabel.center = CGPointMake(screenWidth/2, screenHeight/2);
    
    circle.center = CGPointMake(screenWidth/2, screenHeight/2);
    self.currentPoint  = CGPointMake(screenWidth/2 - circle.frame.size.width/2, screenHeight/2 - circle.frame.size.height/2);
}

- (void)update {
    
    NSTimeInterval secondsSinceLastDraw = -([self.lastUpdateTime timeIntervalSinceNow]);
    
    self.circleYVelocity = self.circleYVelocity - (self.acceleration.x * secondsSinceLastDraw);
    self.circleXVelocity = self.circleXVelocity - (self.acceleration.y * secondsSinceLastDraw);
    
    CGFloat xDelta = secondsSinceLastDraw * self.circleXVelocity * 500;
    CGFloat yDelta = secondsSinceLastDraw * self.circleYVelocity * 500;
    
    self.currentPoint = CGPointMake(self.currentPoint.x + xDelta,
                                    self.currentPoint.y + yDelta);
    
    [self movecircle];
    
    self.lastUpdateTime = [NSDate date];
    
}

- (void)movecircle {
    [self collisionWithBoundaries];
    
    self.previousPoint = self.currentPoint;
    
    CGRect frame = circle.frame;
    frame.origin.x = self.currentPoint.x;
    frame.origin.y = self.currentPoint.y;
    
    circle.frame = frame;
    
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
    [circle.layer addAnimation:rotate forKey:@"10"];
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
    
    if (self.currentPoint.x > screenWidth - circle.frame.size.width) {
        _currentPoint.x = screenWidth - circle.frame.size.width;
        self.circleXVelocity = -(self.circleXVelocity / 2.0);
    }
    
    if (self.currentPoint.y > screenHeight - circle.frame.size.height) {
        _currentPoint.y = screenHeight - circle.frame.size.height;
        self.circleYVelocity = -(self.circleYVelocity / 2.0);
    }
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
