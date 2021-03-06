//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jose Quaresma on 2/3/13.
//  Copyright (c) 2013 Jose Quaresma. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeButton;

@end

@implementation CardGameViewController

- (IBAction)gameModeControl:(UISegmentedControl *)sender {
    self.game.in3CardMode = (sender.selectedSegmentIndex == 1) ? YES : NO;
    NSLog(@"changing game mode to %d", sender.selectedSegmentIndex);
}

- (IBAction)dealButton {
    self.game = nil;
    self.flipCount = 0;
    [self.gameModeButton setEnabled:YES];
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
        _game.in3CardMode = (self.gameModeButton.selectedSegmentIndex == 1) ? YES : NO;
    }
    return _game;
}


- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.jpeg"];
    UIImage *noImage = [UIImage imageNamed:@"white.jpeg"];;
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        if (!card.isFaceUp) {
            [cardButton setBackgroundImage:cardBackImage forState:UIControlStateNormal];
        } else
        {
            [cardButton setBackgroundImage:noImage forState:UIControlStateSelected];
            [cardButton setBackgroundImage:noImage forState:UIControlStateSelected|UIControlStateDisabled];
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastMoveLabel.text = self.game.lastMoveDescription;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender
{
    if (self.flipCount == 0) {
        [self.gameModeButton setEnabled:NO];
    }
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}
@end
