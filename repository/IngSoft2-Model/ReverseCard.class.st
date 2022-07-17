Class {
	#name : #ReverseCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ReverseCard class >> thrownBy: sourceShip [
	
	^self new initializeThrownBy: sourceShip
]

{ #category : #visiting }
ReverseCard >> effectOn: aCardApplicator [

	^[ :aCollectionOfShips |  aCardApplicator reverseTheOrderOfTurnsTo: aCollectionOfShips]
]

{ #category : #initialization }
ReverseCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip 
]
