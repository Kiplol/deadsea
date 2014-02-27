//
//  DSCharacterSpriteNode.m
//  Dead Sea iOS
//
//  Created by Kip on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSCharacterSpriteNode.h"
#import "DSBulletSpriteNode.h"

@interface DSCharacterSpriteNode (private)
-(CGFloat)radiusForPhysicsBody;
@end

@implementation DSCharacterSpriteNode
-(id)init
{
    if((self = [super init]))
    {
        self.fireRate = 5;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:[self radiusForPhysicsBody]];
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.collisionBitMask = DSColliderTypeNone;
    }
    return self;
}
-(void)fire
{
    //Fire now
    DSBulletSpriteNode * bullet = [self nextBullet];
    
    if(bullet)
    {
        bullet.position = self.position;
        bullet.shooter = self;
        [self.scene addChild:bullet];
        [bullet fire];
        _shotsThisBurst++;
    }
    
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

#pragma mark - private
-(CGFloat)radiusForPhysicsBody
{
    return (self.size.width * 0.5f);
}
@end
