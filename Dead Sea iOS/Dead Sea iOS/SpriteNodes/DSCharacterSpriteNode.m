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
    
    if(bullet)
    {
        bullet.position = self.position;
        bullet.shooter = self;
        [self.scene addChild:bullet];
        [bullet fire];
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
