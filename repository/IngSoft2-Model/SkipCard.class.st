Class {
	#name : #SkipCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SkipCard class >> thrownBy: sourceShip [ 

	^self new initializeThrownBy: sourceShip
]

{ #category : #action }
SkipCard >> effectOn: aCardApplicator [

	aCardApplicator loseTheTurn
]

{ #category : #initialization }
SkipCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip
]
