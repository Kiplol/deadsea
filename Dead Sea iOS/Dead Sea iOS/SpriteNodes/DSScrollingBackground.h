//
//  DSScrollingBackground.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 3/9/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSpriteNode.h"

@interface DSScrollingBackground : DSSpriteNode {
    SKSpriteNode * _bg1;
    SKSpriteNode * _bg2;
    BOOL _scrolling;
}

@property (nonatomic, readwrite) int scrollSpeed;
@property (nonatomic, readonly) CGSize bgSize;
-(void)startScrolling;
-(void)stopScrolling;
-(void)update;
@end
