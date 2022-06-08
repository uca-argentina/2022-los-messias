Class {
	#name : #HandOfCards,
	#superclass : #Object,
	#instVars : [
		'name',
		'handOfCards',
		'changeOfRoll'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
HandOfCards class >> with: aName [

	^ self new initializeWith: aName
]

{ #category : #adding }
HandOfCards >> add: aCollection [ 
	self shouldBeImplemented.
]

{ #category : #adding }
HandOfCards >> addAll: cards [ 
	cards do: [ :card | handOfCards add: card ]
]

{ #category : #asserting }
HandOfCards >> assertOverloadInHand [

	(self checkIfInDeck: 'Overload') ifFalse: [ Error signal: 'Card is not in Hand' ]
]

{ #category : #attributes }
HandOfCards >> cards [

	^ handOfCards 
]

{ #category : #accesing }
HandOfCards >> cardsOf: nameCard [ 
	| num |
	num:= 0.
	handOfCards do: [ :aCard | (aCard name = nameCard) ifTrue: [ num:= num + 1 ] ].
	^num
]

{ #category : #accessing }
HandOfCards >> changeOfRoll [
	^ changeOfRoll
]

{ #category : #assertions }
HandOfCards >> checkIfInDeck: nameCard [
	| inHand |
	inHand:= false.
	handOfCards do: [:aCard | ((aCard name) = nameCard) ifTrue: [ inHand:= true ] ].
	^inHand
]

{ #category : #initialization }
HandOfCards >> initializeWith: aString [

	name := aString.
	handOfCards := OrderedCollection new.
	changeOfRoll := 0.
]

{ #category : #'accessing - attributes' }
HandOfCards >> name [
	^ name
]

{ #category : #effects }
HandOfCards >> reduceRollBy: anInteger [ 
	changeOfRoll := changeOfRoll - anInteger.
]

{ #category : #action }
HandOfCards >> throw: aCard [

	handOfCards  removeIndex: (handOfCards indexOf: aCard)
]

{ #category : #actions }
HandOfCards >> throwOverloadTo: aShip in: aZathuraGame [ 
self assertOverloadInHand.
"self throw: 'Overload'."
	aZathuraGame reduceRollDiceOf: aShip by: 2.
]
