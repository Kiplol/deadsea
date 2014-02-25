//
//  DSBulletSpriteNode.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSBulletSpriteNode.h"

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
    [[OceanPhysicsController sharedController] removePhysicsObject:self];
    _bFired = NO;
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
