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

@interface DSCharacterSpriteNode (private)
-(CGFloat)radiusForPhysicsBody;
-(void)followPlayerAngular;
@end

@implementation DSCharacterSpriteNode
-(id)init
{
    if((self = [super init]))
    {
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
    DSBulletSpriteNode * bullet = [self nextBullet];
    
    if(bullet)
    {
        bullet.position = self.position;
        bullet.shooter = self;
        [self.scene addChild:bullet];
        [bullet fire];
        _shotsThisBurst++;
    }
    
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

-(DSBulletSpriteNode*)nextBullet
{
    NSLog(@"Must override %s", __PRETTY_FUNCTION__);
    return nil;
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
    self.position = fromPoint;
    SKAction * flyInAction = [SKAction moveTo:toPoint duration:dur];
    flyInAction.timingMode = SKActionTimingEaseOut;
    SKAction * sequence = [SKAction sequence:@[flyInAction]];
    [self runAction:sequence completion:^{
        if(completion)
        {
            completion();
        }
    }];
}
#pragma mark - DSDestroyableDelegate
-(void)didTakeDamagefromCharacter:(DSCharacterSpriteNode*)character
{
    //Empty
}
-(void)didGetDestroyedByCharacter:(DSCharacterSpriteNode*)character
{
    //Empty
}
#pragma mark - private
-(void)followPlayerAngular
{
    SKAction * fart = [SKAction rotateTowardsPoint:[DSPlayer sharedPlayer].spriteNode.position
                                         fromPoint:self.position
                                          duration:0.2
                                          waitTime:_angularFollowRestTime
                                        completion:^{
                                            if(_angularFollowPlayer)
                                            {
                                                [self followPlayerAngular];
                                            }
                                        }];
    [self runAction:fart];
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
