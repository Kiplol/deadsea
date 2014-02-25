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
@end

@interface OceanPhysicsController : NSObject {
    NSMutableArray * _arrPhysicsObjects;
    CGPoint _currentDirection;
}

+(OceanPhysicsController*)sharedController;
-(void)addPhysicsObject:(NSObject<DSOceanPhysicsDelegate>*)physicsObject;
-(void)clearPhysicsObjects;
-(void)applyCurrentDirection:(CGPoint)dir forDuration:(double)duration;
@end
