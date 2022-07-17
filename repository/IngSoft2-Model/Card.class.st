Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'sourceShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
Card >> = aCard [
	^(self class = aCard class)
]

{ #category : #visiting }
Card >> effectOn: aCardManager [

	self subclassResponsibility
]

{ #category : #accessing }
Card >> sourceShip [
	
	^sourceShip 
]
