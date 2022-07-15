Class {
	#name : #ProbabilityPoint,
	#superclass : #Object,
	#instVars : [
		'object',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
ProbabilityPoint class >> assertValid: aProbability [

	(aProbability < 0 or: aProbability>100)ifTrue: [ 
		Error signal: 'A probabilty can not be negative or greater than 100%' ]
]

{ #category : #'class initialization' }
ProbabilityPoint class >> withX: anObject andY: aProbability [
	self assertValid: aProbability.
	^ self new initializeWithX: anObject andY: aProbability
]

{ #category : #initialization }
ProbabilityPoint >> initializeWithX: anObject andY: aProbability [ 
	object:= anObject.
	probability:= aProbability .
]

{ #category : #'accessing - attributes' }
ProbabilityPoint >> object [

	^ object
]

{ #category : #attributes }
ProbabilityPoint >> probability [

	^ probability
]
