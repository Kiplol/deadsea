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
    DSColliderTypePlayerProjectile = 1 << 1,
    DSColliderTypeEnemy = 1 << 2,
    DSColliderTypeEnemyProjectile = 1 << 3
} DSColliderType;

@interface DSSpriteNode : SKSpriteNode {
    NSMutableDictionary * _dicAtlases;
}

-(void)fillAtlasDictionary;
-(SKTexture*)initialTexture;
@end
