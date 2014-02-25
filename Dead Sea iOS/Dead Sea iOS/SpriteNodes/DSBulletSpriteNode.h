//
//  DSBulletSpriteNode.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSpriteNode.h"
#import "OceanPhysicsController.h"

#define ATLAS_KEY_FIRING @"atlasKeyBulletFiring"
#define ATLAS_KEY_DEFAULT @"atlasKetBulletDefault"

@interface DSBulletSpriteNode : DSSpriteNode <DSOceanPhysicsDelegate> {
    BOOL _bFired;
}

@property (nonatomic, readwrite) CGPoint speedVector;

-(id)initWithSpeedVector:(CGPoint)speedVector;
-(void)fire;
-(void)removeFromPlay;
@end
