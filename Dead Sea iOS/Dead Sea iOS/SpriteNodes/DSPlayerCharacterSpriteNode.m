//
//  DSPlayerCharacter.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSPlayerCharacterSpriteNode.h"
#import "DSLightshotBulletSpriteNode.h"

#define MAX_COMBO_TIME 1.2

@interface DSPlayerCharacterSpriteNode (private)

@end

@implementation DSPlayerCharacterSpriteNode
@synthesize comboCountDown = _comboCountDown;
@synthesize combo = _combo;
-(id)init
{
    if((self = [super init]))
    {
        self.fireRate = 10;
        _comboStartTime = 0;
        self.physicsBody.categoryBitMask = DSColliderTypePlayer;
        
        SKTextureAtlas * defaultAtlas = [_dicAtlases objectForKey:@"atlasKeyDefault"];
        NSArray * names = defaultAtlas.textureNames;
        NSMutableArray * textures = [NSMutableArray arrayWithCapacity:names.count];
        for(int i = 0; i < names.count; i++)
        {
            SKTexture * texture = [defaultAtlas textureNamed:[names objectAtIndex:i]];
            [textures addObject:texture];
        }
        SKAction * animAction = [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:1.0/15.0 resize:NO restore:NO]];
        [self runAction:animAction];
    }
    return self;
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
-(void)fire
{
    [super fire];
}
-(DSBulletSpriteNode*)nextBullet
{
    DSBulletSpriteNode * bullet = [[BulletFactory sharedFactory] bulletOfType:factoryBulletTypeLightshot];
    bullet.physicsBody.contactTestBitMask = DSColliderTypeEnemy;
    bullet.speedVector = CGVectorMake(0.0f, 30.0f);
    return bullet;
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
    
}

#pragma mark - DSDestroyableDelegate
-(void)didTakeDamagefromCharacter:(DSCharacterSpriteNode*)character
{
    [super didTakeDamagefromCharacter:character];
    [self expireCombo];
}
-(void)didGetDestroyedByCharacter:(DSCharacterSpriteNode*)character
{
    [super didGetDestroyedByCharacter:character];
}
#pragma mark - private
-(CGFloat)radiusForPhysicsBody
{
    return 2.0f;
}

@end
