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

#define KEY_PATH_HEALTH @"health"

@interface DSCharacterSpawnInfo (private)
-(DSCharacterSpriteNode*)spawnCharacterOfType:(DSCharacterType)type;
-(void)runWithSpawnInfoAtIndex:(int)idx ofWave:(int)wave;
-(BOOL)characterAtIndex:(int)index isFinalCharacterOfWave:(int)waveIdx;
@end
@implementation DSCharacterSpawner
@synthesize spawnWaves = _spawnWaves;
-(id)initWithPlistNamed:(NSString*)plistName andParentNode:(SKNode *)parentNode
{
    if((self = [super init]))
    {
        self.parentNode = parentNode;
        _spawnWaves = [DSLevelParser levelFromPlist:plistName];
    }
    return self;
}

-(void)run
{
    [self runWithSpawnInfoAtIndex:0 ofWave:0];
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

-(void)runWithSpawnInfoAtIndex:(int)idx ofWave:(int)waveIdx
{
    if(waveIdx >= _spawnWaves.count)
    {
        NSLog(@"Completed spawns");
        return;
    }
    _currentWave = waveIdx;
    NSArray * wave = [_spawnWaves objectAtIndex:waveIdx];

    BOOL isFinalCharOfWave = [self characterAtIndex:idx isFinalCharacterOfWave:waveIdx];
    DSCharacterSpawnInfo * spawnInfo = [wave objectAtIndex:idx];
    DSCharacterSpriteNode * sprite = [self spawnCharacterOfType:spawnInfo.characterType];
    if(sprite)
    {
        if(self.parentNode)
        {
            if(isFinalCharOfWave)
            {
                //Observe the health of the last character of the wave
                [sprite addObserver:self forKeyPath:KEY_PATH_HEALTH options:NSKeyValueObservingOptionNew context:NULL];
            }
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
    DSCharacterSpawnInfo * nextSpawn = nil;
    if(isFinalCharOfWave)
    {
        //This wave is over
        if(_spawnWaves.count > (waveIdx + 1))
        {
            //There is another wave
#warning First wait until last enemy was killed
//            [self runWithSpawnInfoAtIndex:0 ofWave:(waveIdx + 1)];
        }
        else
        {
            //This was the final wave
        }
    }
    else
    {
        if(wave.count > (idx + 1))
        {
            nextSpawn = [wave objectAtIndex:(idx + 1)];
        }
    }
    if(nextSpawn)
    {
        double delayInSeconds = nextSpawn.timeAfterLastSpawnToSpawn;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self runWithSpawnInfoAtIndex:(idx + 1) ofWave:waveIdx];
        });
    }
}

-(BOOL)characterAtIndex:(int)index isFinalCharacterOfWave:(int)waveIdx
{
    if(waveIdx >= _spawnWaves.count)
    {
        return YES;
    }
    NSArray * thisWave = [_spawnWaves objectAtIndex:waveIdx];
    if(index == (thisWave.count - 1))
    {
        return YES;
    }
    return NO;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:KEY_PATH_HEALTH])
    {
        DSCharacterSpriteNode * character = (DSCharacterSpriteNode*)object;
        if(character.health <= 0)
        {
            //The last character of the wave has been killed
            [character removeObserver:self forKeyPath:KEY_PATH_HEALTH];
            NSLog(@"Wave %d complete", _currentWave);
            if(_spawnWaves.count > (_currentWave + 1))
            {
                [self runWithSpawnInfoAtIndex:0 ofWave:(_currentWave + 1)];
            }
            else
            {
                NSLog(@"Final wave complete");
            }
        }
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