//
//  DSPlayerCharacter.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSPlayerCharacterSpriteNode.h"
#import "DSLightshotBulletSpriteNode.h"
#import "DSPlayer.h"
#import "DSEnemySpriteNode.h"

#define MAX_COMBO_TIME 1.2

@interface DSPlayerCharacterSpriteNode (private)

@end

@implementation DSPlayerCharacterSpriteNode
@synthesize comboCountDown = _comboCountDown;
@synthesize combo = _combo;
@synthesize alive = _alive;
-(id)init
{
    if((self = [super init]))
    {
        self.fireRate = 10;
        _comboStartTime = 0;
        _alive = YES;
        self.physicsBody.categoryBitMask = DSColliderTypePlayer;
    }
    return self;
}

-(void)reset
{
    [super reset];
    _alive = YES;
}

-(void)addBulletEmitter:(DSBulletEmitter *)emitter
{
    [super addBulletEmitter:emitter];
    emitter.bulletType = factoryBulletTypeLightshot;
    emitter.colliderType = DSColliderTypeEnemy;
    emitter.bulletSpeed = 30.0;
    emitter.zRotation = M_PI_2;
}
#pragma mark - Combo
-(void)rechargeComboCountdown
{
    _comboStartTime = CACurrentMediaTime();
}

-(void)countDownComboAtTime:(CFTimeInterval)currentTime
{
    CFTimeInterval comboDeltaTime = currentTime - _comboStartTime;
    _comboCountDown = (MAX_COMBO_TIME - comboDeltaTime) / MAX_COMBO_TIME;
    _comboCountDown = MAX(_comboCountDown, 0);
    if(_comboCountDown <= 0)
    {
        [self expireCombo];
    }
}

-(int)expireCombo
{
    int lastCombo = _combo;
    _combo = 0;
    return lastCombo;
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
-(void)damageAnimation
{
    [super damageAnimation];
}
-(NSString*)destructionSound
{
    return @"FX097.wav";
}
#pragma mark - DSSpriteNode
-(void)fillAtlasDictionary
{
    [super fillAtlasDictionary];
    //Hover
    SKTextureAtlas * hoverAtlas = [SKTextureAtlas atlasNamed:@"PlayerShipHover"];
    [_dicAtlases setObject:hoverAtlas forKey:ATLAS_KEY_DEFAULT];
}

-(SKTexture*)initialTexture
{
    SKTextureAtlas * initialAtlas = [_dicAtlases objectForKey:ATLAS_KEY_DEFAULT];
    SKTexture * initialTexture = [initialAtlas textureNamed:@"PlayerShipHover_0"];
    return initialTexture;
}

#pragma mark - DSDestroyerDelegate
-(void)didDamageCharacter:(DSCharacterSpriteNode*)character
{
    [self rechargeComboCountdown];
    _combo++;
}
-(void)didDestroyCharacter:(DSCharacterSpriteNode*)character
{
    if([character isKindOfClass:[DSEnemySpriteNode class]])
    {
        DSEnemySpriteNode * enemy = (DSEnemySpriteNode*)character;
        [DSPlayer sharedPlayer].score += enemy.pointsForDestroying;
        [self addBulletEmitter];
    }
}

#pragma mark - DSDestroyableDelegate
-(void)didTakeDamagefromCharacter:(DSCharacterSpriteNode*)character
{
    [super didTakeDamagefromCharacter:character];
    [self expireCombo];
}
-(void)didGetDestroyedByCharacter:(DSCharacterSpriteNode*)character
{
    _alive = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_PLAYER_WILL_DIE object:self];
    [super didGetDestroyedByCharacter:character];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_PLAYER_DID_DIE object:self];

}
#pragma mark - private
-(CGFloat)radiusForPhysicsBody
{
    return 2.0f;
}

@end
