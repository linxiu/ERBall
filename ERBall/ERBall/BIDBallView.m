//
//  BIDBallView.m
//  ERBall
//
//  Created by linxiu on 16/5/20.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "BIDBallView.h"

@interface BIDBallView ()

@property (strong,nonatomic) UIImage *image;
@property (assign,nonatomic) CGPoint currentPoint;
@property (assign,nonatomic) CGPoint previousPoint;
@property (assign,nonatomic) CGFloat ballXVelocity; //Xzhou上的速度
@property (assign,nonatomic) CGFloat ballYVelocity;  //Yzhou上的速度

@end

@implementation BIDBallView

-(void)commonInit{
    
    self.image = [UIImage imageNamed:@"pic_客服头像@2x.png"];
    self.currentPoint = CGPointMake((self.bounds.size.width /2.0f)+(self.image.size.width/2.0f), (self.bounds.size.height/2.0f)+(self.bounds.size.height/2.0f));
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    
    [self.image drawAtPoint:self.currentPoint]; //绘图代码
}
#pragma Mark

-(void)setCurrentPoint:(CGPoint)newPoint{
    
    self.previousPoint = self.currentPoint; //旧的值存在previousPoint
    _currentPoint = newPoint; //新值赋给currentPoint
    
    if (self.currentPoint.x < 0) {
        _currentPoint.x = 0;
        self.ballXVelocity = 0;
        
    }
    if (self.currentPoint.y < 0) {
        _currentPoint.y = 0;
        self.ballYVelocity = 0;
        
    }
    
    if (self.currentPoint.x > self.bounds.size.width - self.image.size.width) {
        _currentPoint.x = self.bounds.size.width - self.image.size.width;
        self.ballXVelocity = 0;
    }
    if (self.currentPoint.y > self.bounds.size.width - self.image.size.width ){
        _currentPoint.y = self.bounds.size.width - self.image.size.width;
        self.ballYVelocity = 0;
    }
    
    CGRect currentRect = CGRectMake(self.currentPoint.x, self.currentPoint.y, self.currentPoint.x+self.image.size.width, self.currentPoint.y+self.image.size.height);
    CGRect previousRect = CGRectMake(self.previousPoint.x, self.previousPoint.y, self.previousPoint.x+self.image.size.width, self.previousPoint.y+self.image.size.height);
    
    [self setNeedsDisplayInRect:CGRectUnion(currentRect, previousRect)];
}

-(void)update{
    static NSDate *lastUpdateTime = nil;
    
    if (lastUpdateTime != nil) {
        
        NSTimeInterval secondSinceLastDraw = [[NSDate date]timeIntervalSinceDate:lastUpdateTime];
        
        self.ballYVelocity = self.ballYVelocity - (self.acceleration.y * secondSinceLastDraw);
        self.ballXVelocity = self.ballXVelocity + (self.acceleration.x *secondSinceLastDraw);
        
        
        CGFloat xAccel = secondSinceLastDraw * self.ballXVelocity *500;
        CGFloat yAccel = secondSinceLastDraw *self.ballYVelocity *500;
        
        self.currentPoint = CGPointMake(self.currentPoint.x + xAccel, self.currentPoint.y + yAccel);
    }
    lastUpdateTime = [[NSDate alloc]init]; //用当前时间更新最后时间
    
}
@end