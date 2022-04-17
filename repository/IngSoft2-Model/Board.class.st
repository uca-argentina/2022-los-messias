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

	numberOfLockers positive ifFalse: [ 
		Error signal: 'Number of Lockers should be positive' ].
]

{ #category : #'instance creation' }
Board class >> with: aNumberOfLockers [
	self assertValid: aNumberOfLockers.
	^ self new initializeWith: aNumberOfLockers
]

{ #category : #initialization }
Board >> didShipCrossFinishLine: aShip [

	^ aShip > numberOfLockers
]

{ #category : #initialization }
Board >> getPositionShip: aShip [

	^ aShip.
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfLockers [

	numberOfLockers := aNumberOfLockers
]
