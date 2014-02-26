//
//  DSPlayerCharacter.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DSCharacterSpriteNode.h"

@interface DSPlayerCharacterSpriteNode : DSCharacterSpriteNode {
    double _comboCountDown;
    double _comboStartTime;
}
@property (nonatomic, readwrite) double comboCountDown;

-(void)leanLeft;
-(void)leanRight;
-(void)leanForDelta:(CGPoint)deltaVector;
-(void)rechargeCombo;

@end
