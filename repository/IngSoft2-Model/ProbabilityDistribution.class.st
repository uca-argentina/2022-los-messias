Class {
	#name : #ProbabilityDistribution,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ProbabilityDistribution class >> assertValidX: indices andY: probabilities [

	| sum |
	probabilities size <= 0 ifTrue: [ 
		Error signal:
			'Probabilities should not be loaded with an empty Collection' ].
	probabilities size == indices size ifFalse: [ 
		Error signal:
			'Probabilities should be loaded with the same amount of data for x and y' ].

	sum := probabilities sum: [ :probability | probability ].
	sum == 100 ifFalse: [ 
		Error signal: 'The sum of the probabilities must be 100%' ].

	(probabilities select: [ :value | value < 0 ]) ifNotEmpty: [ 
		Error signal: 'A probabilty can not be negative' ]
]

{ #category : #'instance creation' }
ProbabilityDistribution class >> withX: indices andY: probabilities [

	self assertValidX: indices andY: probabilities.
	^ self new initializeWithX:indices andY: probabilities
]

{ #category : #generating }
ProbabilityDistribution >> f: exe [

	| index |
	index := (x indexOf: [ :val | val == exe ])+1.
	^ y at: index
]

{ #category : #generating }
ProbabilityDistribution >> generateRandom [

	| result sum prob |
	result := 100 atRandom.
	sum := 0.
	x do: [ :exe | 
		prob := self f: exe.
		result <= (prob + sum)
			ifTrue: [ ^ exe ]
			ifFalse: [ sum := sum + prob ] ]
]

{ #category : #initalization }
ProbabilityDistribution >> initializeWithX: collectionOfIndices andY: collectionOfProbabilities [
	x := collectionOfIndices.
	y := collectionOfProbabilities
	
]
