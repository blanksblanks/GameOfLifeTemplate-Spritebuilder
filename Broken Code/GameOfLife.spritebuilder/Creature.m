//
//  Creature.m
//  GameOfLife
//
//  Created by Nina Baculinao on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

// it's okay not to have super in init so long as it goes back to an init that did have super in the file
//- (instancetype) init {
//    return [self initCreature];
//}

// initializer sets image of creature to bubble.png and initializes them as not alive
- (instancetype)initCreature {
    // since we made Creature inherit from CCSprite, 'super' below refers to CCSprite
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
        // [self setIsAlive:NO];
        // _isAlive = NO;
    }
    
    return self;
}

// this method creates a setter to be called when isAlive property is changed
// when creature is alive it's visible, when dead it disappears
- (void)setIsAlive:(BOOL)newState {
    // when you create an @property as we did in the .h, an instance variable with a leading underscore is automatically created for you
    _isAlive = newState;
    
    // 'visible' is a property of any class that inherits from CCNode. CCSprite is a subclass of CCNode, and Creature is a subclass of CCSprite, so Creatures have a visible property
    self.visible = _isAlive;
    // same as [self setVisible:_isAlive];
    
    // just as these are the same
    // BOOL currentlyVisible;
    // currentlyVisible = [self visible];
    // currentlyVisible = self.visible;
    
    // method/dot syntax vs _variableName
    // dot syntax calls the method
    // just underscore just sets the variable
}

//setter
//- (void)setIsAlive:(BOOL)newState {
//    _isAlive = newState;
//}
//
//getter
//- (BOOL)isAlive {
//    return _isAlive;
//}


@end
