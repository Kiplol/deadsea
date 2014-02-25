//
//  DSCharacterSpriteNode.h
//  Dead Sea iOS
//
//  Created by Kip on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSpriteNode.h"

@interface DSCharacterSpriteNode : DSSpriteNode {
    int _health;
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