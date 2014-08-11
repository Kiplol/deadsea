//
//  DSLevel.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/8/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSLevel.h"
#import "DSLevelParser.h"

@implementation DSLevel

-(id)initWithPlistName:(NSString*)plist andParentNode:(SKNode*)parentNode
{
    if((self = [super init]))
    {
        _spawnWaves = [DSLevelParser waveInfoFromPlist:plist];
        _parentNode = parentNode;
        _characterSpawner = [[DSCharacterSpawner alloc] initWithSpawnWaves:_spawnWaves andParentNode:parentNode];
        self.background = [[DSScrollingBackground alloc] initWithImageNamed:[DSLevelParser backgroundNameFromPlist:plist]];
    }
    return self;
}
-(void)beginLevel
{
    [_characterSpawner run];
    [_background startScrolling];
}

@end
