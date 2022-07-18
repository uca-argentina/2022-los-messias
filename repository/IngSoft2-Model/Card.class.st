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

{ #category : #action }
Card >> effectOn: aCardApplicator [

	self subclassResponsibility
]

{ #category : #accessing }
Card >> sourceShip [
	
	^sourceShip 
]
