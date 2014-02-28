//
//  SKAction+Utilities.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/27/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKAction (Utilities)
/*!
 * @brief Given a source and destination point, turn towards the destination over a given duration.
 * @param destPoint Point to face towards
 * @param sourcePoint Point from the the angle is calculated
 * @param duration The time span in seconds over which the rotation takes place
 * @param completeion Block to be called upon completion
 */
+(id)rotateTowardsPoint:(CGPoint)destPoint fromPoint:(CGPoint)sourcePoint duration:(double)dur completion:(void (^)())completion;
@end
