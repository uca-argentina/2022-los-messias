Class {
	#name : #ReverseCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ReverseCard class >> thrownBy: sourceShip [
	
	^self new initializeThrownBy: sourceShip
]

{ #category : #action }
ReverseCard >> effectOn: aCardApplicator [

	  aCardApplicator reverseTheOrderOfTurns
]

{ #category : #initialization }
ReverseCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip 
]
