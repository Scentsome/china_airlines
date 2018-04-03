//
//  Playground.h
//  GenerateID
//
//  Created by Michael on 03/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Playground : NSObject{
    int a;
}
@property int question;
//-(int) question ;
//-(void) setQuestion:(int) newQuestion;

-  (void) greeting;

//-  (void) greeting:  (int) times ;

-  (void) greeting:(NSString *) content ;

// greeting:times:
-  (void) greeting:(NSString *) content  times:(int) times ;
@end




