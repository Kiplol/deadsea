//
//  DSPlayerCharacter.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSPlayerCharacterSpriteNode.h"
#import "DSLightshotBulletSpriteNode.h"

#define ATLAS_KEY_HOVER @"atlasKeyHover"

@interface DSPlayerCharacterSpriteNode (private)

@end

@implementation DSPlayerCharacterSpriteNode
@synthesize comboCountDown = _comboCountDown;
-(id)init
{
    if((self = [super init]))
    {
        self.fireRate = 10;
        _comboStartTime = 0;
        self.physicsBody.categoryBitMask = DSColliderTypePlayer;
        self.physicsBody.contactTestBitMask = DSColliderTypeEnemyProjectile;
    }
    return self;
}

-(void)rechargeCombo
{
    _comboStartTime = [[NSDate date] timeIntervalSince1970];
    _comboCountDown = 1.0f;
}

#pragma mark - Animation Methods
-(void)leanLeft
{
    
}
-(void)leanRight
{
    
}
-(void)leanForDelta:(CGPoint)deltaVector
{
    
}

#pragma mark - DSCharacterSpriteNode
-(DSBulletSpriteNode*)nextBullet
{
    DSBulletSpriteNode * bullet = [[BulletFactory sharedFactory] bulletOfType:factoryBulletTypeLightshot];
    bullet.physicsBody.categoryBitMask = DSColliderTypePlayerProjectile;
    bullet.physicsBody.contactTestBitMask = DSColliderTypeEnemy;
    return bullet;
}
#pragma mark - DSSpriteNode
-(void)fillAtlasDictionary
{
    [super fillAtlasDictionary];
    //Hover
    SKTextureAtlas * hoverAtlas = [SKTextureAtlas atlasNamed:@"PlayerShipHover"];
    [_dicAtlases setObject:hoverAtlas forKey:ATLAS_KEY_HOVER];
}

-(SKTexture*)initialTexture
{
    SKTextureAtlas * initialAtlas = [_dicAtlases objectForKey:ATLAS_KEY_HOVER];
    SKTexture * initialTexture = [initialAtlas textureNamed:@"PlayerShipHover_0"];
    return initialTexture;
}
@end
