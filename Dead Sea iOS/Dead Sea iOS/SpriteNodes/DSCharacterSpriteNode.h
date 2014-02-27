//
//  DSCharacterSpriteNode.h
//  Dead Sea iOS
//
//  Created by Kip on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSpriteNode.h"
#import "BulletFactory.h"
#import "DSDestroyerDestroyableDelegate.h"

@class DSBulletSpriteNode;
@interface DSCharacterSpriteNode : DSSpriteNode <DSDestroyableDelegate>{
    int _health;
    BOOL _bFiring;
    int _shotsThisBurst;
}
@property (nonatomic, readwrite) int health;
@property (nonatomic, retain) DSSpriteNode * spriteNode;
/*!
 * @brief Number of times this can fire per second
 */
@property (nonatomic, readwrite) int fireRate;
@property (nonatomic, readwrite) int shotsPerBurst;
@property (nonatomic, readwrite) double timeBetweenBursts;

/*!
 * @brief Retrieves a bullet from nextBullet, does any prep required, and fires it.
 */
-(void)fire;
-(void)startFiring;
-(void)stopFiring;

/*!
 * @brief returns the next DSBulletSpriteNode which will have fire called immediately
 * @return DSBulletSpriteNode about to be fired
 */
-(DSBulletSpriteNode*)nextBullet;
@end
