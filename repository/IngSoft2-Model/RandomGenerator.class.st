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
RandomGenerator >> generateRandomObjectsWith: numberOfObjects [

	"Como que le falta declaratividad pero no se me ocurre otra forma de poder reutilizarlo para las cartas también"

	| objectsGenerated |
	objectsGenerated := OrderedCollection new.
	1 to: numberOfObjects do: [ :number | 
		objectsGenerated add:
			((probabilityDistribution generateRandom) deepCopy) ].
	^ objectsGenerated
]

{ #category : #initialization }
RandomGenerator >> initializeWith:aProbabilityDistribution [

	probabilityDistribution := aProbabilityDistribution
]
