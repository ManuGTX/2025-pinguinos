Class {
	#name : 'ReversePolarityCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ReversePolarityCardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnAtomicBombNothingHappensWhenActivated [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 4. 3 }) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('AtomicBombs' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aGame nextTurn. "Mueve jorge"

	aDeck := aGame cardsOf: julianShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: julianShip target: 4. "Aplico reversePolarity en la bomba del casillero 4"

	aGame nextTurn. "Mueve julian"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
				
	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 3.

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnAtomicBombTwiceItsEfectStaysTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('AtomicBombs' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en la bomba del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult.

	aGame playCard: aReversePolarityCard by: julianShip target: 4. "Aplico reversePolarity de nuevo en la bomba  del casillero 4"
	aGame nextTurn. "Mueve julian, cae y se activa la bomba"

	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: jorgeShip remainingShields equals: 2.
	self assert: julianShip remainingShields equals: 2.

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnBlackHoleIfShipThatIsMovedBackFallsOnAnotherSpecialSquareItsEffectIsNotApplied [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: { ('BlackHoles' -> { 4 }) . ('AtomicBombs' -> { 7 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.
	
	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en el blackhole del casillero 4"
	
	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 7).
				 ('lap' -> 0).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnBlackHoleItsEfectIsReversed [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: { ('BlackHoles' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.
	
	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en el blackhole del casillero 4"
	
	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 7).
				 ('lap' -> 0).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnBlackHoleTwiceItsEfectStaysTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 7 }) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('BlackHoles' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en el blackhole del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 7).
				 ('lap' -> 0).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult.

	aGame playCard: aReversePolarityCard by: julianShip target: 4. "Aplico reversePolarity de nuevo en el blackhole del casillero 4"
	aGame nextTurn. "Mueve julian"
	
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 10).
				 ('lap' -> 0).
				 ('card count' -> 1) }).
				
	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnCardGiverItsEfectIsReversed [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('CardGivers' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en el card giver del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 3) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnCardGiverTwiceItsEfectStaysTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('CardGivers' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en el card giver del casillero 4"
	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en el card giver del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnHyperSpaceJumpItsEfectIsReversed [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperSpaceJumps' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en el HyperSpaceJump del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 2.
	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnHyperSpaceJumpTwiceItsEfectStaysTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperSpaceJumps' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en el HyperSpaceJump del casillero 4"
	aGame playCard: aReversePolarityCard by: jorgeShip target: 4. "Aplico reversePolarity en el HyperSpaceJump del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 8).
				 ('lap' -> 1).
				 ('card count' -> 0) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: jorgeShip remainingShields equals: 2.
	self assert: julianShip remainingShields equals: 3.
	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testCannotUseReversePolarityCardOnEmptySquare [

	| aGame jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: { ('BlackHoles' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.
	
	self
		should: [ aGame playCard: aReversePolarityCard by: jorgeShip target: 3 ]
		raise: Error
		withErrorMessage: 'Cannot reverse the polarity of a non-special square!'
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testReversePolarityCardCannotBePlayedOutsideOfPlayersTurn [

	| aGame expectedResult jorgeShip julianShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
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
	aCard := aDeck first.

	aGame nextTurn. "Jorge juega su turno"
	
	"Jorge intenta usar carta permanente en turno de otro y falla"
	self
		should: [ aGame playCard: aCard by: jorgeShip ]
		raise: Error
		withErrorMessage: 'This ship cannot play this card because it is not his turn!'.

	aGame nextTurn.

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]
