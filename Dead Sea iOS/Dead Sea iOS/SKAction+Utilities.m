//
//  SKAction+Utilities.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/27/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "SKAction+Utilities.h"

@implementation SKAction (Utilities)

+(id)rotateTowardsPoint:(CGPoint)destPoint fromPoint:(CGPoint)sourcePoint duration:(double)dur completion:(void (^)())completion
{
    CGFloat dx = sourcePoint.x - destPoint.x;
    CGFloat dy = sourcePoint.y - destPoint.y;
    double angleToTurn = atan2(dy,dx) + M_PI_2; //We're adding M_PI_2 because we want up to be the normal direction
    SKAction * rotateAction = [SKAction rotateToAngle:angleToTurn duration:dur shortestUnitArc:YES];
    SKAction * waitAction = [SKAction waitForDuration:dur];
    SKAction * completionAction = [SKAction runBlock:completion];
    return [SKAction sequence:@[rotateAction, waitAction, completionAction]];
}
@end
