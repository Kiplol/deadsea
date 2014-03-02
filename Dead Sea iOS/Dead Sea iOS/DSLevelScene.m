//
//  DSMyScene.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSLevelScene.h"
#import "DSPlayer.h"
#import "OceanPhysicsController.h"
#import "DSBulletSpriteNode.h"
#import "DSSmallEnemySpriteNode.h"
#import "YMCPhysicsDebugger.h"
#import "SKAction+Utilities.h"

@interface DSLevelScene (private)
-(void)bullet:(DSBulletSpriteNode*)bullet collidedWithCharacter:(DSCharacterSpriteNode*)character;
-(CGPoint)nearestPoint:(CGPoint)point inRect:(CGRect)rect;
-(CGRect)rectOfPlay;
@end
@implementation DSLevelScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
#if DEBUG
        [YMCPhysicsDebugger init];
#endif
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
        [OceanPhysicsController sharedController].physicsWorld = self.physicsWorld;
        self.backgroundColor = [SKColor colorWithRed:0.0f green:0.15f blue:0.3f alpha:1.0];
        _player = [DSPlayer sharedPlayer];
        [self addChild:_player.spriteNode];
        
        //Combo Label
        _comboLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _comboLabel.position = CGPointMake((_comboLabel.frame.size.width * 0.5f) + 10.0f, self.frame.size.height - (_comboLabel.frame.size.height) - 100.0f);
        _comboLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        [self addChild:_comboLabel];
        
        //Combo Countdown Bar
        _comboCountdownBar = [[SKSpriteNode alloc] initWithTexture:nil color:[UIColor yellowColor] size:CGSizeMake(1, 20)];
        _comboCountdownBar.position = CGPointMake(_comboLabel.position.x, CGRectGetMaxY(_comboLabel.frame) - 20);
        _comboCountdownBar.anchorPoint = CGPointZero;
        [self addChild:_comboCountdownBar];
        
        //TEST
        _testChar0 = [[DSSmallEnemySpriteNode alloc] init];
        [self addChild:_testChar0];
        _testChar1 = [[DSSmallEnemySpriteNode alloc] init];
        [self addChild:_testChar1];
        _testChar2 = [[DSSmallEnemySpriteNode alloc] init];
        _testChar1.fireRate = 1.5;
        _testChar1.shotsPerBurst = 0;
        [self addChild:_testChar2];
#if DEBUG
        [self drawPhysicsBodies];
#endif
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    //Ocean current
    _oceanCurrentRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    _oceanCurrentRecognizer.minimumNumberOfTouches = 2;
    _oceanCurrentRecognizer.cancelsTouchesInView = YES;
    [[self view] addGestureRecognizer:_oceanCurrentRecognizer];
    
    //TEST
    [_testChar0 startAngularFollowPlayer];
    [_testChar0 flyInFrom:CGPointMake(0.0f, self.size.height)
                      to:CGPointMake(CGRectGetMidX([self rectOfPlay]), CGRectGetMidY([self rectOfPlay]))
            overDuration:1.6
              completion:^{
                [_testChar0 startFiring];
                [_testChar0 startAngularFollowPlayerWithRestTimeEvery:1.0];
    }];
    [_testChar1 startAngularFollowPlayer];
    [_testChar1 flyInFrom:CGPointMake(0.0f, self.size.height)
                       to:CGPointMake(CGRectGetMidX([self rectOfPlay]) - 75.0f, CGRectGetMidY([self rectOfPlay]))
             overDuration:1.8
               completion:^{
                   [_testChar1 startFiring];
                   [_testChar1 startAngularFollowPlayerWithRestTimeEvery:0.9];
               }];
    [_testChar2 startAngularFollowPlayer];
    [_testChar2 flyInFrom:CGPointMake(0.0f, self.size.height)
                       to:CGPointMake(CGRectGetMidX([self rectOfPlay]) + 75.0f, CGRectGetMidY([self rectOfPlay]))
             overDuration:1.5
               completion:^{
                   [_testChar2 startFiring];
                   [_testChar2 startAngularFollowPlayerWithRestTimeEvery:0.7];
               }];
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_player.spriteNode startFiring];
//    _oceanCurrentRecognizer.enabled = NO;
//    _oceanCurrentRecognizer.enabled = YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch * touch = [[touches allObjects] objectAtIndex:0];
    CGPoint point = [touch locationInNode:self];
    CGPoint lastPoint = [touch previousLocationInNode:self];
    CGPoint deltaVector = CGPointMake(point.x - lastPoint.x, point.y - lastPoint.y);
    CGPoint currentPos = _player.spriteNode.position;
    CGPoint newPos = CGPointMake(currentPos.x + deltaVector.x, currentPos.y + deltaVector.y);
    _player.spriteNode.position = [self nearestPoint:newPos inRect:[self rectOfPlay]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [_player.spriteNode stopFiring];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [_player.spriteNode stopFiring];
}

-(void)didSwipe:(UIPanGestureRecognizer*)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
//        CGFloat scale = 1.0f;
//        CGPoint vel = [recognizer translationInView:[self view]];
//        CGFloat maxEdge = fmaxf(fabsf(vel.x), fabsf(vel.y));
//        CGVector unitVector = CGVectorMake((vel.x / maxEdge) * scale, - (vel.y / maxEdge) * scale);
//        [[OceanPhysicsController sharedController] applyCurrentDirection:unitVector forDuration:2.0f];
        CGPoint vel = [recognizer translationInView:[self view]];
        CGFloat scale = 0.02f;
        CGVector newDir = CGVectorMake(vel.x * scale, (0 - vel.y) * scale);
        [[OceanPhysicsController sharedController] applyCurrentDirection:newDir forDuration:2.0f];
    }
}

