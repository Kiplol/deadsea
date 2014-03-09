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
@property (nonatomic, readwrite) CGPoint spawnStartPoint;
@property (nonatomic, readwrite) CGPoint spawnEndPoint;
@property (nonatomic, readwrite) double timeAfterLastSpawnToSpawn;
@property (nonatomic, readwrite) int wave;
@property (nonatomic, readonly) NSMutableDictionary * info;
@end

@interface DSCharacterSpawner : NSObject {
    NSMutableArray * _spawnWaves;
    int _currentWave;
}
@property (nonatomic, readonly) NSMutableArray * spawnWaves;
@property (nonatomic, assign) SKNode * parentNode;
-(id)initWithPlistNamed:(NSString*)plistName andParentNode:(SKNode*)parentNode;
-(void)run;
@end
