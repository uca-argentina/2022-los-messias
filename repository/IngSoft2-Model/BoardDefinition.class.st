Class {
	#name : #BoardDefinition,
	#superclass : #Object,
	#instVars : [
		'lockers',
		'parsecs',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
BoardDefinition class >> assertLapsAreValid: laps [

	laps > 0 ifFalse: [ 
		Error signal: 'Board Structure cannot have less than zero laps' ]
]

{ #category : #asserting }
BoardDefinition class >> assertLockersAreValid: aNumberOfLockers [

	aNumberOfLockers > 1 ifFalse: [ 
		Error signal: 'Board Structure cannot have less than two lockers' ]
]

{ #category : #asserting }
BoardDefinition class >> assertParsecsAreValid: parsecs [

	parsecs > 0 ifFalse: [ 
		Error signal: 'Board Structure cannot have less than zero parsecs' ]
]

{ #category : #'instance creation' }
BoardDefinition class >> with: aCollectionOfLockers and: parsecs played: laps [

	self assertLockersAreValid: aCollectionOfLockers size.
	self assertParsecsAreValid: parsecs.
	self assertLapsAreValid: laps.
	^ self new
		  intializeWith: aCollectionOfLockers
		  and: parsecs
		  played: laps
]

{ #category : #action }
BoardDefinition >> doEffectTo: aShip inPosition: position of: aBoard [

	(lockers at: (position +1)) applyFor: aShip  on: aBoard 
]

{ #category : #initialization }
BoardDefinition >> intializeWith: aCollectionOfLockers and: aNumberParsecs played: aNumberLaps [ 
	lockers := aCollectionOfLockers.
	parsecs := aNumberParsecs.
	laps := aNumberLaps
]

{ #category : #accesing }
BoardDefinition >> laps [
	^ laps
]

{ #category : #accesing }
BoardDefinition >> lockers [
	^ lockers
]

{ #category : #accesing }
BoardDefinition >> parsecsPerLocker [ 

^(lockers size / parsecs) asFloat
]
