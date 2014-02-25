//
//  DSMyScene.h
//  Dead Sea iOS
//

//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class DSPlayerCharacterSpriteNode;
@interface DSMyScene : SKScene {
    DSPlayerCharacterSpriteNode * _sPlayerShip;
    
    CGPoint _lastTouchPoint;
}

@end
