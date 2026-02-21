"
a deck of cards that does nothing

"
Class {
	#name : 'NullDeck',
	#superclass : 'Deck',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
NullDeck >> drawCard [
	
	^ NullCard new
]
