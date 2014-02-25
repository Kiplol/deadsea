//
//  DSLightshotBulletSpriteNode.m
//  Dead Sea iOS
//
//  Created by Kip on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSLightshotBulletSpriteNode.h"

@implementation DSLightshotBulletSpriteNode

-(void)fillAtlasDictionary
{
    [super fillAtlasDictionary];
    //Firing
    SKTextureAtlas * hoverAtlas = [SKTextureAtlas atlasNamed:@"LightshotFiring"];
    [_dicAtlases setObject:hoverAtlas forKey:ATLAS_KEY_FIRING];
    //Default
    SKTextureAtlas * firingAtlas = [SKTextureAtlas atlasNamed:@"LightshotDefault"];
    [_dicAtlases setObject:firingAtlas forKey:ATLAS_KEY_DEFAULT];
}

-(SKTexture*)initialTexture
{
    SKTextureAtlas * atlas = [_dicAtlases objectForKey:ATLAS_KEY_FIRING];
    SKTexture * initialTexture = [atlas textureNamed:@"LightshotFiring_0"];
    return initialTexture;
}
@end
