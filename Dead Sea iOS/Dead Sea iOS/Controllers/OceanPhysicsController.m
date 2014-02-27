//
//  OceanPhysicsController.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "OceanPhysicsController.h"

@implementation OceanPhysicsController
@synthesize physicsObjects = _arrPhysicsObjects;

+(OceanPhysicsController*)sharedController
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[OceanPhysicsController alloc] init];
    });
    return sharedInstance;
}
-(id)init
{
    if((self = [super init]))
    {
        _currentDirection = CGPointZero;
        _arrPhysicsObjects = [NSMutableArray arrayWithCapacity:10];
        _toAdd = [NSMutableArray arrayWithCapacity:10];
        _toRemove = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}
-(void)addPhysicsObject:(NSObject<DSOceanPhysicsDelegate>*)physicsObject
{
    [_toAdd addObject:physicsObject];
}
-(void)removePhysicsObject:(NSObject<DSOceanPhysicsDelegate>*)physicsObject
{
    [_toRemove addObject:physicsObject];
}
-(void)removeAllPhysicsObjects
{
    [_toRemove addObjectsFromArray:_arrPhysicsObjects];
}
-(void)applyCurrentDirection:(CGPoint)dir forDuration:(double)durationInSec
{
    _currentDirection = dir;
    double delayInSeconds = durationInSec;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _currentDirection = CGPointZero;
    });
}
-(void)updateObjectsWithPhysics
{
    [_arrPhysicsObjects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSObject<DSOceanPhysicsDelegate>* physicsObject = (NSObject<DSOceanPhysicsDelegate>*)obj;
//        CGVector updateVector = [physicsObject vectorForUpdate];
//        CGVector updateVectorPlusCurrent = CGVectorMake(updateVector.dx + _currentDirection.x, updateVector.dy + _currentDirection.y);
//        [physicsObject applyUpdateVector:updateVectorPlusCurrent];
    }];
    [_arrPhysicsObjects removeObjectsInArray:_toRemove];
    [_arrPhysicsObjects addObjectsFromArray:_toAdd];
    [_toAdd removeAllObjects];
    [_toRemove removeAllObjects];
}
@end
