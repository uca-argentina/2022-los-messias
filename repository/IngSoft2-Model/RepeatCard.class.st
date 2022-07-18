Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#instVars : [
		'destinationShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RepeatCard class >> thrownBy: sourceShip to: destinationShip [

	^ self new initializeThrownBy: sourceShip to: destinationShip
]

{ #category : #actions }
RepeatCard >> effectOn: aCardApplicator [

	
	  aCardApplicator applyLastEffectOn: destinationShip
]

{ #category : #initialization }
RepeatCard >> initializeThrownBy: aSourceShip to: aDestinationShip [

	sourceShip := aSourceShip.
	destinationShip := aDestinationShip
]
