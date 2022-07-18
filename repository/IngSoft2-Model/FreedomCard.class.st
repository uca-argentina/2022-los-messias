Class {
	#name : #FreedomCard,
	#superclass : #Card,
	#instVars : [
		'destinationShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FreedomCard class >> thrownBy: sourceShip to: destinationShip [

	^ self new initializeThrownBy: sourceShip to: destinationShip 
]

{ #category : #action }
FreedomCard >> effectOn: aCardApplicator [

	  aCardApplicator releaseFromJail: destinationShip 
]

{ #category : #initialization }
FreedomCard >> initializeThrownBy: aSourceShip to: aDestinationShip [

	sourceShip := aSourceShip.
	destinationShip := aDestinationShip
]
