//
//  DSMyScene.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSMyScene.h"
#import "DSPlayerCharacterSpriteNode.h"

@implementation DSMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        _sPlayerShip = [DSPlayerCharacterSpriteNode init];
        [self addChild:_sPlayerShip];
    }
    return self;
}


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
    
    UITouch * touch = [touches anyObject];
    _lastTouchPoint = [touch locationInNode:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    CGPoint deltaVector = CGPointMake(point.x - _lastTouchPoint.x, point.y - _lastTouchPoint.y);
    _sPlayerShip.position = CGPointMake(_sPlayerShip.position.x + deltaVector.x, _sPlayerShip.position.y + deltaVector.y);
    _lastTouchPoint = point;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
