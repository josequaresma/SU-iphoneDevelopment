//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jose Quaresma on 2/4/13.
//  Copyright (c) 2013 Jose Quaresma. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards; //of Card

@property (readwrite, nonatomic) int score;
@property (nonatomic, readwrite) NSString *lastMoveDescription;

@end

@implementation CardMatchingGame

- (NSString *)lastMoveDescription
{
    if (!_lastMoveDescription) _lastMoveDescription = @"New deck";
    return _lastMoveDescription;
}


- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i=0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card)
            {
                self = nil;
            }
            else
            {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            
            NSMutableArray *tmp = [[NSMutableArray alloc] init];
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [tmp addObject:otherCard];
                    if ((!self.isIn3CardMode) || ([tmp count] > 1)) {
                        break;
                    }
                }
            }
            
            if ((self.isIn3CardMode && ([tmp count] == 2)) || (!self.isIn3CardMode && ([tmp count] == 1))) {
                
                NSLog(@"array size: %d", [tmp count]);
                
                int matchScore = [card match:tmp];
                NSMutableArray *print = [[NSMutableArray alloc] initWithArray:tmp]; //copy the references??
                [print addObject:card];
                
                if (matchScore) {
                    for (Card *card in print) {
                        card.unplayable = YES;
                    }
                    self.score += matchScore * MATCH_BONUS;
                    self.lastMoveDescription = [NSString stringWithFormat:@"Matched %@ for %d points",
                                                [print componentsJoinedByString:@" and "], matchScore * MATCH_BONUS];
                } else
                {
                    for (Card *card in tmp) {
                        card.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.lastMoveDescription = [NSString stringWithFormat:@"%@ don't match! %d points penalty!",
                                                [print componentsJoinedByString:@" and "], MISMATCH_PENALTY];
                }
            } else
            {
                self.lastMoveDescription = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            self.score -= FLIP_COST;
        } else
        {
            self.lastMoveDescription = [NSString stringWithFormat:@"Flipped down %@", card.contents];
        }
        card.faceUp = !card.isFaceUp;
    }
}


@end
