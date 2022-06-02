Class {
	#name : #ProbabilityDistribution,
	#superclass : #Object,
	#instVars : [
		'probabilities'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ProbabilityDistribution class >> with: probabilities [ 
	^self new initializeWith: probabilities
]

{ #category : #generating }
ProbabilityDistribution >> generateRandom [

	| result sum index |
	result := 100 atRandom.
	sum := 0.
	probabilities do: [ :prob | 
		result <= (prob + sum)
			ifTrue: [ ^probabilities indexOf: prob ]
			ifFalse: [ sum := sum + prob ] ].
]

{ #category : #initalization }
ProbabilityDistribution >> initializeWith: collectionOfProbabilities [ 
	probabilities := collectionOfProbabilities
]
