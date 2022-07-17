Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OverloadCard class >> thrownBy: sourceShip [ 
	
	^ self new initializeThrownBy: sourceShip
]

{ #category : #action }
OverloadCard >> changeOfRoll [
	^-2
]

{ #category : #action }
OverloadCard >> effectOn: aCardApplicator [

	^ [ :aCollectionOfShips | 
	  aCardApplicator
		  applyPermanentCardEffectOf: self
		  to: aCollectionOfShips
		  thrownBy: sourceShip ]
]

{ #category : #initialization }
OverloadCard >> initializeThrownBy: aSourceShip [ 
	
	sourceShip := aSourceShip 
]
