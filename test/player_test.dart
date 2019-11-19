import 'dart:async';
import 'package:test/test.dart';
import 'package:wizard/card.dart';
import 'package:wizard/cardType.dart';
import 'package:wizard/deck.dart';
import 'package:wizard/humanPlayer.dart';
import 'package:wizard/ki.dart';
import 'package:wizard/kuenstlicheIntelligenz.dart';

var log = [];

void main() {
  group('ALL:', () {
    group('HumanPlayer:', () {
      group('pickTrumpCard:', () {
        HumanPlayer player = new HumanPlayer('testDummy', 0);
        test('club', () {
          expect(player.pickTrumpCard(testValue: "club"), CardType.CLUB);
        });

        test('heart', () {
          expect(player.pickTrumpCard(testValue: "HEART"), CardType.HEART);
        });

        test('spade', () {
          expect(player.pickTrumpCard(testValue: 'sPade'), CardType.SPADE);
        });

        test('diamond', () {
          expect(player.pickTrumpCard(testValue: 'diamond'), CardType.DIAMOND);
        });
        test('nonsense', () {
          expect(() => player.pickTrumpCard(testValue: 'nonsense'),
              throwsA(TypeMatcher<RangeError>()));
        });
      }); // end pickTrumpCard
      group('putBet:', () {
        HumanPlayer player = new HumanPlayer('testDummy', 0);

        // check general bet
        test('butBet', () {
          //  if we bet 1 , we expect 1 to be our bet
          player.putBet(10, 4, testValue: '1');
          expect(player.bet, 1);
        });

        // check negative bet
        test('negative', overridePrint(() {
          //  if we bet 1 , we expect 1 to be our bet
          player.putBet(10, 4, testValue: '-1');
          expect(log, [
            'Please enter a positive number!',
            'testDummy bet he/she wins -1 tricks!'
          ]);
          log = [];
          player.bet = 0;
        }));
        // check non numeric bet
        test('nonNumeric', overridePrint(() {
          //  if we bet 1 , we expect 1 to be our bet
          player.putBet(10, 4, testValue: 'x');

          expect(log, [
            'Please enter a number!',
            'testDummy bet he/she wins 0 tricks!'
          ]);
          log = [];
        }));
        // check last player puts a wrong bet
        test('lastPlayerBetWrong', overridePrint(() {
          //  the last player can not bet a number that in a sum with the other
          // players bets equals the number of rounds
          player.lastPlayer = true;
          player.putBet(5, 4, testValue: '1');

          expect(log, [
            'Please take another number, because the bets have to differ the possible tricks!',
            'testDummy bet he/she wins 1 tricks!'
          ]);
          log = [];
        }));
      });
    }); // end HumanPlayer

    group('KI:', () {
      group('PickTrumpCard:', (){
        test('club', () {
          Ki ai = new Ki('ki_dummy', 0);
          List<Card> deckList = [new Card(CardType.CLUB, 4), new Card(CardType.JESTER, 0), new Card(CardType.HEART, 5), new Card(CardType.CLUB, 7), new Card(CardType.DIAMOND, 4)];
          Deck deck = new Deck();
          deck.deck = deckList;
          ai.addCard(deck);
          expect(ai.pickTrumpCard(), CardType.CLUB);
        });
        test('spade', () {
          Ki ai = new Ki('ki_dummy', 0);
          List<Card> deckList = [new Card(CardType.SPADE, 4), new Card(CardType.JESTER, 0), new Card(CardType.HEART, 5), new Card(CardType.SPADE, 7), new Card(CardType.DIAMOND, 4)];
          Deck deck = new Deck();
          deck.deck = deckList;
          ai.addCard(deck);
          expect(ai.pickTrumpCard(), CardType.SPADE);
        });
        test('diamond', () {
          Ki ai = new Ki('ki_dummy', 0);
          List<Card> deckList = [new Card(CardType.DIAMOND, 4), new Card(CardType.JESTER, 0), new Card(CardType.DIAMOND, 5), new Card(CardType.CLUB, 7), new Card(CardType.DIAMOND, 4)];
          Deck deck = new Deck();
          deck.deck = deckList;
          ai.addCard(deck);
          expect(ai.pickTrumpCard(), CardType.DIAMOND);
        });
        test('heart', () {
          Ki ai = new Ki('ki_dummy', 0);
          List<Card> deckList = [new Card(CardType.HEART, 4), new Card(CardType.JESTER, 0), new Card(CardType.HEART, 5), new Card(CardType.CLUB, 7), new Card(CardType.DIAMOND, 4)];
          Deck deck = new Deck();
          deck.deck = deckList;
          ai.addCard(deck);
          expect(ai.pickTrumpCard(), CardType.HEART);
        });

        //todo need to test random bei only wiz or jes
      });//end PickTrumpCard
      group('PlayCard:', (){
        Ki ai = new Ki('ai_dummy', 0);    //ai zum testen
//        test('Something esle', () {
//          fail('not yet implemented');
//        });
      });//end PlayCard
      group('PlayCardAi:', (){
        Ki ai = new Ki('ai_dummy', 0);    //ai zum testen

      }); //end PlayCardAi //worthless because its private
      group('PutBet', (){
        Ki ai = new Ki('ai_dummy', 0);    //ai zum testen
//        test('should do it', () {
//          ai.lastPlayer = false;
//          List<Card> handCards = [Card(CardType.HEART, 13), Card(CardType.HEART, 10), Card(CardType.JESTER, 0)];
//          ai.putBet(3, 1, trump: CardType.HEART, alreadyPlayedCards: [], playedCards: []);
//          expect(ai.bet, 1);
//          //todo improve (not ready yet)
//        });
      }); //end PutBet
    }); // end KI
    group('KuenstlicheIntelligenz:', () {
      group('PickTrumpCard:', (){
        test('club', () {
          KuenstlicheIntelligenz ai = new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
          List<Card> deckList = [new Card(CardType.CLUB, 4), new Card(CardType.JESTER, 0), new Card(CardType.HEART, 5), new Card(CardType.CLUB, 7), new Card(CardType.DIAMOND, 4)];
          Deck deck = new Deck();
          deck.deck = deckList;
          ai.addCard(deck);
          expect(ai.pickTrumpCard(), CardType.CLUB);
        });
        test('spade', () {
          KuenstlicheIntelligenz ai = new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
          List<Card> deckList = [new Card(CardType.SPADE, 4), new Card(CardType.JESTER, 0), new Card(CardType.HEART, 5), new Card(CardType.SPADE, 7), new Card(CardType.DIAMOND, 4)];
          Deck deck = new Deck();
          deck.deck = deckList;
          ai.addCard(deck);
          expect(ai.pickTrumpCard(), CardType.SPADE);
        });
        test('diamond', () {
          KuenstlicheIntelligenz ai = new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
          List<Card> deckList = [new Card(CardType.DIAMOND, 4), new Card(CardType.JESTER, 0), new Card(CardType.DIAMOND, 5), new Card(CardType.CLUB, 7), new Card(CardType.DIAMOND, 4)];
          Deck deck = new Deck();
          deck.deck = deckList;
          ai.addCard(deck);
          expect(ai.pickTrumpCard(), CardType.DIAMOND);
        });
        test('heart', () {
          KuenstlicheIntelligenz ai = new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
          List<Card> deckList = [new Card(CardType.HEART, 4), new Card(CardType.JESTER, 0), new Card(CardType.HEART, 5), new Card(CardType.CLUB, 7), new Card(CardType.DIAMOND, 4)];
          Deck deck = new Deck();
          deck.deck = deckList;
          ai.addCard(deck);
          expect(ai.pickTrumpCard(), CardType.HEART);
        });

        //todo need to test random bei only wiz or jes
//        test('nonsense', () {
//
//        });
      });//end PickTrumpCard
      group('PlayCard:', (){

      });//end PlayCard
      group('PlayCardAI:', (){

      }); //end PlayCardAi //worthless because its private
      group('PutBet:', (){

      }); //end PutBet
      group('FindBestCard:', (){

      }); //end FindBestCard
      group('FindWorstCard:', (){

      }); //end FindWorstCard
      //todo kein plan ob private klassen testbar sind
///
      ///
      ///
      group('GetWahrscheinlichkeitBet:', (){

      }); //end GetWahrscheinlichkeitBet
      group('GetWahrscheinlichkeitPlay:', (){

      }); //end GetWahrscheinlichkeitPlay
      group('RemoveCardsFromAiDeck:', (){

      }); //end RemoveCardsFromAiDeck
    }); //end KuenstlicheIntelligenz
    group('Ai:', () {
      group('PickTrumpCard:', (){
        //todo not implemented in class Ai
      });//end PickTrumpCard
      group('PlayCard:', (){

      });//end PlayCard
      group('PlayCardAI:', (){

      }); //end PlayCardAi
      group('PutBet:', (){

      }); //end PutBet
      group('FindCard:', (){

      }); //end FindCard
    }); //end Ai
  }); // end of ALL
}

overridePrint(testFn()) => () {
      var spec = new ZoneSpecification(print: (_, __, ___, String msg) {
        // Add to log instead of printing to stdout
        log.add(msg);
      });
      return Zone.current.fork(specification: spec).run(testFn);
    };
