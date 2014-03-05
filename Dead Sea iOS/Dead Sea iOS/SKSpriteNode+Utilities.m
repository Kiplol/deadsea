//
//  SKSpriteNode+Utilities.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/4/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "SKSpriteNode+Utilities.h"

@implementation SKSpriteNode (Utilities)
-(double)absoluteZRotation
{
    double total = 0;
    SKNode * curNode = self;
    while (curNode) {
        total += curNode.zRotation;
        curNode = curNode.parent;
    }
    return total;
}
@end
