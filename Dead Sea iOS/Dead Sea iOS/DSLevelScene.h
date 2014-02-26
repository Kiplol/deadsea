//
//  DSMyScene.h
//  Dead Sea iOS
//

//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class DSPlayerCharacter;
@interface DSLevelScene : SKScene <SKPhysicsContactDelegate> {
    CGPoint _lastTouchPoint;
    DSPlayerCharacter * _player;
    SKLabelNode * _comboLabel;
}

@end
