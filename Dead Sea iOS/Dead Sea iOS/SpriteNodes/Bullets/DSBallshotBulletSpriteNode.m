//
//  DSBallshotBulletSpriteNode.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSBallshotBulletSpriteNode.h"

@implementation DSBallshotBulletSpriteNode
-(void)fillAtlasDictionary
{
    [super fillAtlasDictionary];
    //Firing
    SKTextureAtlas * hoverAtlas = [SKTextureAtlas atlasNamed:@"BallshotFiring"];
    [_dicAtlases setObject:hoverAtlas forKey:ATLAS_KEY_FIRING];
    //Default
    SKTextureAtlas * firingAtlas = [SKTextureAtlas atlasNamed:@"BallshotDefault"];
    [_dicAtlases setObject:firingAtlas forKey:ATLAS_KEY_DEFAULT];
}

-(SKTexture*)initialTexture
{
    SKTextureAtlas * atlas = [_dicAtlases objectForKey:ATLAS_KEY_FIRING];
    SKTexture * initialTexture = [atlas textureNamed:@"BallshotFiring_0"];
    return initialTexture;
}
@end
