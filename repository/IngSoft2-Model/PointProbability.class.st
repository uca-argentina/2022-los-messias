Class {
	#name : #PointProbability,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
PointProbability class >> assertValid: aProbability [
		(aProbability < 0) ifTrue: [ 
		Error signal: 'A probabilty can not be negative' ]
]

{ #category : #'class initialization' }
PointProbability class >> withX: anObject andY: aProbability [
	self assertValid: aProbability.
	^ self new withX: anObject andY: aProbability
]

{ #category : #initialization }
PointProbability >> withX: anObject andY: aProbability [ 
	x:= anObject.
	y:= aProbability .
]

{ #category : #'accessing - attributes' }
PointProbability >> x [
	^ x
]

{ #category : #attributes }
PointProbability >> y [
	^ y
]
