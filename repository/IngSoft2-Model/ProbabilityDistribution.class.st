Class {
	#name : #ProbabilityDistribution,
	#superclass : #Object,
	#instVars : [
		'probabilities'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ProbabilityDistribution class >> assertValid: probabilities [

	| sum |
	probabilities size <= 0 ifTrue: [ 
		Error signal:
			'Probabilities should not be loaded with an empty Collection' ].

	sum := probabilities sum: [ :probability | probability ].
	sum == 100 ifFalse: [ 
		Error signal: 'The sum of the probabilities must be 100%' ].

	(probabilities select: [ :value | value < 0 ]) ifNotEmpty: [ 
		Error signal: 'A probabilty can not be negative' ]
]

{ #category : #'instance creation' }
ProbabilityDistribution class >> with: probabilities [
	self assertValid: probabilities.
	^ self new initializeWith: probabilities
]

{ #category : #generating }
ProbabilityDistribution >> generateRandom [

	| result sum index |
	result := 100 atRandom.
	sum := 0.
	probabilities do: [ :prob | 
		result <= (prob + sum)
			ifTrue: [ ^ probabilities indexOf: prob ]
			ifFalse: [ sum := sum + prob ] ]
]

{ #category : #initalization }
ProbabilityDistribution >> initializeWith: collectionOfProbabilities [ 
	probabilities := collectionOfProbabilities
]
