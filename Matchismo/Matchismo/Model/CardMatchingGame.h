//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jose Quaresma on 2/4/13.
//  Copyright (c) 2013 Jose Quaresma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSString *lastMoveDescription;
@property (nonatomic, readonly) int score;
@property (nonatomic, getter = isIn3CardMode) BOOL in3CardMode;

@end
