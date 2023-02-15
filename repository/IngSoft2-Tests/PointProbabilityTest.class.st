Class {
	#name : #PointProbabilityTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PointProbabilityTest >> testPointProbabilityThrowsErrorWhenItIsLoadedWithANegativeProbability [
		self
		should: [ PointProbability withX: 'c' andY: -10 ]
		raise: Error
		withMessage: 'A probabilty can not be negative'
	
]
