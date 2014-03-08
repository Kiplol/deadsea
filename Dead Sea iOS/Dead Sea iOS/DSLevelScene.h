//
//  DSMyScene.h
//  Dead Sea iOS
//

//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DSCharacterSpriteNode.h"

@class DSPlayer;
@class DSCharacterSpawner;
@interface DSLevelScene : SKScene <SKPhysicsContactDelegate> {
    DSPlayer * _player;
    SKLabelNode * _comboLabel;
    SKLabelNode * _scoreLabel;
    DSCharacterSpawner * _spawner;
    
    UIPanGestureRecognizer * _oceanCurrentRecognizer;
    SKSpriteNode * _comboCountdownBar;
}

-(void)updateComboDisplayForCurrenTime:(CFTimeInterval)currentTime;

-(void)playerWillDie;
-(void)playerDidDie;
-(void)playerWillRevive;
-(void)playerDidRevive;
@end
