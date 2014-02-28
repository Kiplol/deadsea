//
//  DSMyScene.h
//  Dead Sea iOS
//

//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DSCharacterSpriteNode.h"

@class DSPlayer;
@interface DSLevelScene : SKScene <SKPhysicsContactDelegate> {
    CGPoint _lastTouchPoint;
    DSPlayer * _player;
    SKLabelNode * _comboLabel;
    
    DSCharacterSpriteNode * _testChar;
    UIPanGestureRecognizer * _playerMovementRecognizer;
}

@end
