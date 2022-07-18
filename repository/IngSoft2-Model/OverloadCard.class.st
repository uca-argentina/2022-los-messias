Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#instVars : [
		'destinationShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OverloadCard class >> thrownBy: sourceShip to: destinationShip [

	^ self new initializeThrownBy: sourceShip to: destinationShip 
]

{ #category : #accessing }
OverloadCard >> changeOfRoll [
	^-2
]

{ #category : #accessing }
OverloadCard >> destinationShip [ 

	^destinationShip 
]

{ #category : #action }
OverloadCard >> effectOn: aCardApplicator [

	aCardApplicator
		applyPermanentCardEffectOf: self
		to: destinationShip 
		thrownBy: sourceShip
]

{ #category : #initialization }
OverloadCard >> initializeThrownBy: aSourceShip to: aDestinationShip [

	sourceShip := aSourceShip.
	destinationShip := aDestinationShip
]
