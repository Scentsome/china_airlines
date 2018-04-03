//
//  Playground.m
//  GenerateID
//
//  Created by Michael on 03/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

#import "Playground.h"

@implementation Playground{
//   int question ;
    int x;
}

//-(int) question {
//    return question;
//}
//-(void) setQuestion:(int) newQuestion{
//    NSLog(@"hello question");
//}


-  (void) greeting{
    NSLog(@"hello objc Class %d", _question);
}

-  (void) greeting:  (NSString *) content {
    NSLog(@"%@", content);
}

-  (void) greeting:(NSString *) content  times:(int) times {
    
    for ( int index = 0 ; index < times ; index++) {
        NSLog(@"%@",content);
    }
    
}

@end
