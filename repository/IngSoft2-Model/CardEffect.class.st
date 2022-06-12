Class {
	#name : #CardEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardEffect class >> applyFor: aZathuraShip on: aBoard [ 
	aBoard giveRandomCardTo: aZathuraShip .
]

{ #category : #action }
CardEffect >> applyFor: aShip on: aBoard [

	aBoard giveRandomCardTo: aShip.
	
]
