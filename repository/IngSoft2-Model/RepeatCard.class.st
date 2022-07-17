Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RepeatCard class >> thrownBy: sourceShip [ 
	
	^self new initializeThrownBy: sourceShip
]

{ #category : #actions }
RepeatCard >> effectOn: aCardApplicator [

	^ [ :aCollectionOfShip | 
	  aCardApplicator applyLastEffectOn: aCollectionOfShip first ]
]

{ #category : #initialization }
RepeatCard >> initializeThrownBy: aSourceShip [  
	
	sourceShip := aSourceShip
]
