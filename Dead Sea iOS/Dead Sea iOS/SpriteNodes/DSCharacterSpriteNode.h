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
#import "DSBulletEmitter.h"

#define ACTION_NAME_DAMAGE_ANIMATION @"actionNameDamageAnimation"
#define ACTION_NAME_DESTROY_ANIMATION @"actionNameDestroyAnimation"

@class DSBulletSpriteNode;
@interface DSCharacterSpriteNode : DSSpriteNode <DSDestroyableDelegate>{
    int _health;
    BOOL _bFiring;
    int _shotsThisBurst;
    BOOL _rotateTowardsPlayer;
    double _rotateTowardsPlayerRestTime;
    DSBulletEmitter * _bulletEmitter;
}
@property (nonatomic, readwrite) int health;
@property (nonatomic, retain) DSSpriteNode * spriteNode;
/*!
 * @brief Number of shots fired per second
 */
@property (nonatomic, readwrite) double fireRate;
/*!
 * @brief Number of shots that make up one burst
 */
@property (nonatomic, readwrite) int shotsPerBurst;
/*!
 * @brief Seconds between each burst of shots
 */
@property (nonatomic, readwrite) double timeBetweenBursts;

/*!
 * @brief Tells the bulletEmitter to fire with the this character's zRotation
 */
-(void)fire;
-(void)startFiring;
-(void)stopFiring;


/*!
 * @brief Begin rotating to face the player
 */
-(void)startRotatingTowardsPlayer;
/*!
 * @brief Begin rotating to face the player, but stop rotating every given number of seconds for a rest
 * @param seconds Number of seconds to rotate before taking a rest
 */
-(void)startRotatingTowardsPlayerWithRestTimeEvery:(double)seconds;
/*!
 * @brief Stop rotating to face the player
 */
-(void)stopRotatingTowardsPlayer;

/*!
 * @brief Translate from one point to another and ease out over a given duration
 * @param fromPoint Point to fly from
 * @param toPoint Point to fly to
 * @param dur Duration of movement in seconds
 * @param completion Block to be run upon completion
 */
-(void)flyInFrom:(CGPoint)fromPoint to:(CGPoint)toPoint overDuration:(double)dur completion:(void (^)())completion;

-(SKAction*)damageAnimationAction;
-(void)damageAnimation;
-(SKAction*)destroyAnimationAction;
-(void)destroyAnimation;
-(void)destroyAnimationAndRemove;
@end
