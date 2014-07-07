//
//  ViewController.h
//  Black & White
//
//  Created by Kevin Su on 7/2/14.
//  Copyright (c) 2014 KSu Collective. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <QuartzCore/CAAnimation.h>
#import "Player.h"

#define kUpdateInterval (1.0f / 60.0f)

@interface ViewController : UIViewController
{
    IBOutlet UILabel *titleLabel;
    IBOutlet Player *circle;
    IBOutlet Player *circle2;
}

@property (assign, nonatomic) CMAcceleration acceleration;
@property (strong, nonatomic) CMMotionManager  *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSDate *lastUpdateTime;


@end
