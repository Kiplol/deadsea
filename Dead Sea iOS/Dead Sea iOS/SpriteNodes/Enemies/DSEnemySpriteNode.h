//
//  DSEnemySpriteNode.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSCharacterSpriteNode.h"
#define NAME_ENEMY @"enemy"

@interface DSEnemySpriteNode : DSCharacterSpriteNode {
    SKLabelNode * _pointsLabel;
    int _pointsForDestroying;
}

@property (nonatomic, readonly) int pointsForDestroying;

-(void)flashPointsLabel;
-(void)flashPointsLabelInScene:(SKScene*)scene;
@end
