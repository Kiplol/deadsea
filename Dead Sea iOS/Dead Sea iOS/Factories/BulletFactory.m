//
//  BulletFactor.m
//  Dead Sea iOS
//
//  Created by Kip on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "BulletFactory.h"
#import "DSLightshotBulletSpriteNode.h"
#import "DSBallshotBulletSpriteNode.h"

@interface BulletFactory (private)
-(DSBulletSpriteNode*)createBulletOfType:(factoryBulletType)bulletType;
-(factoryBulletType)typeForBullet:(DSBulletSpriteNode*)bullet;
-(NSMutableArray*)arrayForType:(factoryBulletType)bulletType;
-(NSString*)keyForType:(factoryBulletType)bulletType;
@end
@implementation BulletFactory

+(BulletFactory*)sharedFactory
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[BulletFactory alloc] init];
    });
    return sharedInstance;
}
-(id)init
{
    if((self = [super init]))
    {
        _bulletArrays = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    return self;
}

-(DSBulletSpriteNode*)bulletOfType:(factoryBulletType)bulletType
{
    NSMutableArray * arrBullets = [self arrayForType:bulletType];
    if(arrBullets && arrBullets.count)
    {
        DSBulletSpriteNode * retBullet = [arrBullets objectAtIndex:0];
        [arrBullets removeObject:retBullet];
        return retBullet;
    }
    else
    {
        return [self createBulletOfType:bulletType];
    }
}
-(void)returnBulletForReuse:(DSBulletSpriteNode*)bullet
{
    [bullet.scene removeChildrenInArray:@[bullet]];
    NSMutableArray * arrBullets = [self arrayForType:[self typeForBullet:bullet]];
    [arrBullets addObject:bullet];
}
#pragma mark - Private
-(DSBulletSpriteNode*)createBulletOfType:(factoryBulletType)bulletType
{
    DSBulletSpriteNode * bullet = nil;
    switch (bulletType) {
        case factoryBulletTypeLightshot:
        {
            DSLightshotBulletSpriteNode * lightshot = [[DSLightshotBulletSpriteNode alloc] init];
            bullet = lightshot;
        }
            break;
            
        case factoryBulletTypeBallshot:
        {
            DSBallshotBulletSpriteNode * ballshot = [[DSBallshotBulletSpriteNode alloc] init];
            bullet = ballshot;
        }
            break;
            
        default:
            break;
    }
    return bullet;
}

-(factoryBulletType)typeForBullet:(DSBulletSpriteNode*)bullet
{
    if([bullet isKindOfClass:[DSLightshotBulletSpriteNode class]])
    {
        return factoryBulletTypeLightshot;
    }
    else
    {
        return factoryBulletTypeUnknown;
    }
}

-(NSMutableArray*)arrayForType:(factoryBulletType)bulletType
{
    NSString * key = [self keyForType:bulletType];
    NSMutableArray * arrBullets = [_bulletArrays objectForKey:key];
    if(arrBullets == nil)
    {
        arrBullets = [NSMutableArray arrayWithCapacity:10];
        [_bulletArrays setObject:arrBullets forKey:key];
    }
    return arrBullets;
}

-(NSString*)keyForType:(factoryBulletType)bulletType
{
    NSString * key = [NSString stringWithFormat:@"%d", bulletType];
    return key;
}
@end
