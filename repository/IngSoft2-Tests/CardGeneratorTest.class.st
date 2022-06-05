Class {
	#name : #CardGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardGeneratorTest >> testCardGeneratorGeneratesACollectionOfDifferentCardsWithCorrectProportion [

	| lockers probabilityDistribution cards |
	cards := { 
		         OverloadCard new.
		         SpeedCard new.
		         AccelerationCard new.
		         CancellationCard new.
		         RedoCard new.
		         RepeatCard new }.
	probabilityDistribution := ProbabilityDistribution with: { 
			                           (100 / 6).
			                           (100 / 6).
			                           (100 / 6).
			                           (100 / 6).
			                           (100 / 6).
			                           (100 / 6) }.

	lockers := (RandomGenerator
		            with: cards
		            distributedBy: probabilityDistribution) 
		           generateRandomObjectsWith: 100000.

	self assert: ((lockers select: [ :i | i isMemberOf: OverloadCard ]) size
			 between: 10000
			 and: 20000).
	self assert: ((lockers select: [ :i | i isMemberOf: SpeedCard ]) size
			 between: 10000
			 and: 20000).
	self assert:
		((lockers select: [ :i | i isMemberOf: AccelerationCard ]) size
			 between: 10000
			 and: 20000).
	self assert:
		((lockers select: [ :i | i isMemberOf: CancellationCard ]) size
			 between: 10000
			 and: 20000).
	self assert: ((lockers select: [ :i | i isMemberOf: RedoCard ]) size
			 between: 10000
			 and: 20000).
	self assert: ((lockers select: [ :i | i isMemberOf: RepeatCard ]) size
			 between: 10000
			 and: 20000)
]
