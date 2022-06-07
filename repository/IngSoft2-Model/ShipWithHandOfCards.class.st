Class {
	#name : #ShipWithHandOfCards,
	#superclass : #Object,
	#instVars : [
		'name',
		'handOfCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
ShipWithHandOfCards class >> with: aName [

	^ self new initializeWith: aName
]

{ #category : #adding }
ShipWithHandOfCards >> add: aCollection [ 
	self shouldBeImplemented.
]

{ #category : #adding }
ShipWithHandOfCards >> addAll: cards [ 
	cards do: [ :card | handOfCards add: card ]
]

{ #category : #attributes }
ShipWithHandOfCards >> cards [

	^ handOfCards 
]

{ #category : #initialization }
ShipWithHandOfCards >> initializeWith: aString [

	name := aString.
	handOfCards := OrderedCollection new.
]

{ #category : #'accessing - attributes' }
ShipWithHandOfCards >> name [
	^ name
]

{ #category : #action }
ShipWithHandOfCards >> throw: aCard [

	| cardToThrow |
	cardToThrow := nil.
	handOfCards  do: [ :card | 
		card = aCard ifTrue: [ cardToThrow := card ] ].
	cardToThrow
		ifNil: [ Error signal: 'Card is not in Hand' ]
		ifNotNil: [ ^ cardToThrow ]
]
