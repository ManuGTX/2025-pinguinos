"
card that does nothing
"
Class {
	#name : 'NullCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
NullCard >> isRepeatable [

	^ false
]

{ #category : 'testing' }
NullCard >> isTurnRestricted [

	^ false
]

{ #category : 'action handling' }
NullCard >> managedBy: aCardManager from: anActivatorShip target: aTargetShip [

	^ self
]
