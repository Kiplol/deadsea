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
-(void)rotateTowardsPlayer;
@end

@implementation DSCharacterSpriteNode
@synthesize health = _health;
@synthesize maxHealth = _maxHealth;

-(id)initWithMaxHealth:(int)maxHealth
{
    if((self = [super init]))
    {
        _health = maxHealth;
        _maxHealth = maxHealth;
        _bulletEmitters = [[NSMutableArray alloc] init];
        DSBulletEmitter * firstEmitter = [[DSBulletEmitter alloc] init];
        [self addBulletEmitter:firstEmitter];
        self.fireRate = 5;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:[self radiusForPhysicsBody]];
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.collisionBitMask = DSColliderTypeNone;
    }
    return self;
}
-(id)init
{
    return [self initWithMaxHealth:1];
}
-(void)updateWithInfo:(NSDictionary*)info
{
    //Subclass
}
-(void)fillAtlasDictionary
{
    [super fillAtlasDictionary];
    //Explosion
    SKTextureAtlas * explosionAtlas = [SKTextureAtlas atlasNamed:@"SmallExplosion"];
    [_dicAtlases setObject:explosionAtlas forKey:ATLAS_KEY_EXPLOSION];
}

-(void)enterPlay
{
    //Subclass
}
-(void)fire
{
    if(_bulletEmitters.count)
    {
        int idx = arc4random_uniform((unsigned int)_bulletEmitters.count);
        DSBulletEmitter * emitter = [_bulletEmitters objectAtIndex:idx];
        [self fireFromEmitter:emitter];
        _indexOfLastFiredEmitter = idx;
    }
}
-(void)fireFromEmitter:(DSBulletEmitter *)emitter
{
    //Fire now
    [emitter emitFromShooter:self];
    _shotsThisBurst++;
    
    //Do it again
    if(_bFiring && self.fireRate > 0)
    {
        double delayInSeconds = 1.0/(self.fireRate * _bulletEmitters.count);
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
-(void)addBulletEmitter
{
    [self addBulletEmitter:[[DSBulletEmitter alloc] init]];
}
-(void)addBulletEmitter:(DSBulletEmitter*)emitter
{
    [_bulletEmitters addObject:emitter];
    [self addChild:emitter];
    [self positionBulletEmitters];
}
-(void)resetBulletEmitters
{
    if(_bulletEmitters.count)
    {
        DSBulletEmitter * firstEmitter = [_bulletEmitters objectAtIndex:0];
        [_bulletEmitters removeAllObjects];
        [_bulletEmitters addObject:firstEmitter];
    }
    [self positionBulletEmitters];
}

-(void)positionBulletEmitters
{
    CGFloat spaceBetweenEmitters = 5.0f;
    CGFloat totalSpace = (spaceBetweenEmitters * (_bulletEmitters.count - 1));
    CGFloat xOffset = (_bulletEmitters.count % 2 ? 0.0f : spaceBetweenEmitters);
    CGFloat currentX = 0 - (totalSpace * 0.5f) - xOffset;
    for (int i = 0; i < _bulletEmitters.count; i++) {
        DSBulletEmitter * currentEmitter = [_bulletEmitters objectAtIndex:i];
        currentEmitter.position = CGPointMake(currentX, currentEmitter.position.y);
        currentX += spaceBetweenEmitters;
    }
}

-(void)startRotatingTowardsPlayer
{
    [self startRotatingTowardsPlayerWithRestTimeEvery:0.0];
}
-(void)startRotatingTowardsPlayerWithRestTimeEvery:(double)seconds
{
    _rotateTowardsPlayer = YES;
    _rotateTowardsPlayerRestTime = seconds;
    [self rotateTowardsPlayer];
}
-(void)stopRotatingTowardsPlayer
{
    _rotateTowardsPlayer = NO;
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
-(void)removeFromPlay
{
    [super removeFromPlay];
    [self stopFiring];
    [self stopRotatingTowardsPlayer];
    self.health = 0;
    _bFiring = NO;
    _rotateTowardsPlayer = NO;
}
-(SKAction*)damageAnimationAction
{
    double totalTime = 1.0;
    [self runAction:[SKAction skt_screenShakeWithNode:self amount:CGPointMake(1, 2) oscillations:10 duration:totalTime]];
    SKAction * colorRedAction = [SKAction colorizeWithColor:[UIColor redColor] colorBlendFactor:1.0 duration:totalTime * 0.25];
    SKAction * colorClearAction = [SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:1.0 duration:totalTime * 0.25];
    SKAction * sequence = [SKAction sequence:@[colorRedAction, colorClearAction]];
    return sequence;
}
-(void)damageAnimation
{
    [self removeActionForKey:ACTION_NAME_DAMAGE_ANIMATION];
    [self runAction:[self damageAnimationAction] withKey:ACTION_NAME_DAMAGE_ANIMATION];
}

-(SKAction*)destroyAnimationAction
{
    return [SKAction animateWithTextureAtlas:[_dicAtlases objectForKey:ATLAS_KEY_EXPLOSION] timePerFrame:1.0/15.0 resize:NO restore:NO];
}
-(void)destroyAnimation
{
    [self removeActionForKey:ACTION_NAME_DAMAGE_ANIMATION];
    [self removeActionForKey:ACTION_NAME_DESTROY_ANIMATION];
    [self runAction:[self destroyAnimationAction] withKey:ACTION_NAME_DESTROY_ANIMATION];
}
-(void)destroyAnimationAndRemove
{
    [self removeActionForKey:ACTION_NAME_DAMAGE_ANIMATION];
    [self removeActionForKey:ACTION_NAME_DESTROY_ANIMATION];
    [self runAction:[self destroyAnimationAction] completion:^{
        [self removeFromPlay];
    }];
}
-(NSString*)destructionSound
{
    return nil;
}

-(void)reset
{
    [super reset];
    [self resetBulletEmitters];
    _health = _maxHealth;
}
#pragma mark - DSDestroyableDelegate
-(void)didTakeDamagefromCharacter:(DSCharacterSpriteNode*)character
{
    [self damageAnimation];
}
-(void)didGetDestroyedByCharacter:(DSCharacterSpriteNode*)character
{
    [self removeAllActions];
    [self destroyAnimationAndRemove];
    if([self destructionSound])
    {
        [self runAction:[SKAction playSoundFileNamed:[self destructionSound] waitForCompletion:NO]];
    }
}
#pragma mark - private
-(void)rotateTowardsPlayer
{
    if(![DSPlayer sharedPlayer].spriteNode.alive || ![DSPlayer sharedPlayer].spriteNode.parent)
    {
        [self stopRotatingTowardsPlayer];
        return;
    }
    CGPoint myAbsolutePoint = [self.scene convertPoint:self.position fromNode:self.parent];
    CGPoint playAbsolutePoint = [self.scene convertPoint:[DSPlayer sharedPlayer].spriteNode.position fromNode:[DSPlayer sharedPlayer].spriteNode.parent];
    CGPoint diffPoint = CGPointSubtract(myAbsolutePoint, playAbsolutePoint);
    double angle = CGPointToAngle(diffPoint) + M_PI_2;
    angle = fmod(angle, M_PI * 2);
    if(self.parent != [DSPlayer sharedPlayer].spriteNode.parent)
    {
        double parentRotation =  fmod([self.parent absoluteZRotation], M_PI * 2);
        angle -= parentRotation;
    }
    SKAction * shit = [SKAction rotateToAngle:angle duration:0.2 shortestUnitArc:YES];
    [self runAction:shit completion:^{
        if(_rotateTowardsPlayer)
        {
            [self rotateTowardsPlayer];
        }
    }];
}
-(CGFloat)radiusForPhysicsBody
{
    return (self.size.width * 0.5f);
}

@end
