//
//  DSCharacter.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSSpriteNode.h"
#import "DSBulletSpriteNode.h"

@interface DSCharacter : NSObject {
    BOOL _bFiring;
}

@property (nonatomic, readwrite) int health;
@property (nonatomic, retain) DSSpriteNode * spriteNode;
/*!
 * @brief Number of times this can fire per second
 */
@property (nonatomic, readwrite) int fireRate;

-(void)fire;
-(void)startFiring;
-(void)stopFiring;

@end
