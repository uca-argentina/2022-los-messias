Class {
	#name : #RedoCancellationCard,
	#superclass : #RedoCard,
	#instVars : [
		'cardToRemove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCancellationCard class >> withRemoving: aCard [ 
	
	^ self new initializeWithRemoving: aCard
]

{ #category : #initialization }
RedoCancellationCard >> initializeWithRemoving: aCard [ 
	
	cardToRemove := aCard.
	typeOfCard := Instant new
]
