//
//  DSPlayerCharacter.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSPlayerCharacterSpriteNode.h"
#import "DSDestroyerDestroyableDelegate.h"

@interface DSPlayer : NSObject{

}
@property (nonatomic, retain) DSPlayerCharacterSpriteNode * spriteNode;

+(DSPlayer*)sharedPlayer;
@end
