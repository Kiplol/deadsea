//
//  DSLevel.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/8/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSCharacterSpawner.h"

@interface DSLevel : NSObject  {
    DSSpawnWaveArray * _spawnWaves;
    SKNode * _parentNode;
    DSCharacterSpawner * _characterSpawner;
}

-(id)initWithPlistName:(NSString*)plist andParentNode:(SKNode*)parentNode;
-(void)beginLevel;
@end
