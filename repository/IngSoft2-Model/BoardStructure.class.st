Class {
	#name : #BoardStructure,
	#superclass : #Object,
	#instVars : [
		'lockers',
		'parsecs',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardStructure class >> with: aCollectionOfLockers and: parsecs played: laps [ 
	^self new intializeWith: aCollectionOfLockers and: parsecs played: laps
]

{ #category : #initialization }
BoardStructure >> intializeWith: aCollectionOfLockers and: aNumberParsecs played: aNumberLaps [ 
	lockers := aCollectionOfLockers.
	parsecs := aNumberParsecs.
	laps := aNumberLaps
]

{ #category : #accesing }
BoardStructure >> laps [
	^ laps
]

{ #category : #accesing }
BoardStructure >> lockers [
	^ lockers
]

{ #category : #accesing }
BoardStructure >> parsecs [
	^ parsecs
]
