Class {
	#name : #Hand,
	#superclass : #Object,
	#instVars : [
		'cardsInHand'
	],
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
	^self new initializedWith: collectionOfCards
]

{ #category : #attributes }
Hand >> cards [
	^ cardsInHand
]

{ #category : #initialization }
Hand >> initializedWith: aCollectionOfCards [
	cardsInHand := aCollectionOfCards.
]

{ #category : #action }
Hand >> throw: aCard [

	| cardToThrow |
	cardToThrow := nil.
	cardsInHand do: [ :card | 
		card = aCard ifTrue: [ cardToThrow := card ] ].
	cardToThrow
		ifNil: [ Error signal: 'Card is not in Hand' ]
		ifNotNil: [ ^ cardToThrow ]
]
