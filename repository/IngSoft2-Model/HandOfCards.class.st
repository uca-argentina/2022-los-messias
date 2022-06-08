Class {
	#name : #HandOfCards,
	#superclass : #Object,
	#instVars : [
		'name',
		'handOfCards'
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

{ #category : #attributes }
HandOfCards >> cards [

	^ handOfCards 
]

{ #category : #initialization }
HandOfCards >> initializeWith: aString [

	name := aString.
	handOfCards := OrderedCollection new.
]

{ #category : #'accessing - attributes' }
HandOfCards >> name [
	^ name
]

{ #category : #action }
HandOfCards >> throw: aCard [

	| cardToThrow |
	cardToThrow := nil.
	handOfCards  do: [ :card | 
		card = aCard ifTrue: [ cardToThrow := card ] ].
	cardToThrow
		ifNil: [ Error signal: 'Card is not in Hand' ]
		ifNotNil: [ ^ cardToThrow ]
]
