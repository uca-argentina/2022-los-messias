Class {
	#name : #ProbabilityPointTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityPointTest >> testPointProbabilityThrowsErrorWhenItIsLoadedWithANegativeProbability [

	self
		should: [ ProbabilityPoint withX: 'c' andY: -10 ]
		raise: Error
		withMessage: 'A probabilty can not be negative or greater than 100%' 
]

{ #category : #tests }
ProbabilityPointTest >> testPointProbabilityThrowsErrorWhenItIsLoadedWithAProbabilityGreaterThanOneHoundred [

	self
		should: [ ProbabilityPoint withX: 'c' andY: 101 ]
		raise: Error
		withMessage: 'A probabilty can not be negative or greater than 100%'
]
