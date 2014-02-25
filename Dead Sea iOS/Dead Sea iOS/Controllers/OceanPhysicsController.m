//
//  OceanPhysicsController.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "OceanPhysicsController.h"

@implementation OceanPhysicsController

+(OceanPhysicsController*)sharedController
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[OceanPhysicsController alloc] init];
    });
    return sharedInstance;
}
-(void)addPhysicsObject:(NSObject<DSOceanPhysicsDelegate>*)physicsObject
{
    
}
-(void)clearPhysicsObjects
{
    
}
-(void)applyCurrentDirection:(CGPoint)dir forDuration:(double)duration
{
    
}
@end
