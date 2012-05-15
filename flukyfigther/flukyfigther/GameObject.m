//
//  GameObject.m
//  flukyfigther
//
//  Created by Luis Matute on 4/17/12.
//  Copyright (c) 2012 San Services. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject
@synthesize reactsToScreenBoundaries;
@synthesize screenSize;
@synthesize isActive;
@synthesize gameObjectType;

-(id)init
{
    if( ( self = [super init] ) )
    {
        CCLOG(@"GameObject Init");
        screenSize = [CCDirector sharedDirector].winSize;
        isActive = TRUE;
        gameObjectType = kObjectTypeNone;
    }
    return self;
}

-(void)changeState:(CharacterStates)newState
{
    CCLOG(@"GameObject-> changeState method should be overridden");
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects
{
    CCLOG(@"updateStateWithDeltaTime method should be overridden");
}

-(CGRect)adjustedBoundingBox
{
    CCLOG(@"GameObect adjustedBoundingBox should be overridden");
    return [self boundingBox];
}

-(CCAnimation*)loadPlistForAnimationWithName:(NSString *)animationName andClassName:(NSString *)className
{
    CCAnimation *animationToReturn = nil;
    NSString *fullFileName = [NSString stringWithFormat:@"%@.plist", className];
    NSString *plistPath;
    
    //1. Get the path for the Plist file
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:plistPath] ) {
        plistPath = [[NSBundle mainBundle] pathForResource:className ofType:@"plist"];
    }
    
    //2. Read the Plist file
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    //3. If the plistDictionary is null, the file was not found
    if ( plistDictionary == nil ) {
        CCLOG(@"Error reading plist: %@.plist", className);
        return nil; //No plist Dictionary or file found
    }
    
    //4. Get just the mini Dictionary for this animation
    NSDictionary *animationSettings = [plistDictionary objectForKey:animationName];
    if ( animationSettings == nil ) {
        CCLOG(@"Could not locate AnimationWithName:%@",animationName);
        return nil;
    }
    
    //5. Get the delay value for animation
    float animationDelay = [[animationSettings objectForKey:@"delay"] floatValue];
    animationToReturn = [CCAnimation animation];
    [animationToReturn setDelay:animationDelay];
    
    //6. Add the frames to the animation
    NSString *animationFramePrefix = [animationSettings objectForKey:@"filenamePrefix"];
    NSString *animationFrames = [animationSettings objectForKey:@"animationFrames"];
    NSArray *animationFrameNumbers = [animationFrames componentsSeparatedByString:@","];
    
    for ( NSString *frameNumber in animationFrameNumbers ) {
        NSString *frameName = [NSString stringWithFormat:@"%@%@.png", animationFramePrefix, frameNumber];
        [animationToReturn addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }
    
    return animationToReturn;
    
}




@end
