Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#instVars : [
		'destinationShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AccelerationCard class >> thrownBy: sourceShip [

	^ self new initializeThrownBy: sourceShip to: 'allShips'
]

{ #category : #'instance creation' }
AccelerationCard class >> thrownBy: sourceShip to: destinationShip [

	^ self new initializeThrownBy: sourceShip to: destinationShip
]

{ #category : #accessing }
AccelerationCard >> changeOfRoll [
	^1
]

{ #category : #accessing }
AccelerationCard >> destinationShip [

	^destinationShip 

]

{ #category : #action }
AccelerationCard >> effectOn: aCardApplicator [

	  aCardApplicator
		  applyPermanentCardEffectOf: self
		  thrownBy: sourceShip
]

{ #category : #initialization }
AccelerationCard >> initializeThrownBy: aSourceShip to: aDestinationShip [ 

	sourceShip := aSourceShip.
	destinationShip := aDestinationShip
]
