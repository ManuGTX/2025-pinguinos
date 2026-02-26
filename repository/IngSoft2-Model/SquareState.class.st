"
An abstract class that represents the state of a square
"
Class {
	#name : 'SquareState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
SquareState class >> isAbstract [

	^ self == SquareState
]

{ #category : 'action' }
SquareState >> applyEffectFrom: aSquare to: aShip in: aGame [ 
	
	self subclassResponsibility 
]

{ #category : 'highlighting' }
SquareState >> reverse [

	self subclassResponsibility 
]
