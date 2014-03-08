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
    SKLabelNode * _scoreLabel;
    
    UIPanGestureRecognizer * _oceanCurrentRecognizer;
    SKSpriteNode * _comboCountdownBar;
}

-(void)updateComboDisplayForCurrenTime:(CFTimeInterval)currentTime;

-(void)playerWillDie;
-(void)playerDidDie;
-(void)playerWillRevive;
-(void)playerDidRevive;
@end
