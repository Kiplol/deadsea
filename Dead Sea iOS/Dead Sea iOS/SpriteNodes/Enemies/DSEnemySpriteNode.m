//
//  DSEnemySpriteNode.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSEnemySpriteNode.h"

@implementation DSEnemySpriteNode
@synthesize pointsForDestroying = _pointsForDestroying;
-(id)init
{
    if((self = [super init]))
    {
        _bulletEmitter.zRotation = M_PI_2;
        _bulletEmitter.bulletType = factoryBulletTypeBallshot;
        _bulletEmitter.colliderType = DSColliderTypePlayer;
        _bulletEmitter.bulletSpeed = 1.0;
        self.name = NAME_ENEMY;
        self.fireRate = 2;
        self.physicsBody.categoryBitMask = DSColliderTypeEnemy;
        self.zRotation = M_PI;
        
        _shotsThisBurst = 0;
    }
    return self;
}

-(void)flashPointsLabel
{
    [self flashPointsLabelInScene:self.scene];
}
-(void)flashPointsLabelInScene:(SKScene*)scene
{
    NSString * actionKey = @"flashPoints";
    if(!_pointsLabel)
    {
        _pointsLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        [scene addChild:_pointsLabel];
    }
    else
    {
        [_pointsLabel removeActionForKey:actionKey];
    }
    _pointsLabel.text = [NSString stringWithFormat:@"%d", self.pointsForDestroying];
    CGPoint absolutePos = [scene convertPoint:self.position fromNode:self.parent];
    _pointsLabel.position = CGPointMake(absolutePos.x + self.size.width, absolutePos.y + self.size.height + 10.0f);
    _pointsLabel.hidden = NO;
    SKAction * riseAction = [SKAction moveByX:5.0f y:0.0f duration:0.5];
    SKAction * fadeAction = [SKAction fadeAlphaTo:0.0f duration:0.3];
    SKAction * sequence = [SKAction sequence:@[riseAction, fadeAction, [SKAction runBlock:^{
        _pointsLabel.alpha = 1.0f;
        _pointsLabel.hidden = YES;
    }]]];
    [_pointsLabel runAction:sequence withKey:actionKey];
}

#pragma mark - DSDestroyableDelegate
//-(void)didTakeDamagefromCharacter:(DSCharacterSpriteNode*)character
//{
//    [super didTakeDamagefromCharacter:character];
//}
-(void)didGetDestroyedByCharacter:(DSCharacterSpriteNode*)character
{
    [self stopFiring];
    [self stopRotatingTowardsPlayer];
    [super didGetDestroyedByCharacter:character];
    [self flashPointsLabel];
}
@end
