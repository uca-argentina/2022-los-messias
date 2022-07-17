Class {
	#name : #FreedomCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FreedomCard class >> thrownBy: sourceShip [
	
	^self new initializeThrownBy: sourceShip
]

{ #category : #visiting }
FreedomCard >> effectOn: aCardApplicator [

		^ [ :aCollectionOfShips | 
	  aCardApplicator
		  releaseFromJail: aCollectionOfShips ]
]

{ #category : #initialization }
FreedomCard >> initializeThrownBy: aSourceShip [ 
	
	sourceShip := aSourceShip 
]
