Class {
	#name : 'ReversalCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ReversalCardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
ReversalCardTest >> testReversalCardCanBeUsedCorrectlyEvenWhenItsNotYourTurn [

	| aGame jorgeShip julianShip aDeck aSpeedCard aReversalCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	
	"cartas jorge"
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	
	"cartas Julian"
	cardsToDraw add: ReversalCard new.
	cardsToDraw add: SpeedCard new.
			
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aSpeedCard := aDeck first.

	aGame playCard: aSpeedCard by: jorgeShip. "Jorge juega SpeedCard sobre el mismo"

	aDeck := aGame cardsOf: julianShip.
	aReversalCard := aDeck first.
	aGame playCard: aReversalCard by: julianShip target: aSpeedCard. "Julian juega ReversalCard sobre el SpeedCard de Jorge"
	
	aGame nextTurn. "jorge se mueve 3-1 espacios a 3"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'tests' }
ReversalCardTest >> testReversalCardCanBeUsedCorrectlyOnAnActiveSpeedCard [

	| aGame jorgeShip julianShip aDeck aSpeedCard aReversalCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	
	"cartas jorge"
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	
	"cartas Julian"
	cardsToDraw add: ReversalCard new.
	cardsToDraw add: SpeedCard new.
			
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aSpeedCard := aDeck first.

	aGame playCard: aSpeedCard by: jorgeShip. "Jorge juega SpeedCard sobre el mismo"
	aGame nextTurn. "jorge se mueve 3+1 espacios a 5"

	aDeck := aGame cardsOf: julianShip.
	aReversalCard := aDeck first.

	aGame playCard: aReversalCard by: julianShip target: aSpeedCard. "Julian juega ReversalCard sobre el SpeedCard de Jorge"
	aGame nextTurn. "julian mueve 3 espacios a 4"

	aGame nextTurn. "jorge mueve 3-1 espacios a 7"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 7).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'tests' }
ReversalCardTest >> testReversalCardCantBeUsedOnAnInactiveCard [

	| aGame jorgeShip julianShip aDeck aSpeedCard aReversalCard cardsToDraw |
	
	cardsToDraw := OrderedCollection new.
	
	"cartas jorge"
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	
	"cartas Julian"
	cardsToDraw add: ReversalCard new.
	cardsToDraw add: SpeedCard new.
			
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aSpeedCard := aDeck first.

	aDeck := aGame cardsOf: julianShip.
	aReversalCard := aDeck first.

	self
		should: [ aGame playCard: aReversalCard by: julianShip target: aSpeedCard ]
		raise: Error
		withErrorMessage: 'The selected card is not active at the moment, so it cannot be reversed!'.
	



]
