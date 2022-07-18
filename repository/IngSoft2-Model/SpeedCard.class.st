Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#instVars : [
		'destinationShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedCard class >> thrownBy: aSourceShip [ 
	
	^self new initializeThrownBy: aSourceShip
]

{ #category : #'instance creation' }
SpeedCard class >> thrownBy: aSourceShip to: destinationShip [

	^ self new initializeThrownBy: aSourceShip to: destinationShip
]

{ #category : #action }
SpeedCard >> changeOfRoll [
	^1
]

{ #category : #accessing }
SpeedCard >> destinationShip [ 

	^destinationShip 
]

{ #category : #action }
SpeedCard >> effectOn: aCardApplicator [

	aCardApplicator
		applyPermanentCardEffectOf: self
		to: destinationShip
		thrownBy: sourceShip
]

{ #category : #initialization }
SpeedCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip
]

{ #category : #initialization }
SpeedCard >> initializeThrownBy: aSourceShip to: aDestinationShip [

	sourceShip := aSourceShip.
	destinationShip := aDestinationShip
]
