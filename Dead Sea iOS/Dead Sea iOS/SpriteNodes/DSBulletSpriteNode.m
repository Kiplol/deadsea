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
    return [self initWithSpeedVector:CGPointMake(0, 10)];
}

-(id)initWithSpeedVector:(CGPoint)speedVector
{
    if((self = [super init]))
    {
        self.speedVector = speedVector;
        self.name = NAME_BULLET;
        _bFired = NO;
    }
    return self;
}

-(void)fire
{
    _bFired = YES;
    [[OceanPhysicsController sharedController] addPhysicsObject:self];
}
-(void)removeFromPlay
{
    [self.scene removeChildrenInArray:@[self]];
    self.shooter = nil;
    [self removeFromParent];
    [[OceanPhysicsController sharedController] removePhysicsObject:self];
    _bFired = NO;
    [[BulletFactory sharedFactory] returnBulletForReuse:self];
}

#pragma mark - DSOceanPhysicsDelegate
-(CGPoint)vectorForUpdate
{
    return self.speedVector;
}

-(void)applyUpdateVector:(CGPoint)updateVector
{
    self.position = CGPointMake(self.position.x + updateVector.x, self.position.y + updateVector.y);
}
@end
