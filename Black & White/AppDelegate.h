//
//  AppDelegate.h
//  Black & White
//
//  Created by Kevin Su on 7/2/14.
//  Copyright (c) 2014 KSu Collective. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

CGFloat screenWidth;
CGFloat screenHeight;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CMMotionManager *motionManager;
}
@property (strong, nonatomic) UIWindow *window;


// Test comment for github

@end