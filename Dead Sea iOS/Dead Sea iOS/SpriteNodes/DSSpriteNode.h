//
//  DSSpriteNode.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DSSpriteNode : SKSpriteNode {
    NSMutableDictionary * _dicAtlases;
}

-(void)fillAtlasDictionary;
-(SKTexture*)initialTexture;
@end
