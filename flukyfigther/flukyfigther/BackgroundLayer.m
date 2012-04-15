//
//  BackgroundLayer.m
//  flukyfigther
//
//  Created by Adolfo Gutierrez on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer
-(id)init {
    self = [super init];
    if (self != nil) {
        
        
        
        CCSprite *backgroundImage;
        backgroundImage = [CCSprite spriteWithFile:@"BG.png"];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [backgroundImage setPosition: CGPointMake(screenSize.width/2, screenSize.height/2)];
        
        [self addChild:backgroundImage z:0 tag:0];
        
        
    }
return self;
}
@end
