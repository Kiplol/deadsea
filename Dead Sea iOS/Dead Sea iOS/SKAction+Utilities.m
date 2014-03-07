//
//  SKAction+Utilities.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/27/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "SKAction+Utilities.h"

@implementation SKAction (Utilities)
+(SKAction*)animateWithTextureAtlas:(SKTextureAtlas*)atlas timePerFrame:(double)tpf resize:(BOOL)resize restore:(BOOL)restore
{
    NSArray * names = atlas.textureNames;
    NSMutableArray * textures = [NSMutableArray arrayWithCapacity:names.count];
    for(int i = 0; i < names.count; i++)
    {
        SKTexture * texture = [atlas textureNamed:[names objectAtIndex:i]];
        [textures addObject:texture];
    }
    SKAction * animAction = [SKAction animateWithTextures:textures timePerFrame:tpf resize:resize restore:restore];
    return animAction;
}
@end
