//
//  SKSpriteNode+Utilities.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/4/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "SKNode+Utilities.h"

@implementation SKNode (Utilities)
-(double)absoluteZRotation
{
    double total = 0;
    SKNode * curNode = self;
    while (curNode) {
        total += curNode.zRotation;
        curNode = curNode.parent;
    }
    total = fmod(total, M_PI * 2);
    return total;
}
@end
