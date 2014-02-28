//
//  OceanPhysicsController.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKPhysicsWorld;
@protocol DSOceanPhysicsDelegate <NSObject>
@required
//-(CGVector)vectorForUpdate;
//-(void)applyUpdateVector:(CGVector)updateVector;
@end

@interface OceanPhysicsController : NSObject {
    NSMutableArray * _arrPhysicsObjects;
    CGVector _currentDirection;
    NSMutableArray * _toAdd;
    NSMutableArray * _toRemove;
}

@property (nonatomic, readonly) NSArray * physicsObjects;
@property (nonatomic, assign) SKPhysicsWorld * physicsWorld;
+(OceanPhysicsController*)sharedController;
-(void)updateObjectsWithPhysics;
-(void)addPhysicsObject:(NSObject<DSOceanPhysicsDelegate>*)physicsObject;
-(void)removePhysicsObject:(NSObject<DSOceanPhysicsDelegate>*)physicsObject;
-(void)removeAllPhysicsObjects;
-(void)applyCurrentDirection:(CGVector)dir forDuration:(double)durationInSec;
@end
