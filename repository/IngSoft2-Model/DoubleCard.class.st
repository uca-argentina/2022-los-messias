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

{ #category : #visiting }
DoubleCard >> effectOn: aCardApplicator [

	  aCardApplicator repeatTurn: destinationShip
]

{ #category : #initialization }
DoubleCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip
]
