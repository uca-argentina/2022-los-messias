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
RandomGenerator class >> distributedBy: probabilytyDistribution [

	^ self new
		  initializeWith: probabilytyDistribution
]

{ #category : #generating }
RandomGenerator >> generateRandomObjectsWith: numberOfObjects [

	"Como que le falta declaratividad pero no se me ocurre otra forma de poder reutilizarlo para las cartas también"

	| objectsGenerated |
	objectsGenerated := OrderedCollection new.
	1 to: numberOfObjects do: [ :number | 
		objectsGenerated add:
			((probabilityDistribution generateRandom) deepCopy) ].
	^ objectsGenerated
]

{ #category : #initialization }
RandomGenerator >> initializeWith:aProbabilityDistribution [

	probabilityDistribution := aProbabilityDistribution
]
