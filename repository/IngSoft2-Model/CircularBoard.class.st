"
Circular board class for board game; has a number of rounds to play in the same board.
"
Class {
	#name : 'CircularBoard',
	#superclass : 'Object',
	#instVars : [
		'rounds',
		'lastSquareEffectUsed',
		'boardSize',
		'map'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CircularBoard class >> buildWithSize: aSize rounds: aRoundNumber withSpecialSquaresAt: squarePositions [
	
	self validateSquarePositionsAreWithinBounds: squarePositions of: aSize.

	^ (self withSize: aSize rounds: aRoundNumber)
		  initializeWithSpecialSquaresAt: squarePositions
]

{ #category : 'validation' }
CircularBoard class >> validate: aSquareType in: squarePositions areWithinBoundsOf: aSize [

	(squarePositions at: aSquareType ifAbsent: [ {  } ]) do: [
		:squarePosition |
		(squarePosition between: 1 and: aSize) ifFalse: [
			Error signal:
				'Position of ' , aSquareType , ' must be within Bounds of Board!' ] ]
]

{ #category : 'validation' }
CircularBoard class >> validateMoonWalksin: squarePositions areWithinBoundsOf: aSize [

	| moonWalkPositions |
	moonWalkPositions := squarePositions
		                     at: 'MoonWalks'
		                     ifAbsent: [ ^ self ].

	moonWalkPositions do: [ :moonWalkValues |
		(moonWalkValues first between: 1 and: aSize) ifFalse: [ Error signal: 'Position of MoonWalks must be within Bounds of Board!' ] ]
]

{ #category : 'validation' }
CircularBoard class >> validateRoundNumberIsPositive: aRoundNumber [

	aRoundNumber < 1 ifTrue: [
		Error signal: 'Round number for the board must be positive.' ]
]

{ #category : 'validation' }
CircularBoard class >> validateSizeIsPositive: aSize [

	aSize <= 0 ifTrue: [
		Error signal: 'Size for the grid must be positive.' ]
]

{ #category : 'validation' }
CircularBoard class >> validateSquarePositionsAreWithinBounds: squarePositions of: aSize [

	self validate: 'BlackHoles' in: squarePositions areWithinBoundsOf: aSize.
	self validate: 'HyperSpaceJumps' in: squarePositions areWithinBoundsOf: aSize. 
	self validate: 'HyperJumps' in: squarePositions areWithinBoundsOf: aSize. 
	self validate: 'AtomicBombs' in: squarePositions areWithinBoundsOf: aSize. 
	
	self validateWormHolesIn: squarePositions areWithinBoundsOf: aSize.
	self validateMoonWalksin: squarePositions areWithinBoundsOf: aSize. 
]

{ #category : 'validation' }
CircularBoard class >> validateWormHolesIn: squarePositions areWithinBoundsOf: aSize [

	| wormHolePositions |
	
	wormHolePositions := squarePositions
		                     at: 'WormHoles'
		                     ifAbsent: [ ^ self ].
		
	wormHolePositions do: [ :wormHoleEnds |
		Board
			is: wormHoleEnds first
			and: wormHoleEnds second
			withinBoundsOf: aSize ]
		
	
]

{ #category : 'creation' }
CircularBoard class >> withSize: aSize rounds: aRoundNumber [

	self validateRoundNumberIsPositive: aRoundNumber.
	self validateSizeIsPositive: aSize.
	^ self new initializeWithSize: aSize rounds: aRoundNumber
]

{ #category : 'process' }
CircularBoard >> applyLastSquareEffectTo: aShip in: aGame [

	lastSquareEffectUsed ifNotNil: [ lastSquareEffectUsed applyEffectTo: aShip in: aGame ]
]

{ #category : 'accessing' }
CircularBoard >> createAtomicBombsAt: squarePositions [

	squarePositions do: [ :position |
		map at: position put: (AtomicBomb at: position) ]
]

{ #category : 'accessing' }
CircularBoard >> createBlackHolesAt: aSquarePositions [

	aSquarePositions do: [ :position |
"		map at: position put: (Blackhole at: position in: self) ]"
		map at: position put: (Blackhole x: position )]
]

{ #category : 'accessing' }
CircularBoard >> createCardGiversAt: squarePositions [

	squarePositions do: [:position | map at: position put: (CardGiver at: position with: Deck new) ].
]

{ #category : 'accessing' }
CircularBoard >> createEmptySquaresAt: aSquarePositions [
	
	aSquarePositions do: [:position | map at: position put: (EmptySquare at: position) ]
	
]

{ #category : 'accessing' }
CircularBoard >> createHyperJumpsAt: aSquarePositions [

	aSquarePositions do: [ :position |
		map
			at: position
			put: (HyperJump inBoardOfSize: boardSize at: position) ]
]

{ #category : 'accessing' }
CircularBoard >> createHyperSpaceJumpsAt: aSquarePositions [

	aSquarePositions do: [ :position |
		map at: position put: (HyperSpaceJump x: position) ]
]

{ #category : 'accessing' }
CircularBoard >> createMoonWalksAt: squarePositions [

	squarePositions do: [ :position |
		map
			at: position first
			put: (MoonWalk by: position second at: position first) ]
]

{ #category : 'accessing' }
CircularBoard >> createWormHolesAt: squarePositions [

	squarePositions do: [ :position |
		| wormHoleEnds |
		wormHoleEnds := Wormhole from: position first to: position second.

		map at: position first put: wormHoleEnds first.

		map at: position second put: wormHoleEnds second ]
]

{ #category : 'accessing' }
CircularBoard >> getSquareAt: aPosition [

	^ map at: aPosition - 1 \\ boardSize + 1
]

{ #category : 'initialization' }
CircularBoard >> initializeWithSize: aSize [

	boardSize := aSize.

	map := OrderedCollection new.

	1 to: boardSize do: [ :x | map add: (Square x: x) ].
	
]

{ #category : 'initialization' }
CircularBoard >> initializeWithSize: aSize rounds: aRoundNumber [

	self initializeWithSize: aSize. 

	rounds := aRoundNumber.
]

{ #category : 'initialization' }
CircularBoard >> initializeWithSpecialSquaresAt: squarePositions [

	self createBlackHolesAt: (squarePositions at: 'BlackHoles' ifAbsent: [ {} ]).
	self createHyperSpaceJumpsAt: (squarePositions at: 'HyperSpaceJumps' ifAbsent: [ {} ]).
	self createMoonWalksAt: (squarePositions at: 'MoonWalks' ifAbsent: [ {} ]).
	self createHyperJumpsAt: (squarePositions at: 'HyperJumps' ifAbsent: [ {} ]).
	self createAtomicBombsAt: (squarePositions at: 'AtomicBombs' ifAbsent: [ {} ]).
	self createWormHolesAt: (squarePositions at: 'WormHoles' ifAbsent: [ {} ]).
	self createEmptySquaresAt: (squarePositions at: 'EmptySquares' ifAbsent: [ {} ]).
	self createCardGiversAt: (squarePositions at: 'CardGivers' ifAbsent: [ {} ]).
]

{ #category : 'accessing' }
CircularBoard >> lastEffectUsed: aSpecialSquare [

	| onlySpecialSquares |
	onlySpecialSquares := { AtomicBomb. MoonWalk. CardGiver. HyperJump. Wormhole .Blackhole .HyperSpaceJump}.

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
