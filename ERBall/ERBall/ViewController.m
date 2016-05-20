//
//  ViewController.m
//  ERBall
//
//  Created by linxiu on 16/5/20.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "ViewController.h"
#import "BIDBallView.h"
#import <CoreMotion/CoreMotion.h>

#define kUpdateInterval (1.0f / 60.0f)

@interface ViewController ()

@property (nonatomic,strong)CMMotionManager *motionManager;
@property (nonatomic,strong)NSOperationQueue *queue;

@end

@implementation ViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc]init];
    self.queue = [[NSOperationQueue alloc]init];
    
    self.motionManager.accelerometerUpdateInterval = kUpdateInterval;
    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        
        [(id)self.view setAcceleration:accelerometerData.acceleration];
        [self.view performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:NO];
        
    }];
    
}

@end
