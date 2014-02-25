//
//  BulletFactor.h
//  Dead Sea iOS
//
//  Created by Kip on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBulletSpriteNode.h"

typedef enum {factoryBulletTypeLightshot = 0,
                factoryBulletTypeUnknown} factoryBulletType;

@interface BulletFactory : NSObject {
    NSMutableDictionary * _bulletArrays;
}

+(BulletFactory*)sharedFactory;
-(DSBulletSpriteNode*)bulletOfType:(factoryBulletType)bulletType;
-(void)returnBulletForReuse:(DSBulletSpriteNode*)bullet;
@end
