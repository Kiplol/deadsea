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
    }
    return self;
}
@end