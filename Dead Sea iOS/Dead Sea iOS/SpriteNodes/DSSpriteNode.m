//
//  DSSpriteNode.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSpriteNode.h"

@implementation DSSpriteNode
-(id)init
{
    if((self = [super init]))
    {
        [self fillAtlasDictionary];
        self.texture = [self initialTexture];
        self.size = self.texture.size;
        SKTextureAtlas * defaultAtlas = [_dicAtlases objectForKey:ATLAS_KEY_DEFAULT];
        if(defaultAtlas)
        {
            SKAction * animAction = [SKAction animateWithTextureAtlas:defaultAtlas timePerFrame:1.0/15.0 resize:NO restore:NO];
            [self runAction:animAction];
        }
    }
    return self;
}

-(void)fillAtlasDictionary
{
    if(!_dicAtlases)
    {
        _dicAtlases = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
}

-(SKTexture*)initialTexture
{
    NSLog(@"Must override %s", __PRETTY_FUNCTION__);
    return nil;
}

/*!
 * @brief
 * @note If you have any repeating actions, MAKE SURE TO STOP THEM
 */
-(void)removeFromPlay
{
    [self removeAllActions];
    [self removeAllChildren];
    [self removeFromParent];
}
@end
