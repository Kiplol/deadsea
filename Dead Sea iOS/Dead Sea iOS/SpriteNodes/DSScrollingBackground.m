//
//  DSScrollingBackground.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/9/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSScrollingBackground.h"

#define NAME_BACKGROUND @"background"

@implementation DSScrollingBackground
@dynamic bgSize;
-(id)initWithImageNamed:(NSString *)name
{
    if((self = [super init]))
    {
        self.scrollSpeed = 5;
        _bg1 = [[SKSpriteNode alloc] initWithImageNamed:name];
        _bg1.anchorPoint = CGPointZero;
        _bg1.name = NAME_BACKGROUND;
        _bg2 = [[SKSpriteNode alloc] initWithImageNamed:name];
        _bg2.anchorPoint = CGPointZero;
        _bg2.name = NAME_BACKGROUND;
        _bg1.position = CGPointMake(0, 0);
        _bg2.position = CGPointMake(0, _bg1.size.height);
        [self addChild:_bg1];
        [self addChild:_bg2];
        self.size = CGSizeMake(_bg1.size.width, (_bg1.size.height * 2));
        _scrolling = NO;
    }
    return self;
}

-(void)startScrolling
{
    _scrolling = YES;
}
-(void)stopScrolling
{
    _scrolling = NO;
}
-(CGSize)bgSize
{
    return _bg1.size;
}
-(void)update
{
    if(_scrolling)
    {
        [self enumerateChildNodesWithName:NAME_BACKGROUND usingBlock:^(SKNode *node, BOOL *stop) {
            SKSpriteNode *bg = (SKSpriteNode *) node;
            bg.position = CGPointMake(bg.position.x, bg.position.y - self.scrollSpeed);
            if(bg.position.y <= -bg.size.height)
            {
                bg.position = CGPointMake(bg.position.x, bg.position.y + 2 * bg.size.height);
            }
        }];
    }
}
@end
