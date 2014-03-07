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
    DSPlayer * _player;
    SKLabelNode * _comboLabel;
    
    DSCharacterSpriteNode * _testChar0;
    DSCharacterSpriteNode * _testChar1;
    DSCharacterSpriteNode * _testChar2;
    UIPanGestureRecognizer * _oceanCurrentRecognizer;
    SKSpriteNode * _comboCountdownBar;
    SKNode * _worldPivot;
    SKNode * _worldLayer;
}

-(void)updateComboDisplayForCurrenTime:(CFTimeInterval)currentTime;
-(void)shakeScene;
-(void)shakeSceneWithVelocity:(CGVector)velocity;
@end
