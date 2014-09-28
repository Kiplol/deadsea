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
    }
    return self;
}

-(void)enterPlay
{
    [super enterPlay];
    [self stopRotatingTowardsPlayer];
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

@end
