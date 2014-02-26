//
//  DSSpriteNode.m
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSSpriteNode.h"

@implementation DSSpriteNode
-(id)init
{
    if((self = [super init]))
    {
        [self fillAtlasDictionary];
        self.texture = [self initialTexture];
        self.size = self.texture.size;
    }
    return self;
}

-(void)fillAtlasDictionary
{
    if(!_dicAtlases)
    {
        _dicAtlases = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
}

-(SKTexture*)initialTexture
{
    NSLog(@"Must override %s", __PRETTY_FUNCTION__);
    return nil;
}

-(void)faceTowardsPoint:(CGPoint)point maximumRotation:(double)angleInRadians duration:(double)dur completion:(void (^)())completion
{
    CGFloat dx = self.position.x - point.x;
    CGFloat dy = self.position.y - point.y;
    double angleToTurn = atan2(dy,dx) + M_PI_2; //We're adding M_PI_2 because we want up to be the normal direction
    [self runAction:[SKAction rotateToAngle:angleToTurn duration:dur] completion:^{
        if(completion)
        {
            completion();
        }
    }];
}
@end
