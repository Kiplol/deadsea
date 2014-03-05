//
//  DSBulletEmitter.m
//  Dead Sea iOS
//
//  Created by Kip on 3/4/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSBulletEmitter.h"
#import "BulletFactory.h"
@implementation DSBulletEmitter

-(void)fire
{
    [self fireWithSpeed:self.speed];
}

-(void)fireWithSpeed:(double)speed
{
    
}

-(void)fireBullet:(DSBulletSpriteNode*)bullet withSpeed:(double)speed
{
    CGPoint pointVector = CGPointMultiplyScalar(CGPointForAngle(self.zRotation), speed);
    bullet.speedVector = CGVectorFromCGPoint(pointVector);
    bullet.physicsBody.collisionBitMask = self.colliderType;
    [bullet fire];
}
@end
