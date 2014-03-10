//
//  DSBulletSpriteNode.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSpriteNode.h"
#import "OceanPhysicsController.h"

#define NAME_BULLET @"bullet"
#define ATLAS_KEY_FIRING @"atlasKeyBulletFiring"

@class DSCharacterSpriteNode;
@interface DSBulletSpriteNode : DSSpriteNode <DSOceanPhysicsDelegate> {
    BOOL _bFired;
}

@property (nonatomic, readwrite) CGVector speedVector;
@property (nonatomic, assign) DSCharacterSpriteNode * shooter;

-(id)initWithSpeedVector:(CGVector)speedVector;
-(void)fire;
-(NSString*)fireSound;
@end
