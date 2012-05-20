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
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 158.0f, 158.0f);
    CGRect jumpButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    CGRect attackButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    CGPoint joystickBasePosition;
    CGPoint jumpButtonPosition;
    CGPoint attackButtonPosition;
    
    //Identifiying what Hardware to position buttons
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad running iPhone 3.2 or later.
        CCLOG(@"Positioning Joystick and Buttons for iPad");
        joystickBasePosition = ccp(screenSize.width*0.12f,
                                   screenSize.height*0.14f);
        jumpButtonPosition = ccp(screenSize.width*0.93f,
                                 screenSize.height*0.1f);
        attackButtonPosition = ccp(screenSize.width*0.93f,
                                   screenSize.height*0.2f);
    } else {
        // The device is an iPhone or iPod touch.
        CCLOG(@"Positioning Joystick and Buttons for iPhone");
        joystickBasePosition = ccp(screenSize.width*0.18f,
                                   screenSize.height*0.28f);
        jumpButtonPosition = ccp(screenSize.width*0.90f,
                                 screenSize.height*0.16f);
        attackButtonPosition = ccp(screenSize.width*0.90f,
                                   screenSize.height*0.38f);
    }
    
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    joystickBase.position = joystickBasePosition;
    //joystickBase.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"dPad.png"];
    joystickBase.backgroundSprite.opacity = 200;
    //joystickBase.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:16];
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"joystick.png"];
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    joystickBase.thumbSprite.opacity = 200;
    
    leftJoystick = [joystickBase.joystick retain];
    [self addChild:joystickBase];
    
    SneakyButtonSkinnedBase *jumpButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    jumpButtonBase.position = jumpButtonPosition;
    jumpButtonBase.defaultSprite = [CCSprite spriteWithFile:@"button1.png"];
    jumpButtonBase.defaultSprite.opacity = 150;
    //jumpButtonBase.activatedSprite = [CCSprite spriteWithFile:@"button1-pressed.png"];
    jumpButtonBase.pressSprite = [CCSprite spriteWithFile:@"button1.png"];
    jumpButtonBase.pressSprite.opacity = 255;
    jumpButtonBase.button = [[SneakyButton alloc] initWithRect:jumpButtonDimensions];
    jumpButton = [jumpButtonBase.button retain];
    jumpButton.isToggleable = NO;
    jumpButton.isHoldable = YES;
    [self addChild:jumpButtonBase];
    
    SneakyButtonSkinnedBase *attackButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    attackButtonBase.position = attackButtonPosition;
    attackButtonBase.defaultSprite = [CCSprite spriteWithFile:@"button2.png"];
    attackButtonBase.defaultSprite.opacity = 150;
    attackButtonBase.pressSprite = [CCSprite spriteWithFile:@"button2.png"];
    attackButtonBase.pressSprite.opacity = 255;
    attackButtonBase.button = [[SneakyButton alloc] initWithRect:attackButtonDimensions];
    attackButton = [attackButtonBase.button retain];
    attackButton.isToggleable = NO;
    attackButton.isHoldable = YES;
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
        
        //Uncomment this to scale down the character sprite to the iphone
//        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) { 
//            // If NOT on the iPad, scale down the character
//            // In your games, use this to load art sized for the device
//            [flukyFighterSprite setScaleX:screenSize.width/1024.0f];
//            [flukyFighterSprite setScaleY:screenSize.height/768.0f];
//        }
        
        [self initJoystickAndButtons];
        [self scheduleUpdate]; 
    }
    return self;
}

@end
