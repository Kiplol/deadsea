//
//  DSSmallEnemySpriteNode.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSmallEnemySpriteNode.h"

@implementation DSSmallEnemySpriteNode
-(id)init
{
    if((self = [super init]))
    {
        self.fireRate = 3;
        self.shotsPerBurst = 3;
        self.timeBetweenBursts = 1;
    }
    return self;
}
-(void)fillAtlasDictionary
{
    [super fillAtlasDictionary];
    //Hover
    SKTextureAtlas * hoverAtlas = [SKTextureAtlas atlasNamed:@"SmallEnemyHover"];
    [_dicAtlases setObject:hoverAtlas forKey:ATLAS_KEY_DEFAULT];
}

-(SKTexture*)initialTexture
{
    SKTextureAtlas * atlas = [_dicAtlases objectForKey:ATLAS_KEY_DEFAULT];
    SKTexture * initialTexture = [atlas textureNamed:@"LittleAlienShipHover_0"];
    return initialTexture;
}
@end
