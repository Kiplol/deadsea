//
//  DSSubBossSpriteNode.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 9/28/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSubBossSpriteNode.h"

#define ATLAS_KEY_OPEN_MOUTH @"atlasKeyOpenMouth"
#define ATLAS_KEY_CLOSE_MOUTH @"atlasKeyCloseMouth"

@interface DSSubBossSpriteNode ()
@property (nonatomic, readwrite) BOOL firingMainCannon;
-(SKAction*)fireMainCannonAction;
@end

@implementation DSSubBossSpriteNode

-(id)init
{
    if((self = [super init]))
    {
        self.timeBetweenBursts = 1.0;
        self.shotsPerBurst = 10;
        self.fireRate = 29.0;
        DSBulletEmitter * firstEmitter = _bulletEmitters[0];
        firstEmitter.bulletSpeed = 3;
        
        self.mainCannonEmitters = [[NSMutableArray alloc] initWithCapacity:4];
        for(int i = 0; i < 4; i++)
        {
            DSBulletEmitter * emitter = [[DSBulletEmitter alloc] init];
            emitter.bulletSpeed = 3;
            [self.mainCannonEmitters addObject:emitter];
            [self addBulletEmitter:emitter];
        }
    }
    return self;
}

-(void)enterPlay
{
//    [super enterPlay];
    self.zRotation = M_PI;
    [self stopRotatingTowardsPlayer];
    [self stopFiring];
    [self fireMainCannon];
}

-(void)rotateTowardsPlayer
{
    //Nothing
}

-(void)positionBulletEmitters
{
    [super positionBulletEmitters];
    for(DSBulletEmitter * bulletEmitter in self.mainCannonEmitters)
    {
        bulletEmitter.position = CGPointMake(bulletEmitter.position.x, self.size.height * 0.5);
    }
}

-(void)fillAtlasDictionary
{
    [super fillAtlasDictionary];
    //Hover
    SKTextureAtlas * hoverAtlas = [SKTextureAtlas atlasNamed:@"SubBossHover"];
    [_dicAtlases setObject:hoverAtlas forKey:ATLAS_KEY_DEFAULT];
    SKTextureAtlas * openMouthAtlas = [SKTextureAtlas atlasNamed:@"SubBossOpenMouth"];
    [_dicAtlases setObject:openMouthAtlas forKey:ATLAS_KEY_OPEN_MOUTH];
    SKTextureAtlas * closeMouthAtlas = [SKTextureAtlas atlasNamed:@"SubBossCloseMouth"];
    [_dicAtlases setObject:closeMouthAtlas forKey:ATLAS_KEY_CLOSE_MOUTH];
}

-(SKTexture*)initialTexture
{
    SKTextureAtlas * atlas = [_dicAtlases objectForKey:ATLAS_KEY_DEFAULT];
    SKTexture * initialTexture = [atlas textureNamed:@"SubBossHover_0"];
    return initialTexture;
}

#pragma mark -
-(void)didTakeDamagefromCharacter:(DSCharacterSpriteNode *)character
{
    [super didTakeDamagefromCharacter:character];
    [self fireMainCannon];
}
#pragma mark -
	
-(void)fireMainCannon
{
    if(!self.firingMainCannon)
    {
        [self removeActionForKey:ACTION_NAME_CURRENT_KEYFRAME_ANIMATION];
        SKAction * resetAction = [SKAction animateWithTextureAtlas:[_dicAtlases objectForKey:ATLAS_KEY_DEFAULT] timePerFrame:1.0/15.0 resize:NO restore:NO];
        [self runAction:[SKAction sequence:@[[self fireMainCannonAction], [SKAction repeatActionForever:resetAction]]] withKey:ACTION_NAME_CURRENT_KEYFRAME_ANIMATION];
    }
}

-(SKAction*)fireMainCannonAction
{
    SKAction * setFiringAction = [SKAction runBlock:^{
        self.firingMainCannon = YES;
    }];
    SKAction * openMouthAction = [SKAction animateWithTextureAtlas:[_dicAtlases objectForKey:ATLAS_KEY_OPEN_MOUTH] timePerFrame:1.0/15.0 resize:NO restore:NO];
    SKAction * fireOnceAction = [SKAction sequence:@[[SKAction runBlock:^{
        int mainCannonEmittedIdx = arc4random() % self.mainCannonEmitters.count;
        [self fireFromEmitter:self.mainCannonEmitters[mainCannonEmittedIdx]];
    }], [SKAction waitForDuration:0.1]]];
    SKAction * fireALotAction = [SKAction repeatAction:fireOnceAction count:20];
    SKAction * closeMouthAction = [SKAction animateWithTextureAtlas:[_dicAtlases objectForKey:ATLAS_KEY_CLOSE_MOUTH] timePerFrame:1.0/15.0 resize:NO restore:NO];
    SKAction * setNotFiringAction = [SKAction runBlock:^{
        self.firingMainCannon = NO;
    }];
    return [SKAction sequence:@[setFiringAction, openMouthAction, fireALotAction, closeMouthAction, setNotFiringAction]];
}

@end
