//
//  DSSubBossSpriteNode.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 9/28/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSEnemySpriteNode.h"

@interface DSSubBossSpriteNode : DSEnemySpriteNode
@property (nonatomic, strong) NSMutableArray * mainCannonEmitters;
@property (nonatomic, readonly) BOOL firingMainCannon;

-(void)fireMainCannon;

@end
