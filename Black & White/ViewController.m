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
    circle2.center = CGPointMake(screenWidth/2, screenHeight/2);
}

- (void)update {
    
    NSTimeInterval secondsSinceLastDraw = -([self.lastUpdateTime timeIntervalSinceNow]);
    
    [circle update:secondsSinceLastDraw acceleration:self.acceleration];
    [circle2 update:secondsSinceLastDraw acceleration:self.acceleration];

    self.lastUpdateTime = [NSDate date];
    
}













- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
