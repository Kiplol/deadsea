//
//  DSCharacterSpawner.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/7/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CharacterTypeNone = 0,
    CharacterTypeSmallEnemy,
} DSCharacterType;

@interface DSCharacterSpawnInfo : NSObject {
    
}
@property (nonatomic, readwrite) DSCharacterType characterType;
@property (nonatomic, readwrite) double timeAfterLastSpawnToSpawn;
@property (nonatomic, readwrite) int wave;
@property (nonatomic, readonly) NSMutableDictionary * info;
@end

@interface DSCharacterSpawner : NSObject {
    NSMutableArray * _spawnInfos;
}
@property (nonatomic, readonly) NSMutableArray * spawnInfos;
@property (nonatomic, assign) SKNode * parentNode;
-(id)initWithPlistNamed:(NSString*)plistName;
-(void)run;
@end
