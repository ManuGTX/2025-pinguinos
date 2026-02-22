"
A permanent card that inverts the target of a particular square.
"
Class {
	#name : 'ReversePolarityCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validating' }
ReversePolarityCard >> checkIfSquareIsSpecial: aSquare [

	aSquare isSpecial ifFalse: [
		Error signal: 'Cannot reverse the polarity of a non-special square!' ]
]

{ #category : 'testing' }
ReversePolarityCard >> isRepeatable [

	^ true
]

{ #category : 'testing' }
ReversePolarityCard >> isTurnRestricted [

	^ true
]

{ #category : 'action handling' }
ReversePolarityCard >> managedBy: aCardManager from: anActivatorShip target: aSquare [

	self checkIfSquareIsSpecial: aSquare.
	aSquare reversePolarity.
]
