Class {
	#name : #Parsec,
	#superclass : #Object,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Parsec class >> with: aNumber [ 
	^ self new initializeWith: aNumber 
]

{ #category : #initialization }
Parsec >> initializeWith: parsec [ 
	parsecs := parsec
]

{ #category : #accesing }
Parsec >> unitValueAsParsec [
	^ parsecs
]
