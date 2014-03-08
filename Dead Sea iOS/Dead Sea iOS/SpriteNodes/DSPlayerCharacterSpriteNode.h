//
//  DSPlayerCharacter.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DSCharacterSpriteNode.h"

@interface DSPlayerCharacterSpriteNode : DSCharacterSpriteNode <DSDestroyerDelegate> {
    CFTimeInterval _comboCountDown;
    CFTimeInterval _comboStartTime;
    BOOL _alive;
    int _combo;
}
/*!
 * Time until combo expires
 */
@property (nonatomic, readonly) CFTimeInterval comboCountDown;
@property (nonatomic, readonly) BOOL alive;
@property (nonatomic, readonly) int combo;

-(void)leanLeft;
-(void)leanRight;
-(void)leanForDelta:(CGPoint)deltaVector;
-(void)rechargeComboCountdown;
-(void)countDownComboAtTime:(CFTimeInterval)currentTime;
-(int)expireCombo;
@end
