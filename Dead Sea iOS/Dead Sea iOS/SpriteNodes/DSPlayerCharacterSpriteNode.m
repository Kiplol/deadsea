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
-(id)init
{
    if((self = [super init]))
    {
        self.fireRate = 10;
        _comboStartTime = 0;
        self.physicsBody.categoryBitMask = DSColliderTypePlayer;
    }
    return self;
}

-(void)rechargeCombo
{
    _comboStartTime = CACurrentMediaTime();
    _comboCountDown = MAX_COMBO_TIME;
}

-(void)countDownComboAtTime:(CFTimeInterval)currentTime
{
    CFTimeInterval comboDeltaTime = currentTime - _comboStartTime;
    _comboCountDown = (MAX_COMBO_TIME - comboDeltaTime) / MAX_COMBO_TIME;
    _comboCountDown = MAX(_comboCountDown, 0);
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
    DSBulletSpriteNode * bullet = [[BulletFactory sharedFactory] bulletOfType:factoryBulletTypeLightshot];
    bullet.physicsBody.contactTestBitMask = DSColliderTypeEnemy;
    bullet.speedVector = CGPointMake(0.0f, 10.0f);
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

#pragma mark - DSDestroyerDelegate
-(void)didDamageCharacter:(DSCharacterSpriteNode*)character
{
    [self rechargeCombo];
}
-(void)didDestroyCharacter:(DSCharacterSpriteNode*)character
{
    
}
@end
