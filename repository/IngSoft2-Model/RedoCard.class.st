"
Implementation of redo card, from the instantaneous type of cards.
"
Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
RedoCard >> isRepeatable [

	^ false
]

{ #category : 'testing' }
RedoCard >> isTurnRestricted [

	^ false
]

{ #category : 'action handling' }
RedoCard >> managedBy: aCardManager from: anActivatorShip target: aTarget [

	aCardManager getLastRepeatableUsedCard
		managedBy: aCardManager
		from: anActivatorShip
		target: aTarget
]
