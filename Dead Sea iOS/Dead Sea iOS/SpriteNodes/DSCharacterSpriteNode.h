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
    BOOL _angularFollowPlayer;
    double _angularFollowRestTime;
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

/*!
 * @brief Begin rotating to face the player
 */
-(void)startAngularFollowPlayer;
/*!
 * @brief Begin rotating to face the player, but stop rotating every given number of seconds for a rest
 * @param seconds Number of seconds to rotate before taking a rest
 */
-(void)startAngularFollowPlayerWithRestTimeEvery:(double)seconds;
/*!
 * @Stop rotating to face the player
 */
-(void)stopAngularFollowPlayer;

-(void)flyInFrom:(CGPoint)fromPoint to:(CGPoint)toPoint overDuration:(double)dur completion:(void (^)())completion;
@end
