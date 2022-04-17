Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ship class >> start [
	^self new withPosition: 0.
]

{ #category : #actions }
Ship >> advances: anInteger [ 
	position := position + anInteger .
]

{ #category : #'accessing - attributes' }
Ship >> isInPosition [
	^position 
]

{ #category : #methods }
Ship >> playsWith: aLoadedDie in: aBoard [ 
	position := position + ( aLoadedDie roll ).
]

{ #category : #initialization }
Ship >> withPosition: anInteger [ 
	position := anInteger.
]
