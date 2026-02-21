"
Implementation of a loaded deck, that responds to the message: 'draw card', and returns a pre defined card collection in order.
"
Class {
	#name : 'LoadedDeck',
	#superclass : 'Deck',
	#instVars : [
		'cardsToDraw'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'creation' }
LoadedDeck class >> cards: cardsToDraw [

	^ self new initializeWith: cardsToDraw
]

{ #category : 'actions' }
LoadedDeck >> drawCard [

	| drawedCard |
	drawedCard := cardsToDraw removeFirst.
	cardsToDraw addLast: drawedCard.
	^ drawedCard
]

{ #category : 'initialization' }
LoadedDeck >> initializeWith: someCardsToDraw [

	cardsToDraw := someCardsToDraw
]
