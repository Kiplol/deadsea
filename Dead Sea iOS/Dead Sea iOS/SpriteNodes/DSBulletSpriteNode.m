//
//  DSBulletSpriteNode.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSBulletSpriteNode.h"
#import "BulletFactory.h"

@implementation DSBulletSpriteNode

-(id)init
{
    return [self initWithSpeedVector:CGVectorMake(0.0f, 30.0f)];
}

-(id)initWithSpeedVector:(CGVector)speedVector
{
    if((self = [super init]))
    {
        self.speedVector = speedVector;
        self.name = NAME_BULLET;
        _bFired = NO;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.collisionBitMask = DSColliderTypeNone;
//        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = DSColliderTypeProjectile;
        self.physicsBody.friction = 0;
        self.physicsBody.linearDamping = 0;
    }
    return self;
}

-(void)fire
{
    _bFired = YES;
    [[OceanPhysicsController sharedController] addPhysicsObject:self];
    [self.physicsBody applyImpulse:CGVectorMake(self.speedVector.dx, self.speedVector.dy)];
}
-(void)removeFromPlay
{
    [super removeFromPlay];
    self.shooter = nil;
    [self removeFromParent];
    [[OceanPhysicsController sharedController] removePhysicsObject:self];
    _bFired = NO;
    [[BulletFactory sharedFactory] returnBulletForReuse:self];
}

#pragma mark - DSOceanPhysicsDelegate
@end
