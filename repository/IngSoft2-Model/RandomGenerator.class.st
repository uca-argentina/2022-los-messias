Class {
	#name : #RandomGenerator,
	#superclass : #Object,
	#instVars : [
		'probabilityDistribution'
	],
	#classInstVars : [
		'parsecsBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomGenerator class >> distributedBy: probabilytyDistribution [

	^ self new
		  initializeWith: probabilytyDistribution
]

{ #category : #'class initialization' }
RandomGenerator class >> distributedByRandom: aCollection [ 
	| points |
	points:= OrderedCollection new.
	aCollection do: [ :anObject | points add: (PointProbability withX: anObject  andY: (100/(aCollection size)))].
	^self new initializeWith: (ProbabilityDistribution withPoints: points )
]

{ #category : #generating }
RandomGenerator >> generate [

	^ probabilityDistribution generateRandom deepCopy
]

{ #category : #generating }
RandomGenerator >> generateRandomObjectsWith: numberOfObjects [

	| objectsGenerated |
	objectsGenerated := OrderedCollection new.
	1 to: numberOfObjects do: [ :number | 
	objectsGenerated add: self generate ].
	^ objectsGenerated
]

{ #category : #initialization }
RandomGenerator >> initializeWith:aProbabilityDistribution [

	probabilityDistribution := aProbabilityDistribution
]
