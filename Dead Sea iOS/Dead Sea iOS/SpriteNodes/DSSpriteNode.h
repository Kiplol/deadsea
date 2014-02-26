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

@interface DSSpriteNode : SKSpriteNode {
    NSMutableDictionary * _dicAtlases;
}

-(void)fillAtlasDictionary;
-(SKTexture*)initialTexture;
-(void)faceTowardsPoint:(CGPoint)point maximumRotation:(double)angleInRadians duration:(double)dur completion:(void (^)())completion;
@end
