Class {
	#name : #Hand,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Hand class >> assertValid: collectionOfCards [
	
	collectionOfCards size == 2 ifFalse: [ 
		Error signal: 'Hand must be initialized with 2 cards' ]
]

{ #category : #'instance creation' }
Hand class >> with: collectionOfCards [
	self assertValid:  collectionOfCards.
	^self initializedWith: collectionOfCards
]
