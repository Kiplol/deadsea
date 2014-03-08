//
//  DSCharacterSpawner.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/7/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSCharacterSpawner.h"
#import "DSCharacterSpriteNode.h"
#import "DSSmallEnemySpriteNode.h"
#import "DSPlayer.h"
#import "DSPlayerCharacterSpriteNode.h"
#import "DSLevelParser.h"

@interface DSCharacterSpawnInfo (private)
-(DSCharacterSpriteNode*)spawnCharacterOfType:(DSCharacterType)type;
-(void)runWithSpawnInfoAtIndex:(int)idx;
@end
@implementation DSCharacterSpawner
@synthesize spawnInfos = _spawnInfos;
-(id)initWithPlistNamed:(NSString*)plistName andParentNode:(SKNode *)parentNode
{
    if((self = [super init]))
    {
        self.parentNode = parentNode;
        _spawnInfos = [DSLevelParser levelFromPlist:plistName];
    }
    return self;
}

-(void)run
{
    [self runWithSpawnInfoAtIndex:0];
}
#pragma mark - private
-(DSCharacterSpriteNode*)spawnCharacterOfType:(DSCharacterType)type
{
    DSCharacterSpriteNode* character = nil;
    switch (type) {
        case CharacterTypeSmallEnemy:
        {
            DSSmallEnemySpriteNode * smallEnemy = [[DSSmallEnemySpriteNode alloc] init];
            character = smallEnemy;
        }
            break;
        case CharacterTypeNone:
        default:
            break;
    }
    return character;
}

-(void)runWithSpawnInfoAtIndex:(int)idx
{
    if(idx >= _spawnInfos.count)
    {
        NSLog(@"Completed spawns");
        return;
    }

    DSCharacterSpawnInfo * spawnInfo = [_spawnInfos objectAtIndex:idx];
    DSCharacterSpriteNode * sprite = [self spawnCharacterOfType:spawnInfo.characterType];
    if(sprite)
    {
        if(self.parentNode)
        {
            [self.parentNode addChild:sprite];
            [sprite flyInFrom:spawnInfo.spawnStartPoint to:spawnInfo.spawnEndPoint overDuration:1.0 completion:^{
                //Completion
                if([DSPlayer sharedPlayer].spriteNode.alive)
                {
                    [sprite startRotatingTowardsPlayerWithRestTimeEvery:2.0];
                    [sprite startFiring];
                }
            }];
        }
    }
    
    //Next spawn
    if(_spawnInfos.count > (idx + 1))
    {
        DSCharacterSpawnInfo * nextSpawn = [_spawnInfos objectAtIndex:(idx + 1)];
        double delayInSeconds = nextSpawn.timeAfterLastSpawnToSpawn;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self runWithSpawnInfoAtIndex:(idx + 1)];
        });
    }
    else
    {
        NSLog(@"Completed spawns");
    }
}

@end

@implementation DSCharacterSpawnInfo
-(NSString*)description
{
    NSString * desc = [NSString stringWithFormat:@"%@ characterType:%d timeAfterLastSpawnToSpawn:%f wave:%d info:%@", [super description], self.characterType, self.timeAfterLastSpawnToSpawn, self.wave, self.info];
    return desc;
}
@end