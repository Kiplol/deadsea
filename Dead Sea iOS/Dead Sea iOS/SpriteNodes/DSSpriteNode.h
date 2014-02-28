//
//  DSSpriteNode.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
    DSColliderTypeNone = 0,
    DSColliderTypePlayer = 1,
    DSColliderTypeEnemy = 1 << 1,
    DSColliderTypeProjectile = 1 << 2
} DSColliderType;

#define ATLAS_KEY_DEFAULT @"atlasKeyDefault"

@interface DSSpriteNode : SKSpriteNode {
    NSMutableDictionary * _dicAtlases;
}

/*!
 * @brief Called during init, this method dills _dicAtlases with SKTextureAtlases.
 * @note It is recommended that you override this method in any subclasses.
 */
-(void)fillAtlasDictionary;

/*!
 * @brief Called during init, this method returns the SKTexture that will be initially assigned to the sprite
 * @return SKTexture* Texture to be applied initially
 * @note It is recommended that you override this method in any subclasses.
 */
-(SKTexture*)initialTexture;
@end
