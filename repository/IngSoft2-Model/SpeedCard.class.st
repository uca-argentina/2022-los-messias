Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedCard class >> thrownBy: aSourceShip [ 
	
	^self new initializeThrownBy: aSourceShip
]

{ #category : #action }
SpeedCard >> changeOfRoll [
	^1
]

{ #category : #action }
SpeedCard >> effectOn: aCardApplicator [

	^ [ :aCollectionOfShips | 
	  aCardApplicator
		  applyPermanentCardEffectOf: self
		  to: aCollectionOfShips
		  thrownBy: sourceShip ]
]

{ #category : #initialization }
SpeedCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip
]
