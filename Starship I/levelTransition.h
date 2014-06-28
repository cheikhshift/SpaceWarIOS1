//
//  levelTransition.h
//  Starship I
//
//  Created by user on 6/18/14.
//  Copyright (c) 2014 My World Entertainment LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "cosmosMyScene.h"

@interface levelTransition : SKScene
-(id)initWithSize:(CGSize)size score: (NSInteger)player_score next:(NSInteger) which_level caption:(NSString *) text;

@end
