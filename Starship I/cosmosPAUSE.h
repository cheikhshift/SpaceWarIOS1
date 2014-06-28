//
//  cosmosPAUSE.h
//  Starship I
//
//  Created by user on 6/17/14.
//  Copyright (c) 2014 My World Entertainment LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GADBannerView.h"
@interface cosmosPAUSE : SKScene {
    GADBannerView *bannerView_;
}


-(id)initWithSize:(CGSize)size score: (NSInteger)player_score ifreplay:(NSInteger) which_level;

@end
