//
//  DSPlayerCharacter.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSPlayerCharacterSpriteNode.h"

#define ATLAS_KEY_HOVER @"atlasKeyHover"

@interface DSPlayerCharacterSpriteNode (private)
-(void)fillAtlasDictionary;
-(SKTexture*)initialTexture;
@end

@implementation DSPlayerCharacterSpriteNode
-(id)init
{
    if((self = [super init]))
    {
        [self fillAtlasDictionary];
        self.texture = [self initialTexture];
    }
    return self;
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

#pragma mark - private
-(void)fillAtlasDictionary
{
    if(!_dicAtlases)
    {
        _dicAtlases = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    //Hover
    SKTextureAtlas * hoverAtlas = [SKTextureAtlas atlasNamed:@"Hover"];
    [_dicAtlases setObject:hoverAtlas forKey:ATLAS_KEY_HOVER];
}

-(SKTexture*)initialTexture
{
    SKTextureAtlas * initialAtlas = [_dicAtlases objectForKey:ATLAS_KEY_HOVER];
    SKTexture * initialTexture = [initialAtlas textureNamed:@"PlayerShipHover_0"];
    return initialTexture;
}
@end
