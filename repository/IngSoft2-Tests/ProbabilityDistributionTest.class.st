Class {
	#name : #ProbabilityDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionReceivesACollectionWithEightyAndTwuentyProbabilityAndDistributesThemCorrectly [

	| aProbabilityDistribution aCollection |
	aProbabilityDistribution := ProbabilityDistribution with: { 80. 20 }.
	aCollection := OrderedCollection new.
	1 to: 100 do: [ :i | 
	aCollection add: aProbabilityDistribution generateRandom ].

	self assert:
		((aCollection select: [ :i | i == 1 ]) size between: 70 and: 90).
	self assert:
		((aCollection select: [ :i | i == 2 ]) size between: 10 and: 30)
]

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionReceivesACollectionWithOneHundredAndZeroProbabilityAndGivesTheIndexOfAHundredAsResult [

	
	| aProbabilityDistribution |
	aProbabilityDistribution := ProbabilityDistribution with:  { 100. 0 }.
	self assert: aProbabilityDistribution generateRandom equals: 1
]

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionThrowsErrorWhenIsIitializedWithANegativeProbability [

	self
		should: [ ProbabilityDistribution with: { 50. 60. -10 } ]
		raise: Error
		withMessage: 'A probabilty can not be negative'
]

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionThrowsErrorWhenIsIitializedWithASumOfValuesDifferentOfAHundred [

	self
		should: [ ProbabilityDistribution with: { 10. 89 } ]
		raise: Error
		withMessage:
		'The sum of the probabilities must be 100%'
]

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionThrowsErrorWhenIsIitializedWithAnEmptyCollection [

	self
		should: [ ProbabilityDistribution with: { } ]
		raise: Error
		withMessage:
		'Probabilities should not be loaded with an empty Collection'
]
