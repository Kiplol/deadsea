//
//  DSLevelParser.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/8/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DSLevelParser : NSObject
+(DSSpawnWaveArray*)waveInfoFromPlist:(NSString*)plistName;
+(DSSpawnWaveArray*)waveInfoFromData:(NSArray*)waveData;
+(NSString*)backgroundNameFromPlist:(NSString*)plistName;
+(NSString*)musicNameFromPlist:(NSString*)plistName;
@end
