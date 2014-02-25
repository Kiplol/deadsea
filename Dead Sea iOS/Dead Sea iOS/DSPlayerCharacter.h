//
//  DSPlayerCharacter.h
//  Dead Sea iOS
//
//  Created by Elliott Kipper on 2/24/14.
//  Copyright (c) 2014 Supernovacaine Interactive. All rights reserved.
//

#import "DSCharacter.h"

@interface DSPlayerCharacter : DSCharacter {
    BOOL _bFiring;
}

+(DSPlayerCharacter*)sharedCharacter;

-(void)startFiring;
-(void)stopFiring;
@end
