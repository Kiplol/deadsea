//
//  DSDestroyerDelegate.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSCharacterSpriteNode;
@protocol DSDestroyerDelegate <NSObject>
@optional
-(void)didDamageCharacter:(DSCharacterSpriteNode*)character;
-(void)didDestroyCharacter:(DSCharacterSpriteNode*)character;
@end

@protocol DSDestroyableDelegate <NSObject>
@optional
-(void)didTakeDamagefromCharacter:(DSCharacterSpriteNode*)character;
-(void)didGetDestroyedByCharacter:(DSCharacterSpriteNode*)character;
@end
