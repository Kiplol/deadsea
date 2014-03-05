//
//  DSEnemySpriteNode.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSEnemySpriteNode.h"

@implementation DSEnemySpriteNode
-(id)init
{
    if((self = [super init]))
    {
        _bulletEmitter.zRotation = M_PI_2;
        _bulletEmitter.bulletType = factoryBulletTypeBallshot;
        _bulletEmitter.bulletSpeed = 1.0;
        self.fireRate = 2;
        self.physicsBody.categoryBitMask = DSColliderTypeEnemy;
        self.zRotation = M_PI;
        
        _shotsThisBurst = 0;
    }
    return self;
}
@end
