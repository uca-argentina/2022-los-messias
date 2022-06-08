Class {
	#name : #CardGenerator,
	#superclass : #Object,
	#instVars : [
		'cards',
		'probabilityDistribution'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardGenerator class >> initializeNew [

	^ self new loadAttributes.
]

{ #category : #generate }
CardGenerator >> generate: aNumberOfCards [ 
	| generator |
	generator := (RandomGenerator
		            with: cards
		            distributedBy: probabilityDistribution).
	^generator generateRandomObjectsWith: aNumberOfCards.
]

{ #category : #intialization }
CardGenerator >> loadAttributes [
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
]
