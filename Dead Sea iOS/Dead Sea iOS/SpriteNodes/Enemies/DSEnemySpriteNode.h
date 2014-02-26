//
//  DSEnemySpriteNode.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSCharacterSpriteNode.h"

@interface DSEnemySpriteNode : DSCharacterSpriteNode {
    int _shotsThisBurst;
}

@property (nonatomic, readwrite) int shotsPerBurst;
@property (nonatomic, readwrite) double timeBetweenBursts;
@end
