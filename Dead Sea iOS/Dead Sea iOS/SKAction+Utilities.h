//
//  SKAction+Utilities.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/27/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class SKTextureAtlas;
@interface SKAction (Utilities)
+(SKAction*)animateWithTextureAtlas:(SKTextureAtlas*)atlas timePerFrame:(double)tpf resize:(BOOL)resize restore:(BOOL)restore;
@end
