Class {
	#name : #ProbabilityPoint,
	#superclass : #Object,
	#instVars : [
		'event',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
ProbabilityPoint class >> assertValid: aProbability [
		(aProbability < 0) ifTrue: [ 
		Error signal: 'A probabilty can not be negative' ]
]

{ #category : #'class initialization' }
ProbabilityPoint class >> initializeEvent: anObject withProbability: aProbability [
	self assertValid: aProbability.
	^ self new initializeEvent: anObject withProbability: aProbability
]

{ #category : #initialization }
ProbabilityPoint >> event [

^event.
]

{ #category : #initialization }
ProbabilityPoint >> initializeEvent: anObject withProbability: aProbability [

	event := anObject.
	probability := aProbability
]

{ #category : #initialization }
ProbabilityPoint >> probability [

	^ probability 
]
