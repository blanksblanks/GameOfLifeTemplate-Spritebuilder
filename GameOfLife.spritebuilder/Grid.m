//
//  Grid.m
//  GameOfLife
//
//  Created by Nina Baculinao on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h" // import because we'll be creating creatures

// these are variables that cannot be changed
// we define these two constants to describe the amount of rows and columns
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray; // a 2d array that stores all the creatures in our grid
    float _cellWidth; // these two varsused to place creatures on grid correctly
    float _cellHeight;
}

- (void)onEnter // method to activate touch handling on the grid
{
    [super onEnter];
    
    [self setupGrid]; // create method next
    
    // accept touches on the grid
    self.userInteractionEnabled = YES;
}

- (void)setupGrid
{
    // divide the grid's size by the number of columns/rows to figure out the right width and height of each cell
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    // initialize the array as a blank NSMutableArray
    _gridArray = [NSMutableArray array];
    
    // initialize Creatures
    for (int i = 0; i < GRID_ROWS; i++) {
        // this is how you create two dimensional arrays in Objective-C. You put arrays into arrays.
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            
            // this is shorthand to access an array inside an array
            _gridArray[i][j] = creature;
            
            // make creatures visible to test this method, remove this once we know we have filled the grid properly
            // creature.isAlive = YES;
            
            x+=_cellWidth; // after positinioning a Creature we increase x variable
        }
        
        y += _cellHeight; // after completing row we increase y variable
    }
}

// getting touches is easy in Cocos2D because any class that is a CCNode or inherits from it will automatically call a method called touchBegan when the player touches it. All we need to do is create a touchBegan method and it gets called automatically (because we userInteractionEnabled to Yes earlier)
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    //get the Creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    // create creatureFortouchPosition method next
    
    //invert it's state - kill it if it's alive, bring it to life if it's dead.
    creature.isAlive = !creature.isAlive;
    // when you access a property you've created like isAlive a method called setPropertyName is atuomatically called. In this case, setIsAlive. If you don't create one yourself, it'll just set the property to whatever you pass in. In our case, we created a custom one in Creature.m that not only sets the property, but makes Creatures' visibility change depending on their state as well! This is why your Creatures will automatically go from visible to invisible when you tap on them.
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    //get the row and column that was touched, return the Creature inside the corresponding cell
    int row = touchPosition.y/_cellHeight;
    int column = touchPosition.x/_cellWidth;
    return _gridArray[row][column];
}

@end
