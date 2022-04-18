Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'position',
		'id'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> with: anId [
	
	^ self new initializeWith: anId.
]

{ #category : #actions }
Ship >> advances: anInteger [ 
	position := position + anInteger .
]

{ #category : #getters }
Ship >> getId [
	^ id.
]

{ #category : #initialization }
Ship >> initializeWith: anId [
	position := 0.
	id := anId.
]

{ #category : #'accessing - attributes' }
Ship >> isInPosition [
	^position 
]

{ #category : #methods }
Ship >> playsWith: aDiceCup [
	position := position + ( aDiceCup roll ).
]
