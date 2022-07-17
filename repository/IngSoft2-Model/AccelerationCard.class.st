Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AccelerationCard class >> thrownBy: sourceShip [ 
	
	^ self new initializeThrownBy: sourceShip
]

{ #category : #accesing }
AccelerationCard >> changeOfRoll [
	^1
]

{ #category : #action }
AccelerationCard >> effectOn: aCardApplicator [

	^ [ :aCollectionOfShips | 
	  aCardApplicator applyPermanentCardEffectOf: self to: aCollectionOfShips thrownBy: sourceShip ]
]

{ #category : #initialization }
AccelerationCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip
]
