//
//  GameplayLayer.h
//  flukyfigther
//
//  Created by Adolfo Gutierrez on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "ColoredCircleSprite.h"

@interface GameplayLayer : CCLayer
{
    CCSprite *flukyFighterSprite;
    SneakyJoystick *leftJoystick;
    SneakyButton *jumpButton;
    SneakyButton *attackButton;
}

@end
