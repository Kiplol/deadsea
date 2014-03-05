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
 * @param shooter The bullet's shooter
 */
-(void)fireFrom:(DSCharacterSpriteNode*)shooter;

/*!
 * @brief Fire a bullet at a given speed with the instance's parameters for bulletType and colliderType
 * @param shooter The bullet's shooter
 * @param speed The speed at which to fire the bullet
 */
-(void)fireFrom:(DSCharacterSpriteNode*)shooter WithSpeed:(double)speed;

/*!
 * @brief Fire a given bullet.  Only the bullet's position and angle will be mutated.
 * @param bullet The bullet to be fired
 * @param shooter The bullet's shooter
 * @param speed The speed at which to fire the bullet
 */
-(void)fireBullet:(DSBulletSpriteNode*)bullet from:(DSCharacterSpriteNode*)shooter withSpeed:(double)speed;
@end
