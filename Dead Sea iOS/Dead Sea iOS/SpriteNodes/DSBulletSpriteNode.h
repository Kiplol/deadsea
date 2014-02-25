//
//  DSBulletSpriteNode.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSpriteNode.h"
#import "OceanPhysicsController.h"

@interface DSBulletSpriteNode : DSSpriteNode <DSOceanPhysicsDelegate> {
    
}

@property (nonatomic, readwrite) CGPoint speedVector;

-(id)initWithSpeedVector:(CGPoint)speedVector;
@end
