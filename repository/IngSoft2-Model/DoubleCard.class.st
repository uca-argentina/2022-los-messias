Class {
	#name : #DoubleCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DoubleCard class >> thrownBy: sourceShip [ 
	
	^ self new initializeThrownBy: sourceShip
]

{ #category : #visiting }
DoubleCard >> effectOn: aCardApplicator [

	^ [ :aCollectionOfShip | 
	  aCardApplicator repeatTurn: aCollectionOfShip first ]
]

{ #category : #initialization }
DoubleCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip
]
