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
    if (!_lastMoveDescription) _lastMoveDescription = @"description of last move :)";
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
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.lastMoveDescription = [NSString stringWithFormat:@"Matched %@ and %@ for %d points",
                                                    card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                    } else
                    {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.lastMoveDescription = [NSString stringWithFormat:@"%@ and %@ don't match! %d points penalty!",
                                                    card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                } else
                {
                    self.lastMoveDescription = [NSString stringWithFormat:@"Flipped up %@", card.contents];
                }
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
