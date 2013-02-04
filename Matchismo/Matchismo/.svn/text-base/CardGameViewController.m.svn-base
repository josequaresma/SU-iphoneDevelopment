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

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (strong, nonatomic) PlayingCardDeck *myDeck;

@end

@implementation CardGameViewController

- (PlayingCardDeck *)myDeck{
    if(!_myDeck) { _myDeck = [[PlayingCardDeck alloc] init]; }
    return _myDeck;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender
{
    
    if(sender.selected){
        sender.selected = !sender.selected;
        self.flipCount++;
    } else {
        PlayingCard *myCard = (PlayingCard *)[self.myDeck drawRandomCard];
        
        if (myCard) {
            [sender setTitle:[myCard contents] forState:UIControlStateSelected];
            sender.selected = !sender.selected;
            self.flipCount++;
        } else {
            
            //  Oh noes! Out of cards!
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"All out of cards!"
                                                              message:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:@"Deal again!", nil];
            
            [myAlert show];
            
            //  nil the deck and set the flipCount to 0
            self.myDeck = nil;
            [self setFlipCount:0];
        }
    }
    
}
@end
