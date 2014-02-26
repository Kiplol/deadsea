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
        self.fireRate = 2;
        self.physicsBody.categoryBitMask = DSColliderTypeEnemy;
        self.zRotation = M_PI;
        
        _shotsThisBurst = 0;
    }
    return self;
}

-(void)fire
{
    [super fire];
    
    _shotsThisBurst ++;
    //Do it again
    if(_bFiring && self.fireRate > 0)
    {
        double delayInSeconds = 1.0/self.fireRate;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(_bFiring && self.fireRate > 0)
            {
                [self fire];
            }
        });
    }
}

-(DSBulletSpriteNode*)nextBullet
{
    DSBulletSpriteNode * bullet = [[BulletFactory sharedFactory] bulletOfType:factoryBulletTypeBallshot];
    bullet.physicsBody.contactTestBitMask = DSColliderTypePlayer;
    CGFloat vx =  0 - sinf(self.zRotation);
    CGFloat vy = cosf(self.zRotation);
    CGFloat denom = MAX(fabs(vx), fabs(vy));
    CGFloat unitVx = vx / denom;
    CGFloat unitVy = vy / denom;
    bullet.speedVector = CGPointMake(unitVx * 3, unitVy * 3);
    return bullet;
}
@end
