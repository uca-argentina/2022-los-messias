Class {
	#name : #ProbabilityDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionReceivesACollectionWithOneHundredAndZeroProbabilityAndGivesTheIndexOfAHundredAsResult [

	
	| aProbabilityDistribution |
	aProbabilityDistribution := ProbabilityDistribution with:  { 100. 0 }.
	self assert: aProbabilityDistribution generateRandom equals: 1
]

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionReceivesACollectionWithProbabilitiesAndDistributesThemCorrectly [

	| aProbabilityDistribution aCollection |
	aProbabilityDistribution := ProbabilityDistribution with: { 75. 20. 5 }.
	aCollection := OrderedCollection new.
	1 to: 100 do: [ :i | 
	aCollection add: aProbabilityDistribution generateRandom ].

	self assert:
		((aCollection select: [ :i | i == 1 ]) size between: 65 and: 85).
		
	self assert:
		((aCollection select: [ :i | i == 2 ]) size between: 10 and: 30).
		
	self assert:
		((aCollection select: [ :i | i == 3 ]) size between: 0 and: 10)
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
