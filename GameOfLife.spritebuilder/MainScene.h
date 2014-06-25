//
//  MainScene.h
//  GameOfLife
//
//  Created by Nina Baculinao on 6/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface MainScene : CCSprite

- (void)evolveStep;
- (int)countNeighbors;
- (BOOL)updateCreatures;

@end
