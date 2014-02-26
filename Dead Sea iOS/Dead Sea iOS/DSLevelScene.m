//
//  DSMyScene.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSLevelScene.h"
#import "DSPlayerCharacter.h"
#import "OceanPhysicsController.h"
#import "DSBulletSpriteNode.h"

@interface DSLevelScene (private)
-(CGPoint)nearestPoint:(CGPoint)point inRect:(CGRect)rect;
@end
@implementation DSLevelScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
        
        self.backgroundColor = [SKColor colorWithRed:0.0f green:0.15f blue:0.3f alpha:1.0];
        _player = [DSPlayerCharacter sharedCharacter];
        [self addChild:_player.spriteNode];
        
        //Combo Label
        _comboLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _comboLabel.text = NSLocalizedString(@"Combo", nil);
        _comboLabel.position = CGPointMake((_comboLabel.frame.size.width * 0.5f) + 10.0f, self.frame.size.height - (_comboLabel.frame.size.height) - 100.0f);
        [self addChild:_comboLabel];
        
        //TEST
        
        DSSpriteNode * testChar = [[DSPlayerCharacterSpriteNode alloc] init];
        [self addChild:testChar];
        testChar.position = CGPointMake(size.width * 0.5f, size.height * 0.5f);
        testChar.physicsBody.categoryBitMask = DSColliderTypeEnemy;
        testChar.physicsBody.contactTestBitMask = DSColliderTypePlayerProjectile;
    }
    return self;
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
    [super touchesBegan:touches withEvent:event];
    UITouch * touch = [touches anyObject];
    _lastTouchPoint = [touch locationInNode:self];
    [_player.spriteNode startFiring];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    CGPoint deltaVector = CGPointMake(point.x - _lastTouchPoint.x, point.y - _lastTouchPoint.y);
    CGPoint currentPos = _player.spriteNode.position;
    CGPoint newPos = CGPointMake(currentPos.x + deltaVector.x, currentPos.y + deltaVector.y);
    _player.spriteNode.position = [self nearestPoint:newPos inRect:self.view.frame];
    _lastTouchPoint = point;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [_player.spriteNode stopFiring];
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
}

-(void)didSimulatePhysics
{
    [[OceanPhysicsController sharedController] updateObjectsWithPhysics];
}

#pragma mark - private
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

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    
}
@end
