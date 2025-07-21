Class {
	#name : 'RandomDistributionOfSpecialSquaresTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
RandomDistributionOfSpecialSquaresTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
RandomDistributionOfSpecialSquaresTest >> testAfterCreatingABoardOfSize100WithSpecialDistributionOfSquaresWeSeeTheDistributionOfTypesIsAsExpected [

	| aBoard classCounts boards numberOfBoards squareDistribution |
	
	squareDistribution := Dictionary newFrom: {
			                      ('Black Hole' -> 44).
			                      ('Hyper Space Jump' -> 10).
			                      ('Moon Walk' -> 10).
			                      ('Hyper Jump' -> 8).
			                      ('Atomic Bomb' -> 20).
			                      ('Empty' -> 3).
			                      ('Card Giver' -> 5) }.

	classCounts := Dictionary new.
	numberOfBoards := 1000.

	"dict['nombre clase'] = { numero de ocurrencias . probabilidad de aparecer de cada clase de cuadrado }"
	classCounts at: 'EmptySquare' put: {
			0.
			(squareDistribution at: 'Empty') }.
	classCounts at: 'Blackhole' put: {
			0.
			(squareDistribution at: 'Black Hole') }.
	classCounts at: 'HyperSpaceJump' put: {
			0.
			(squareDistribution at: 'Hyper Space Jump') }.
	classCounts at: 'MoonWalk' put: {
			0.
			(squareDistribution at: 'Moon Walk') }.
	classCounts at: 'HyperJump' put: {
			0.
			(squareDistribution at: 'Hyper Jump') }.
	classCounts at: 'AtomicBomb' put: {
			0.
			(squareDistribution at: 'Atomic Bomb') }.
	classCounts at: 'CardGiver' put: {
			0.
			(squareDistribution at: 'Card Giver') }.

	boards := OrderedCollection new.
	aBoard := CircularBoardBuilder
		          buildWithSize: 100
		          withNumberOfRounds: 2
		          andDistribution: squareDistribution.

	numberOfBoards timesRepeat: [
		boards add: (CircularBoardBuilder
				 buildWithSize: 100
				 withNumberOfRounds: 2
				 andDistribution: squareDistribution) ].

	boards do: [ :board |
		1 to: 100 do: [ :i |
			| className |
			className := (board getSquareAt: i) class asString.
			(classCounts at: className)
				at: 1
				put: (classCounts at: className) first + 1 ] ].

	classCounts keysAndValuesDo: [ :className :value |
		self assert:
			(value first / numberOfBoards >= (value second - 1.5) and:
				 value first / numberOfBoards <= (value second + 1.5)) ]
]

{ #category : 'tests' }
RandomDistributionOfSpecialSquaresTest >> testCannotCreateBoardWithNegativeProbabilitiesForSquares [

	| squareDistribution |
	squareDistribution := Dictionary newFrom: {
			                      ('Black Hole' -> 44).
			                      ('Hyper Space Jump' -> 10).
			                      ('Moon Walk' -> 10).
			                      ('Hyper Jump' -> -8).
			                      ('Atomic Bomb' -> 20).
			                      ('Empty' -> 3).
			                      ('Card Giver' -> 5) }.

	self
		should: [
			CircularBoardBuilder
				buildWithSize: 100
				withNumberOfRounds: 2
				andDistribution: squareDistribution ]
		raise: Error
		withMessageText: 'The probability for each type of square must be between 1 and 100!'
]

{ #category : 'tests' }
RandomDistributionOfSpecialSquaresTest >> testCannotCreateBoardWithProbabilitiesThatAreNotIntegers [

	| squareDistribution |
	squareDistribution := Dictionary newFrom: {
			                      ('Black Hole' -> 44).
			                      ('Hyper Space Jump' -> 10).
			                      ('Moon Walk' -> 12).
			                      ('Hyper Jump' -> 7).
			                      ('Atomic Bomb' -> 20).
			                      ('Empty' -> 3.5).
			                      ('Card Giver' -> 3.5) }.

	self
		should: [
			CircularBoardBuilder
				buildWithSize: 100
				withNumberOfRounds: 2
				andDistribution: squareDistribution ]
		raise: Error
		withMessageText: 'The probability for each type of square must be an integer!'
]

{ #category : 'tests' }
RandomDistributionOfSpecialSquaresTest >> testCannotCreateBoardWithProbabilitiesThatAreStrings [

	| squareDistribution |
	squareDistribution := Dictionary newFrom: {
			                      ('Black Hole' -> 44).
			                      ('Hyper Space Jump' -> 10).
			                      ('Moon Walk' -> 12).
			                      ('Hyper Jump' -> 7).
			                      ('Atomic Bomb' -> 20).
			                      ('Empty' -> 'hola').
			                      ('Card Giver' -> 3.5) }.

	self
		should: [
			CircularBoardBuilder
				buildWithSize: 100
				withNumberOfRounds: 2
				andDistribution: squareDistribution ]
		raise: Error
		withMessageText: 'The probability for each type of square must be an integer!'
]

{ #category : 'tests' }
RandomDistributionOfSpecialSquaresTest >> testCannotCreateBoardWithProbabilitiesThatDontAddUpTo100 [

	| squareDistribution |
	squareDistribution := Dictionary newFrom: {
			                      ('Black Hole' -> 44).
			                      ('Hyper Space Jump' -> 10).
			                      ('Moon Walk' -> 10).
			                      ('Hyper Jump' -> 7).
			                      ('Atomic Bomb' -> 20).
			                      ('Empty' -> 3).
			                      ('Card Giver' -> 5) }.

	self
		should: [
			CircularBoardBuilder
				buildWithSize: 100
				withNumberOfRounds: 2
				andDistribution: squareDistribution ]
		raise: Error
		withMessageText: 'Adding up every probability should result in a probability of 100!'
]
