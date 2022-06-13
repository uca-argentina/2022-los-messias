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
BoardDefinition class >> with: lockers and: unit played: laps [

	self assertLockersAreValid: lockers size.
	self assertParsecsAreValid: unit unitValueAsParsec .
	self assertLapsAreValid: laps.
	^ self new initializeWith: lockers and: unit played: laps
]

{ #category : #initialization }
BoardDefinition >> initializeWith: aCollectionOfLockers and: aNumberParsecs played: aNumberLaps [

	lockers := aCollectionOfLockers.
	parsecs := aNumberParsecs unitValueAsParsec.
	laps := aNumberLaps
]

{ #category : #accesing }
BoardDefinition >> laps [
	^ laps
]

{ #category : #accesing }
BoardDefinition >> lockerAt: num [

	^ lockers at: num
]

{ #category : #accesing }
BoardDefinition >> numberOfLockers [

^ lockers size
]

{ #category : #accesing }
BoardDefinition >> parsecsPerLocker [

	^ (lockers size / parsecs) asFloat
]
