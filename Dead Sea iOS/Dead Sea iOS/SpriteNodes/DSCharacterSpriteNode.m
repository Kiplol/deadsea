//
//  DSCharacterSpriteNode.m
//  Dead Sea iOS
//
//  Created by Kip on 2/25/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSCharacterSpriteNode.h"
#import "DSBulletSpriteNode.h"
#import "DSPlayer.h"
#import "SKNode+Utilities.h"

@interface DSCharacterSpriteNode (private)
-(CGFloat)radiusForPhysicsBody;
-(void)followPlayerAngular;
@end

@implementation DSCharacterSpriteNode
-(id)init
{
    if((self = [super init]))
    {
        _bulletEmitter = [[DSBulletEmitter alloc] init];
        [self addChild:_bulletEmitter];
        self.fireRate = 5;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:[self radiusForPhysicsBody]];
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.collisionBitMask = DSColliderTypeNone;
    }
    return self;
}
-(void)fire
{
    //Fire now
    [_bulletEmitter emitFromShooter:self];
    _shotsThisBurst++;
    
    //Do it again
    if(_bFiring && self.fireRate > 0)
    {
        double delayInSeconds = 1.0/self.fireRate;
        if(_shotsThisBurst >= self.shotsPerBurst && (self.shotsPerBurst > 0))
        {
            delayInSeconds += self.timeBetweenBursts;
            _shotsThisBurst = 0;
        }
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(_bFiring && self.fireRate > 0)
            {
                [self fire];
            }
            else
            {
                _shotsThisBurst = 0;
            }
        });
    }
}

-(void)startFiring
{
    if(!_bFiring)
    {
        _bFiring = YES;
        [self fire];
    }
}
-(void)stopFiring
{
    _bFiring = NO;
    _shotsThisBurst = 0;
}

-(void)startAngularFollowPlayer
{
    [self startAngularFollowPlayerWithRestTimeEvery:0.0];
}

-(void)startAngularFollowPlayerWithRestTimeEvery:(double)seconds
{
    _angularFollowPlayer = YES;
    _angularFollowRestTime = seconds;
    [self followPlayerAngular];
}
-(void)flyInFrom:(CGPoint)fromPoint to:(CGPoint)toPoint overDuration:(double)dur completion:(void (^)())completion
{
    SKTMoveEffect * moveEffect = [SKTMoveEffect effectWithNode:self duration:dur startPosition:fromPoint endPosition:toPoint];
    moveEffect.timingFunction = SKTTimingFunctionBackEaseOut;
    SKAction * flyInAction = [SKAction actionWithEffect:moveEffect];
    SKAction * sequence = [SKAction sequence:@[flyInAction]];
    [self runAction:sequence completion:^{
        if(completion)
        {
            completion();
        }
    }];
}
-(void)damageAnimation
{
    double totalTime = 1.0;
    [self removeActionForKey:@"DamageColor"];
    [self runAction:[SKAction skt_screenShakeWithNode:self amount:CGPointMake(1, 2) oscillations:10 duration:totalTime]];
    SKAction * colorRedAction = [SKAction colorizeWithColor:[UIColor redColor] colorBlendFactor:1.0 duration:totalTime * 0.25];
    SKAction * colorClearAction = [SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:1.0 duration:totalTime * 0.25];
    [self runAction:[SKAction sequence:@[colorRedAction, colorClearAction]] withKey:@"DamageColor"];
}
#pragma mark - DSDestroyableDelegate
-(void)didTakeDamagefromCharacter:(DSCharacterSpriteNode*)character
{
    [self damageAnimation];
}
-(void)didGetDestroyedByCharacter:(DSCharacterSpriteNode*)character
{
    //Empty
}
#pragma mark - private
-(void)followPlayerAngular
{
    CGPoint myAbsolutePoint = [self.scene convertPoint:self.position fromNode:self.parent];
    CGPoint playAbsolutePoint = [self.scene convertPoint:[DSPlayer sharedPlayer].spriteNode.position fromNode:[DSPlayer sharedPlayer].spriteNode.parent];
    CGPoint diffPoint = CGPointSubtract(myAbsolutePoint, playAbsolutePoint);
    double angle = CGPointToAngle(diffPoint) + M_PI_2;
    angle = fmod(angle, M_PI * 2);
    if(self.parent != [DSPlayer sharedPlayer].spriteNode.parent)
    {
        double parentRotation =  fmod([self.parent absoluteZRotation], M_PI * 2);
        angle -= parentRotation;
        NSLog(@"%f", angle);
    }
    SKAction * shit = [SKAction rotateToAngle:angle duration:0.2 shortestUnitArc:YES];
    [self runAction:shit completion:^{
        if(_angularFollowPlayer)
        {
            [self followPlayerAngular];
        }
    }];
    
//    SKAction * fart = [SKAction rotateTowardsPoint:[DSPlayer sharedPlayer].spriteNode.position
//                                         fromPoint:self.position
//                                          duration:0.2
//                                          waitTime:_angularFollowRestTime
//                                        completion:^{
//                                            if(_angularFollowPlayer)
//                                            {
//                                                [self followPlayerAngular];
//                                            }
//                                        }];
//    [self runAction:fart];
}
-(void)stopAngularFollowPlayer
{
    _angularFollowPlayer = NO;
}
-(CGFloat)radiusForPhysicsBody
{
    return (self.size.width * 0.5f);
}

@end
