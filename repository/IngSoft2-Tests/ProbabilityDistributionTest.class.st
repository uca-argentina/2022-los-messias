Class {
	#name : #ProbabilityDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionReceivesACollectionWithOneHundredAndZeroProbabilityAndGivesTheIndexOfAHundredAsResult [

	| aProbabilityDistribution |
	aProbabilityDistribution := ProbabilityDistribution withPoints: { 
			                            (PointProbability withX: 'a' andY: 100).
			                            (PointProbability withX: 'b' andY: 0) }.
	self assert: aProbabilityDistribution generateRandom equals: 'a'
]

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionReceivesACollectionWithProbabilitiesAndDistributesThemCorrectly [

	| aProbabilityDistribution aCollection |
	aProbabilityDistribution := ProbabilityDistribution withPoints: { 
			                            (PointProbability withX: 'a' andY: 75).
			                            (PointProbability  withX: 'b' andY: 20).
			                            (PointProbability  withX: 'c' andY: 5) }.

	aCollection := OrderedCollection new.
	1 to: 100000 do: [ :i | 
	aCollection add: aProbabilityDistribution generateRandom ].
	self assert:
		((aCollection select: [ :e | e = 'a' ]) size
			 between: 65000
			 and: 85000).

	self assert:
		((aCollection select: [ :i | i = 'b' ]) size
			 between: 10000
			 and: 30000).

	self assert:
		((aCollection select: [ :i | i = 'c' ]) size between: 0 and: 10000)
]

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionThrowsErrorWhenIsIitializedWithANegativeProbability [

	self
		should: [ ProbabilityDistribution withPoints: { 
			           (PointProbability withX: 'a' andY: 50).
			           (PointProbability withX: 'b' andY: 60).
			           (PointProbability withX: 'c' andY: -10) } ]
		raise: Error
		withMessage: 'A probabilty can not be negative'
]

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionThrowsErrorWhenIsIitializedWithASumOfValuesDifferentOfAHundred [

	self
		should: [ ProbabilityDistribution withPoints: { 
					(PointProbability withX: 'a' andY: 10).
					(PointProbability withX: 'b' andY: 89) }]
		raise: Error
		withMessage: 'The sum of the probabilities must be 100%'
]

{ #category : #tests }
ProbabilityDistributionTest >> testProbabilityDistributionThrowsErrorWhenIsIitializedWithAnEmptyCollection [

	self
		should: [ ProbabilityDistribution withPoints: {  } ]
		raise: Error
		withMessage:
		'Probabilities should not be loaded with an empty Collection'
]
