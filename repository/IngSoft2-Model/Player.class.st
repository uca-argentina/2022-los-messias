Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Player class >> withTheName: aString [ 
	^self new initializeShipNamed: aString .
]

{ #category : #initialization }
Player >> initializeShipNamed: aString [ 
	name:= aString.
]

{ #category : #'accessing - attributes' }
Player >> name [
	^ name
]
