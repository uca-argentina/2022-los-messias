Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Deck class >> withAll: aCollectionOfCards [
	^self new initializeWithAll: aCollectionOfCards 
]

{ #category : #actions }
Deck >> generate: aNumberOfCards [ 
	| cardsGenerated |
	cardsGenerated := OrderedCollection new.
	 1 to: aNumberOfCards do: [ :i | cardsGenerated add: (cards atRandom)].
	^cardsGenerated
]

{ #category : #initalization }
Deck >> initializeWithAll: aCollectionOfCards [
	cards:= aCollectionOfCards. 
]
