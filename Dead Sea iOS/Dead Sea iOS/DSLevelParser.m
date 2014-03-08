//
//  DSLevelParser.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/8/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSLevelParser.h"
#import "DSCharacterSpawner.h"

@interface DSLevelParser (private)
+(DSCharacterSpawnInfo*)spawnInfoFromDict:(NSDictionary*)dict;
@end

@implementation DSLevelParser
+(NSMutableArray*)levelFromPlist:(NSString*)plistName
{
    NSArray * dics = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
    NSMutableArray * spawnInfos = [NSMutableArray arrayWithCapacity:dics.count];
    for(NSDictionary * thisDic in dics)
    {
        [spawnInfos addObject:[DSLevelParser spawnInfoFromDict:thisDic]];
    }
    return spawnInfos;
}

#pragma mark - private
+(DSCharacterSpawnInfo*)spawnInfoFromDict:(NSDictionary *)dict
{
    DSCharacterSpawnInfo * result = nil;
    if(dict)
    {
        result = [[DSCharacterSpawnInfo alloc] init];
        result.characterType = [[dict objectForKey:@"characterType"] intValue];
        result.wave = [[dict objectForKey:@"wave"] intValue];
        result.timeAfterLastSpawnToSpawn = [[dict objectForKey:@"timeAfterLastSpawnToSpawn"] doubleValue];
        [result.info setDictionary:[dict objectForKey:@"info"]];
        NSDictionary * startPointDict = [dict objectForKey:@"spawnStartPoint"];
        NSDictionary * endPointDict = [dict objectForKey:@"spawnEndPoint"];
        result.spawnStartPoint = CGPointMake([[startPointDict objectForKey:@"x"] floatValue], [[startPointDict objectForKey:@"y"] floatValue]);
        result.spawnEndPoint = CGPointMake([[endPointDict objectForKey:@"x"] floatValue], [[endPointDict objectForKey:@"y"] floatValue]);
    }
    return result;
}
@end
