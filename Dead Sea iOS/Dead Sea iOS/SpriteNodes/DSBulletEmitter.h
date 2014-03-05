//
//  DSBulletEmitter.h
//  Dead Sea iOS
//
//  Created by Kip on 3/4/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSpriteNode.h"
#import "BulletFactory.h"

@class DSBulletSpriteNode;
@interface DSBulletEmitter : DSSpriteNode {
    
}

@property (nonatomic, readwrite) factoryBulletType bulletType;
@property (nonatomic, readwrite) DSColliderType colliderType;
@property (nonatomic, readwrite) double bulletSpeed;

/*!
 * @brief Fire a bullet with the instance's parameters for bulletType and colliderType
 */
-(void)fire;

-(void)fireWithSpeed:(double)speed;

/*!
 * @brief Fire a given bullet.  Only the bullet's position and angle will be mutated.
 */
-(void)fireBullet:(DSBulletSpriteNode*)bullet withSpeed:(double)speed;
@end
