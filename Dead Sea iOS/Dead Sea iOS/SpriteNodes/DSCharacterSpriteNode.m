//
//  DSCharacterSpriteNode.m
//  Dead Sea iOS
//
//  Created by Kip on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSCharacterSpriteNode.h"
#import "DSBulletSpriteNode.h"

@implementation DSCharacterSpriteNode
-(id)init
{
    if((self = [super init]))
    {
        self.fireRate = 5;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.collisionBitMask = DSColliderTypeNone;
    }
    return self;
}
-(void)fire
{
    //Fire now
    DSBulletSpriteNode * bullet = [self nextBullet];
    bullet.position = self.position;
    bullet.shooter = self;
    [self.scene addChild:bullet];
    [bullet fire];
    
    //Do it again
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

-(DSBulletSpriteNode*)nextBullet
{
    NSLog(@"Must override %s", __PRETTY_FUNCTION__);
    return nil;
}
@end
