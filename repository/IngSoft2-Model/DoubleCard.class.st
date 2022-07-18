Class {
	#name : #DoubleCard,
	#superclass : #Card,
	#instVars : [
		'destinationShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DoubleCard class >> thrownBy: sourceShip [ 
	
	^ self new initializeThrownBy: sourceShip
]

{ #category : #'instance creation' }
DoubleCard class >> thrownBy: sourceShip to: destinationShip [

	^ self new initializeThrownBy: sourceShip to: destinationShip
]

{ #category : #visiting }
DoubleCard >> effectOn: aCardApplicator [

	  aCardApplicator repeatTurn: destinationShip
]

{ #category : #initialization }
DoubleCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip
]

{ #category : #initialization }
DoubleCard >> initializeThrownBy: aSourceShip to: aDestinationShip [

	sourceShip := aSourceShip.
	destinationShip := aDestinationShip
]
