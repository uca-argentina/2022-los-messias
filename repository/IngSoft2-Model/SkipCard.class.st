Class {
	#name : #SkipCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SkipCard class >> thrownBy: sourceShip [ 

	^self new initializeThrownBy: sourceShip
]

{ #category : #'instance creation' }
SkipCard >> effectOn: aCardApplicator [

	^ [ :aShip | aCardApplicator loseTheTurnTo: aShip ]
]

{ #category : #initialization }
SkipCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip
]
