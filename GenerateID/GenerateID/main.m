//
//  main.m
//  GenerateID
//
//  Created by Michael on 03/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Playground.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Playground * play = [Playground new];
        
        [play greeting];
        
        [play greeting:@"Hi"];
        
        [play greeting:@"hey" times:3];
        
//        [play setQuestion:5];
//        int r = [play question];
        
        play.question = 5;
        
//        play.a ;
        
//        play.x 
        int r = play.question;
        
        NSLog(@"question %d",r);
        
        NSDateFormatter * formatter = [NSDateFormatter new];
        NSDate * date = [NSDate date];

        [formatter setDateFormat:@"YYYY-MM-DD"];
        NSLog(@"%@",[formatter stringFromDate:date]);
//        NSUUID * myid = [NSUUID UUID];
//        NSLog(@"    %@",myid);
//        int num = 5;
//        NSString * name = @"Michael";
//        name = [[NSString alloc] initWithFormat:@"Michael"];
//
//        NSLog(@"Hello, World! %l %@", 56, @"Michael");
//
//        [@"Michael" stringByReplacingOccurrencesOfString:@"M" withString:@"m"];
//
//        [@"Michael" stringByAppendingString:@" Pan"];
//
//        NSString * idString = [myid UUIDString];
//
//        id omnivar = myid;
////        [omnivar stringByAppendingString:@" xxx"];
//
//
//        omnivar = idString;
        
        
        
//        seletor("stringByReplacingOccurrencesOfString:withString:");
    }
    return 0;
}
