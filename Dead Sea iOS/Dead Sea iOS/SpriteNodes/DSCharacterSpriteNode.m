//
//  DSCharacterSpriteNode.m
//  Dead Sea iOS
//
//  Created by Kip on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSCharacterSpriteNode.h"

@implementation DSCharacterSpriteNode

-(void)fire
{
    NSLog(@"Pew");
    if(_bFiring && self.fireRate > 0)
    {
        double delayInSeconds = 1.0/self.fireRate;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(_bFiring && self.fireRate > 0)
            {
                [self fire];
            }
        });
    }
}

-(void)startFiring
{
    _bFiring = YES;
    [self fire];
}
-(void)stopFiring
{
    _bFiring = NO;
}
@end