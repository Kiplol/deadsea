//
//  DSPlayerCharacter.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSPlayer.h"
#import "DSPlayerCharacterSpriteNode.h"

@implementation DSPlayer
+(DSPlayer*)sharedPlayer
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[DSPlayer alloc] init];
    });
    return sharedInstance;
}

-(id)init
{
    if((self = [super init]))
    {
        self.spriteNode = [[DSPlayerCharacterSpriteNode alloc] init];
        self.lives = 3;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillDie) name:NOTIF_PLAYER_WILL_DIE object:nil];
    }
    return self;
}

-(void)playerWillDie
{
    _lives--;
}
@end
