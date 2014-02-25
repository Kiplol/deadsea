//
//  OceanPhysicsController.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DSOceanPhysicsDelegate <NSObject>
@required
-(CGPoint)vectorForUpdate;
-(void)applyUpdateVector:(CGPoint)updateVector;
@end

@interface OceanPhysicsController : NSObject {
    NSMutableArray * _arrPhysicsObjects;
    CGPoint _currentDirection;
    NSMutableArray * _toAdd;
    NSMutableArray * _toRemove;
}

@property (nonatomic, readonly) NSArray * physicsObjects;
+(OceanPhysicsController*)sharedController;
-(void)updateObjectsWithPhysics;
-(void)addPhysicsObject:(NSObject<DSOceanPhysicsDelegate>*)physicsObject;
-(void)removePhysicsObject:(NSObject<DSOceanPhysicsDelegate>*)physicsObject;
-(void)removeAllPhysicsObjects;
-(void)applyCurrentDirection:(CGPoint)dir forDuration:(double)duration;
@end
