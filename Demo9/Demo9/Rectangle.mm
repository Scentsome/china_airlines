//
//  Rectangle.m
//  Demo9
//
//  Created by Michael on 03/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

#import "Rectangle.h"
#import <UIKit/UIKit.h>
#import "Demo9-Swift.h"



@implementation Rectangle{
    CGFloat x;
    CGFloat y;
    
//    CGFloat height;
}

-(void) setX:(CGFloat) anX withY:(CGFloat) aY{
    x = anX;
    y = aY;
}
-(void) center{
    CGFloat cx = x + _width / 2 ;
    CGFloat cy = y + _height / 2 ;
    NSLog(@"%f, %f", cx, cy);
}

-(void) makeCircle {
    Circle * cr = [Circle new];
    cr.radius = 5;
    NSLog(@"radius %d",cr.radius);
}

@end
