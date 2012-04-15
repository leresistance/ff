//
//  GameScene.m
//  flukyfigther
//
//  Created by Adolfo Gutierrez on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BackgroundLayer.h"
#import "GameScene.h"

@implementation GameScene



-(id)init {
    self = [super init];
    if (self != nil) {
        // Background Layer
        BackgroundLayer *backgroundLayer = [BackgroundLayer node];
        [self addChild:backgroundLayer z:0];
    }
    return self;
} 

@end
