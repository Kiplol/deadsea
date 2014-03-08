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

@interface DSCharacterSpawnInfo (private)
-(DSCharacterSpriteNode*)spawnCharacterOfType:(DSCharacterType)type;
-(void)runWithSpawnInfoAtIndex:(int)idx;
@end
@implementation DSCharacterSpawner
@synthesize spawnInfos = _spawnInfos;
-(id)initWithPlistNamed:(NSString*)plistName
{
    if((self = [super init]))
    {
        _spawnInfos = [[NSMutableArray alloc] initWithCapacity:10];
        
        //Test
        DSCharacterSpawnInfo * spawnInfo0 = [[DSCharacterSpawnInfo alloc] init];
        spawnInfo0.wave = 0;
        spawnInfo0.characterType = CharacterTypeSmallEnemy;
        spawnInfo0.timeAfterLastSpawnToSpawn = 1.0;
        [_spawnInfos addObject:spawnInfo0];
        
        DSCharacterSpawnInfo * spawnInfo1 = [[DSCharacterSpawnInfo alloc] init];
        spawnInfo1.wave = 0;
        spawnInfo1.characterType = CharacterTypeSmallEnemy;
        spawnInfo1.timeAfterLastSpawnToSpawn = 0.5;
        [_spawnInfos addObject:spawnInfo1];
        
        DSCharacterSpawnInfo * spawnInfo2 = [[DSCharacterSpawnInfo alloc] init];
        spawnInfo2.wave = 0;
        spawnInfo2.characterType = CharacterTypeSmallEnemy;
        spawnInfo2.timeAfterLastSpawnToSpawn = 2.0;
        [_spawnInfos addObject:spawnInfo2];
        
        DSCharacterSpawnInfo * spawnInfo3 = [[DSCharacterSpawnInfo alloc] init];
        spawnInfo3.wave = 0;
        spawnInfo3.characterType = CharacterTypeSmallEnemy;
        spawnInfo3.timeAfterLastSpawnToSpawn = 0.5;
        [_spawnInfos addObject:spawnInfo3];
        
        DSCharacterSpawnInfo * spawnInfo4 = [[DSCharacterSpawnInfo alloc] init];
        spawnInfo4.wave = 0;
        spawnInfo4.characterType = CharacterTypeSmallEnemy;
        spawnInfo4.timeAfterLastSpawnToSpawn = 0.5;
        [_spawnInfos addObject:spawnInfo4];
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
            [sprite flyInFrom:CGPointMake(0, self.parentNode.frame.size.height) to:CGPointMake(20 + (50 * idx), 300) overDuration:1.0 completion:^{
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