Class {
	#name : #ProbabilityDistribution,
	#superclass : #Object,
	#instVars : [
		'points'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
ProbabilityDistribution class >> assertValid: points [

	| sum |
	points size <= 0 ifTrue: [ Error signal: 'There must be at least one point' ].
	
	sum := points sum: [ :point | point y ].
	sum == 100 ifFalse: [ 
		Error signal: 'The sum of the probabilities must be 100%' ].
]

{ #category : #'class initialization' }
ProbabilityDistribution class >> with: aCollectionOfPoints [

	| indices probabilities |
	indices := OrderedCollection new.
	probabilities := OrderedCollection new.
	aCollectionOfPoints do: [ :aPoint | 
		indices add: aPoint x.
		probabilities add: aPoint y ].
	self assertValid: aCollectionOfPoints.
	^ self new with: aCollectionOfPoints
]

{ #category : #generating }
ProbabilityDistribution >> generateRandom [

	| result |
	result := 100 atRandom.
	^ self getGeneratedObjectWith: result
]

{ #category : #generating }
ProbabilityDistribution >> getGeneratedObjectWith: result [

	| prob sum |
	sum := 0.
	points do: [ :aPoint | 
		prob := aPoint y.
		result <= (prob + sum)
			ifTrue: [ ^ aPoint x ]
			ifFalse: [ sum := sum + prob ] ]
]

{ #category : #initialization }
ProbabilityDistribution >> with: aCollectionOfPoints [ 
	points:= aCollectionOfPoints.
]
