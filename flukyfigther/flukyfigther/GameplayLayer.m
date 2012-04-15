//
//  GameplayLayer.m
//  flukyfigther
//
//  Created by Adolfo Gutierrez on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"

@implementation GameplayLayer

-(id)init
{
    self = [super init];
    if( self )
    {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        //enable touches
        self.isTouchEnabled = YES;
        flukyFighterSprite = [CCSprite spriteWithFile:@"flukyfighter.png"];
        [flukyFighterSprite setPosition:CGPointMake(screenSize.width/2, screenSize.height*0.17f)];
        [self addChild:flukyFighterSprite];
    }
    return self;
}

@end
