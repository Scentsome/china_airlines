//
//  Rectangle.h
//  Demo9
//
//  Created by Michael on 03/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Rectangle : NSObject{
    int price;
}
-(void) setX:(CGFloat) anX withY:(CGFloat) aY;
-(void) center;
-(void) makeCircle;
@property CGFloat width;
@property CGFloat height;
@end
