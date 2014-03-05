//
//  DSBulletEmitter.m
//  Dead Sea iOS
//
//  Created by Kip on 3/4/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSBulletEmitter.h"
#import "BulletFactory.h"
#import "SKSpriteNode+Utilities.h"
@implementation DSBulletEmitter

#if DEBUG
-(id)init
{
    if((self = [super initWithColor:[UIColor whiteColor] size:CGSizeMake(5, 5)]))
    {
        
    }
    return self;
}
#endif
-(void)fireFrom:(DSCharacterSpriteNode*)shooter
{
    [self fireFrom:shooter WithSpeed:self.bulletSpeed];
}

-(void)fireFrom:(DSCharacterSpriteNode*)shooter WithSpeed:(double)speed
{
    DSBulletSpriteNode * bullet = [[BulletFactory sharedFactory] bulletOfType:self.bulletType];
    [self.scene addChild:bullet];
    CGPoint scenePosition = [self.scene convertPoint:self.position fromNode:self.parent];
    bullet.position = scenePosition;
    [self fireBullet:bullet from:shooter withSpeed:speed];
}

-(void)fireBullet:(DSBulletSpriteNode *)bullet from:(DSCharacterSpriteNode *)shooter withSpeed:(double)speed
{
    bullet.shooter = shooter;
    CGFloat absoluteRotation = [self absoluteZRotation];
    CGPoint pointVector = CGPointMultiplyScalar(CGPointForAngle(absoluteRotation), speed);
    bullet.speedVector = CGVectorFromCGPoint(pointVector);
    bullet.physicsBody.contactTestBitMask = self.colliderType;
    [bullet fire];
}
@end
