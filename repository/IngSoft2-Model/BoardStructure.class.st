Class {
	#name : #BoardStructure,
	#superclass : #Object,
	#classInstVars : [
		'lockers',
		'parsecs',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
BoardStructure class >> intializeWith: acollectionOfLockers and: aNumberOfParsecs played: aNumberOfLaps [ 
	lockers := acollectionOfLockers.
	parsecs := aNumberOfParsecs.
	laps := aNumberOfLaps
]

{ #category : #accesing }
BoardStructure class >> laps [
	^ laps
]

{ #category : #accesing }
BoardStructure class >> lockers [
	^ lockers
]

{ #category : #accesing }
BoardStructure class >> parsecs [
	^ parsecs
]

{ #category : #'instance Creation' }
BoardStructure class >> with: aNumberOfLockers and: aNumberOfParsecs played: aNumberOfLaps [ 
	^ self intializeWith: aNumberOfLockers and: aNumberOfParsecs played: aNumberOfLaps
]
