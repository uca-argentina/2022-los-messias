Class {
	#name : #RandomGenerator,
	#superclass : #Object,
	#instVars : [
		'probabilityDistribution'
	],
	#classInstVars : [
		'parsecsBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomGenerator class >> distributedBy: probabilityDistribution [

	^ self new initializeWith: probabilityDistribution
]

{ #category : #generating }
RandomGenerator >> generate [

	^ probabilityDistribution generateRandom deepCopy
]

{ #category : #generating }
RandomGenerator >> generateRandomObjectsWith: numberOfObjects [

	| objectsGenerated |
	objectsGenerated := OrderedCollection new.
	1 to: numberOfObjects do: [ :number | 
	objectsGenerated add: self generate ].
	^ objectsGenerated
]

{ #category : #initialization }
RandomGenerator >> initializeWith:aProbabilityDistribution [

	probabilityDistribution := aProbabilityDistribution
]
