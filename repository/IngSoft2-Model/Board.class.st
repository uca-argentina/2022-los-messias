Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfLockers'
	],
	#classInstVars : [
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> assertValid: numberOfLockers [

	numberOfLockers >= 2 ifFalse: [ 
		Error signal: 'Zathura cannot be played with a board with less than two lockers' ]
]

{ #category : #'instance creation' }
Board class >> with: aNumberOfLockers [
	self assertValid: aNumberOfLockers.
	^ self new initializeWith: aNumberOfLockers
]

{ #category : #initialization }
Board >> didShipCrossFinishLine: aShip [

	| result |
	result := aShip isInPosition >= numberOfLockers.
	result ifTrue: [ 
		aShip advances: numberOfLockers - aShip isInPosition ].
	

	^ result
]

{ #category : #initialization }
Board >> getPositionShip: aShip [

	^ aShip isInPosition 
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfLockers [

	numberOfLockers := aNumberOfLockers
]