#pragma mark - Updates
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self enumerateChildNodesWithName:NAME_BULLET usingBlock:^(SKNode *node, BOOL *stop) {
        if(CGRectContainsPoint(self.view.frame, node.position) == NO)
        {
            DSBulletSpriteNode * bullet = (DSBulletSpriteNode*)node;
            [bullet removeFromPlay];
        }
    }];
    
    [self updateComboDisplayForCurrenTime:currentTime];
}

-(void)didSimulatePhysics
{
    [[OceanPhysicsController sharedController] updateObjectsWithPhysics];
}

-(void)updateComboDisplayForCurrenTime:(CFTimeInterval)currentTime;
{
    [[DSPlayer sharedPlayer].spriteNode countDownComboAtTime:currentTime];
    int combo = [DSPlayer sharedPlayer].spriteNode.combo;
    if(combo > 1)
    {
        _comboLabel.text = [NSString stringWithFormat:@"%@ %d", NSLocalizedString(@"Combo", nil), combo];
        _comboCountdownBar.size = CGSizeMake([DSPlayer sharedPlayer].spriteNode.comboCountDown * 100.0f, _comboCountdownBar.size.height);
    }
    else
    {
        _comboLabel.text = @"";
        _comboCountdownBar.size = CGSizeMake(0, _comboCountdownBar.size.height);
    }

}

#pragma mark - SKPhysicsContactDelegate
-(void)didBeginContact:(SKPhysicsContact *)contact
{
    DSBulletSpriteNode * bullet = nil;
    DSCharacterSpriteNode * character = nil;
    //Find the bullet
    if(contact.bodyA.categoryBitMask & DSColliderTypeProjectile)
    {
        bullet = (DSBulletSpriteNode*)contact.bodyA.node;
    }
    else if (contact.bodyB.categoryBitMask & DSColliderTypeProjectile)
    {
        bullet = (DSBulletSpriteNode*)contact.bodyB.node;
    }
    //Find the character
    if(contact.bodyA.categoryBitMask & (DSColliderTypePlayer | DSColliderTypeEnemy))
    {
        character = (DSCharacterSpriteNode*)contact.bodyA.node;
    }
    else if (contact.bodyB.categoryBitMask & (DSColliderTypePlayer | DSColliderTypeEnemy))
    {
        character = (DSCharacterSpriteNode*)contact.bodyB.node;
    }
    if(bullet && character)
    {
        [self bullet:bullet collidedWithCharacter:character];
    }

    [bullet removeFromPlay];
}

#pragma mark - private
-(void)bullet:(DSBulletSpriteNode*)bullet collidedWithCharacter:(DSCharacterSpriteNode*)character
{
    //shooter
    character.health--;
    BOOL didDestroy = (character.health <= 0);
    DSCharacterSpriteNode * shooter = nil;
    if(bullet.shooter)
    {
        shooter = (DSCharacterSpriteNode*)bullet.shooter;
        if([bullet.shooter conformsToProtocol:@protocol(DSDestroyerDelegate)])
        {
            DSCharacterSpriteNode <DSDestroyerDelegate> * destroyer = (DSCharacterSpriteNode <DSDestroyerDelegate> *)shooter;
            shooter = (DSCharacterSpriteNode<DSDestroyerDelegate>*)bullet.shooter;
            if([shooter respondsToSelector:@selector(didDamageCharacter:)])
            {
                [destroyer didDamageCharacter:character];
            }
            if(didDestroy && [shooter respondsToSelector:@selector(didDestroyCharacter:)])
            {
                [destroyer didDestroyCharacter:character];
            }
        }
    }
    //shootee
    if([character conformsToProtocol:@protocol(DSDestroyableDelegate)])
    {
        if([character respondsToSelector:@selector(didTakeDamagefromCharacter:)])
        {
            [character didTakeDamagefromCharacter:shooter];
        }
        if(didDestroy && [character respondsToSelector:@selector(didGetDestroyedByCharacter:)])
        {
            [character didGetDestroyedByCharacter:shooter];
        }
    }
}
-(CGRect)rectOfPlay
{
    CGFloat padding = 10.0f;
    CGRect playRect = self.view.frame;
    playRect.origin = CGPointMake(padding, padding);
    playRect.size.width -= (2 * padding);
    playRect.size.height -= (2* padding);
    return playRect;
}
-(CGPoint)nearestPoint:(CGPoint)point inRect:(CGRect)rect
{
    if(CGRectContainsPoint(rect, point))
    {
        return point;
    }
    else
    {
        CGPoint nearestPoint = point;
        //x
        if(nearestPoint.x <= rect.origin.x)
        {
            nearestPoint.x = rect.origin.x;
        }
        else if(nearestPoint.x >= CGRectGetMaxX(rect))
        {
            nearestPoint.x = CGRectGetMaxX(rect);
        }
        else
        {
            //x was fine.
            //Leave as is.
        }
        
        //y
        if(nearestPoint.y <= rect.origin.y)
        {
            nearestPoint.y = rect.origin.y;
        }
        else if (nearestPoint.y >= CGRectGetMaxY(rect))
        {
            nearestPoint.y = CGRectGetMaxY(rect);
        }
        else
        {
            //y was fine.
            //Leave as is
        }
        return nearestPoint;
    }
}
@end
