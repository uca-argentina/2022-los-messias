Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
Card >> = aCard [
	^(self class = aCard class)
]

{ #category : #visiting }
Card >> accept: aCardManager [

	self subclassResponsibility
]

{ #category : #asserting }
Card >> assertIsValid: sourceShip on: cardManager [

	^ typeOfCard assertIsValid: sourceShip on: cardManager
]
