//
//  GameplayLayer.m
//  flukyfigther
//
//  Created by Luis Matute on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"

@implementation GameplayLayer

-(void)initJoystickAndButtons
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect jumpButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    CGRect attackButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    CGPoint joystickBasePosition;
    CGPoint jumpButtonPosition;
    CGPoint attackButtonPosition;
    
    joystickBasePosition = ccp(screenSize.width*0.07f,screenSize.height*0.11f);
    jumpButtonPosition = ccp(screenSize.width*0.93f,screenSize.height*0.11f);
    attackButtonPosition = ccp(screenSize.width*0.93f,screenSize.height*0.35f);
    
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    joystickBase.position = joystickBasePosition;
    joystickBase.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
    joystickBase.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:16];
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    
    leftJoystick =[joystickBase.joystick retain];
    [self addChild:joystickBase];
    
    SneakyButtonSkinnedBase *jumpButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    jumpButtonBase.position = jumpButtonPosition;
    jumpButtonBase.defaultSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 128) radius:32];
    jumpButtonBase.activatedSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 255) radius:32];
    jumpButtonBase.pressSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 255) radius:32];
    jumpButtonBase.button = [[SneakyButton alloc] initWithRect:jumpButtonDimensions];
    jumpButton = [jumpButtonBase.button retain];
    jumpButton.isToggleable = NO;
    [self addChild:jumpButtonBase];
    
    SneakyButtonSkinnedBase *attackButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    attackButtonBase.position = attackButtonPosition;
    attackButtonBase.defaultSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 128) radius:32];
    attackButtonBase.activatedSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 255) radius:32];
    attackButtonBase.pressSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 255) radius:32];
    attackButtonBase.button = [[SneakyButton alloc] initWithRect:attackButtonDimensions];
    attackButton = [attackButtonBase.button retain];
    attackButton.isToggleable = NO;
    [self addChild:attackButtonBase];
}

-(void)applyJoystick:(SneakyJoystick *)aJoystick toNode:(CCNode *)tempNode forTimeDelta:(float)deltaTime
{
    CGPoint scaledVelocity = ccpMult(aJoystick.velocity, 1024.0f);
    CGPoint newPosition = ccp(tempNode.position.x + scaledVelocity.x * deltaTime, tempNode.position.y + scaledVelocity.y * deltaTime);
    
    [tempNode setPosition:newPosition];
    if (jumpButton.active == YES) 
    {
        CCLOG(@"Jump button is pressed.");
    }
    if (attackButton.active == YES) 
    {
        CCLOG(@"Attack button is pressed.");
    }
}

#pragma mark -
#pragma mark Update Method
-(void) update:(ccTime)deltaTime
{
    [self applyJoystick:leftJoystick toNode:flukyFighterSprite forTimeDelta:deltaTime];
}

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
        
        [self initJoystickAndButtons];
        [self scheduleUpdate]; 
    }
    return self;
}

@end
