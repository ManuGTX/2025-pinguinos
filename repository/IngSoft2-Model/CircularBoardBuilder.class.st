"
A class that represents a circular board builder
"
Class {
	#name : 'CircularBoardBuilder',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
CircularBoardBuilder class >> buildWithSize: aSize rounds: aRoundNumber withSpecialSquaresAt: squarePositions [

	^ CircularBoard buildWithSize: aSize rounds: aRoundNumber withSpecialSquaresAt: squarePositions
]

{ #category : 'building' }
CircularBoardBuilder class >> buildWithSize: aBoardSize withNumberOfRounds: aRoundNumber andDistribution: aDistribution [ 

	| blackHoles hyperSpaceJumps moonWalks hyperJumps atomicBombs resultForEachCell cardGivers emptySquares currentProbability |
	
	self checkDistribution: aDistribution.
	
	blackHoles := OrderedCollection new.
	hyperSpaceJumps := OrderedCollection new.
	moonWalks := OrderedCollection new.
	hyperJumps := OrderedCollection new.
	atomicBombs := OrderedCollection new.
	cardGivers := OrderedCollection new.
	emptySquares := OrderedCollection new.
	
	"Tiro un numero random por cada casillero "
	resultForEachCell := OrderedCollection new.
	aBoardSize timesRepeat: [ resultForEachCell add: (1 to: 100) atRandom ].
	
	currentProbability := 100 - (aDistribution at: 'Empty').
	
	resultForEachCell doWithIndex: [ :result :i |
		(result between: currentProbability and: 100) ifTrue: [ emptySquares add: i ] ].

	resultForEachCell doWithIndex: [ :result :i |
		(result between: (currentProbability - (aDistribution at: 'Card Giver')) and: currentProbability) ifTrue: [ cardGivers add: i ] ].
	currentProbability := currentProbability - (aDistribution at: 'Card Giver').
	
	resultForEachCell doWithIndex: [ :result :i |
		(result between: (currentProbability - (aDistribution at: 'Black Hole')) and: currentProbability) ifTrue: [ blackHoles add: i ] ].
	currentProbability := currentProbability - (aDistribution at: 'Black Hole').

	resultForEachCell doWithIndex: [ :result :i |
		(result between: (currentProbability - (aDistribution at: 'Hyper Space Jump')) and: currentProbability) ifTrue: [ hyperSpaceJumps add: i ] ].
	currentProbability := currentProbability - (aDistribution at: 'Hyper Space Jump').

	resultForEachCell doWithIndex: [ :result :i |
		(result between: (currentProbability - (aDistribution at: 'Moon Walk')) and: currentProbability) ifTrue: [ moonWalks add: {i. (1 to: 5) atRandom} ] ].  "{posicion. N del moonwalk}"
	currentProbability := currentProbability - (aDistribution at: 'Moon Walk').

	resultForEachCell doWithIndex: [ :result :i |
		(result between: (currentProbability - (aDistribution at: 'Hyper Jump')) and: currentProbability) ifTrue: [ hyperJumps add: i ] ].
	currentProbability := currentProbability - (aDistribution at: 'Hyper Jump').
	
	resultForEachCell doWithIndex: [ :result :i |
		(result between: (currentProbability - (aDistribution at: 'Atomic Bomb')) and: currentProbability) ifTrue: [ atomicBombs add: i ] ].
	currentProbability := currentProbability - (aDistribution at: 'Atomic Bomb').
	
	^ (CircularBoard buildWithSize: aBoardSize rounds: aRoundNumber withSpecialSquaresAt: (Dictionary newFrom: {
				 ('BlackHoles' -> blackHoles).
				 ('HyperSpaceJumps' -> hyperSpaceJumps).
				 ('MoonWalks' -> moonWalks).
				 ('HyperJumps' -> hyperJumps).
				 ('AtomicBombs' -> atomicBombs).
 				 ('EmptySquares' -> emptySquares ). 
				 ('CardGivers' -> cardGivers )}))
]

{ #category : 'verification' }
CircularBoardBuilder class >> checkDistribution: aDistribution [

	| totalProbability |
	
	aDistribution valuesDo: [ :squareProbability |
		squareProbability isInteger ifFalse: [ Error signal: 'The probability for each type of square must be an integer!' ].
		(squareProbability between: 0 and: 100) ifFalse: [
			Error signal:
				'The probability for each type of square must be between 1 and 100!' ] ].

	totalProbability := aDistribution values
		                    inject: 0
		                    into: [ :sum :probability | sum + probability ].

	totalProbability = 100 ifFalse: [
		Error signal:
			'Adding up every probability should result in a probability of 100!' ]
]
