"
Circular board class for board game; has a number of rounds to play in the same board.
"
Class {
	#name : 'CircularBoard',
	#superclass : 'Object',
	#instVars : [
		'rounds',
		'lastSquareEffectUsed',
		'map',
		'boardSize'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CircularBoard class >> withMap: aMap ofSize: aBoardSize andNumberOfRounds: aNumberOfRounds [

	^ self new initializeWithMap: aMap ofSize: aBoardSize andNumberOfRounds: aNumberOfRounds
]

{ #category : 'process' }
CircularBoard >> applyLastSquareEffectTo: aShip in: aGame [

	lastSquareEffectUsed ifNotNil: [ lastSquareEffectUsed applyEffectTo: aShip in: aGame ]
]

{ #category : 'accessing' }
CircularBoard >> getSquareAt: aPosition [

	^ map at: aPosition - 1 \\ boardSize + 1
]

{ #category : 'initialization' }
CircularBoard >> initializeWithMap: aMap ofSize: aBoardSize andNumberOfRounds: aNumberOfRounds [

	boardSize := aBoardSize.

	map := aMap copy.

	rounds := aNumberOfRounds.
]

{ #category : 'accessing' }
CircularBoard >> lastEffectUsed: aSpecialSquare [

	| onlySpecialSquares |
	onlySpecialSquares := { AtomicBomb. MoonWalk. CardGiver. HyperJump. Wormhole .BlackHole .HyperSpaceJump}.

	(onlySpecialSquares anySatisfy: [ :class | aSpecialSquare isKindOf: class ])
		ifTrue: [ lastSquareEffectUsed := aSpecialSquare].
		

]

{ #category : 'accessing' }
CircularBoard >> lastSquareEffectUsed [

	^ lastSquareEffectUsed 
]

{ #category : 'process' }
CircularBoard >> resolveMovementOf: anIntendedPosition [

	| finalPosition completedLaps |
	
	completedLaps := 0.
	(anIntendedPosition > boardSize or: anIntendedPosition < 1) ifTrue: [
		completedLaps := anIntendedPosition - 1 // boardSize ].

	finalPosition := anIntendedPosition - 1 \\ boardSize + 1.

	^ {
		  (map at: finalPosition).
		  completedLaps } "Devuelvo tupla de ubicacion final a la que debe ir el Ship y vuelta en la que esta"
]

{ #category : 'accessing' }
CircularBoard >> size [

	^ boardSize 
]

{ #category : 'validation' }
CircularBoard >> wasThisTheLastRoundFor: aShip [

	^ aShip laps >= (rounds + 1) "+1 Ya que conisderamos que las naves empiezan en la lap 1"
]
