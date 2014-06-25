//
//  MainScene.m
//  GameOfLife
//
//  Created by Nina Baculinao on 6/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"

@implementation MainScene {
    Grid *_grid;
    CCTimer *_timer;
    CCLabelTTF *_generationLabel;
    CCLabelTTF *_populationLabel;
}

- (id) init
{
    self = [super init];
    
    if (self) {
        _timer = [[CCTimer alloc] init];
    }
    
    return self;
}

- (void)play
{
    // this tells the game to call a method called 'step' every half sec
    [self schedule:@selector(step) interval:0.5f];
}

- (void)pause
{
    [self unschedule:@selector(step)];
}

// this method will get called every half sec when you hit play
// and it will stop when you hit pause
- (void)step
{
    [_grid evolveStep];
    _generationLabel.string = [NSString stringWithFormat:@"%d", _grid.generation];
    _populationLabel.string = [NSString stringWithFormat:@"%d", _grid.totalAlive];
}

- (void)evolveStep
{
    // update each Creature's neighbor count
    [self countNeighbors];
    
    // update each Creature's state
    [self updateCreatures];
    
    // update the generation so the label's text will display the correct generation
    
    _generation++;
}

- (int)countNeighbors
{
    // iterate through the rows
    // note that NSArray has a method 'count' that will return the number of elements in the array
    for (int i = 0; i < [_gridArray count]; i++)
    {
        // iterate through all the columns for a given row
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            // access the creatures in the cell that corresponds to current row/column
            Creature *currentCreature = _gridArray[i][j];
            
            // remember that every creature has a 'livingNeighbors' property that we created earlier
            currentCreature.livingNeighbors = 0;
            
            // now examine every cell around the current one
            
            // go through the row on top, below and where the current cell is
            for (int x = (i-1); x <= (i+1); x++)
            {
                // go through the column to left, right and where the cell is
                for (int y = (j-1); y <= (j+1); y++)
                {
                    // check that the cell we're checking isn't off the screen
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX: x andY:y];
                    
                    // skip over all cells that are off screen
                    // AND cell that contains creature we are updating
                    if (!((x == i) && (y == j)) && isIndexValid)
                    {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive)
                        {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                }
            }
            
        }
    }
    
}

- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if (x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

- (BOOL)updateCreatures
{
    int numAlive = 0;

    for (int i = 0; i < [_gridArray count]; i++)
    {
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            if (currentCreature.livingNeighbors == 3)
            {
                currentCreature.isAlive = True;
            }
            else if (currentCreature.livingNeighbors <= 1 || current.Creature.livingNeighbors >= 4)
            {
                currentCreature.isAlive = False;
            }
        }
    }

    
    
}

@end
