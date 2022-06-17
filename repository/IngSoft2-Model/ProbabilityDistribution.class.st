Class {
	#name : #ProbabilityDistribution,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'points'
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

{ #category : #'class initialization' }
ProbabilityDistribution class >> withPoints: aCollectionOfPoints [

	| indices probabilities |
	indices := OrderedCollection new.
	probabilities := OrderedCollection new.
	aCollectionOfPoints do: [ :aPoint | 
		indices add: aPoint x.
		probabilities add: aPoint y ].
	self assertValidX: indices andY: probabilities.
	^self new withPoints: aCollectionOfPoints.
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
ProbabilityDistribution >> withPoints: aCollectionOfPoints [ 
	points:= aCollectionOfPoints.
]
