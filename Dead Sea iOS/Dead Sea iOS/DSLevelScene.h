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
    
    DSCharacterSpriteNode * _testChar;
    UIPanGestureRecognizer * _playerMovementRecognizer;
    SKSpriteNode * _comboCountdownBar;
}

-(void)updateComboDisplayForCurrenTime:(CFTimeInterval)currentTime;
@end
