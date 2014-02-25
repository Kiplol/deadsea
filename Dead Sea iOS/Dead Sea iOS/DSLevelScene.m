//
//  DSMyScene.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSLevelScene.h"
#import "DSPlayerCharacter.h"
#import "OceanPhysicsController.h"

@implementation DSLevelScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.0f green:0.15f blue:0.3f alpha:1.0];
        _player = [DSPlayerCharacter sharedCharacter];
        [self addChild:_player.spriteNode];
    }
    return self;
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
    [super touchesBegan:touches withEvent:event];
    UITouch * touch = [touches anyObject];
    _lastTouchPoint = [touch locationInNode:self];
    [_player.spriteNode startFiring];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    CGPoint deltaVector = CGPointMake(point.x - _lastTouchPoint.x, point.y - _lastTouchPoint.y);
    CGPoint currentPos = _player.spriteNode.position;
    _player.spriteNode.position = CGPointMake(currentPos.x + deltaVector.x, currentPos.y + deltaVector.y);
    _lastTouchPoint = point;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [_player.spriteNode stopFiring];
}

#pragma mark - Updates
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)didSimulatePhysics
{
    [[OceanPhysicsController sharedController] updateObjectsWithPhysics];
}

@end
