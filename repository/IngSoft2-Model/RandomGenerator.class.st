Class {
	#name : #RandomGenerator,
	#superclass : #Object,
	#instVars : [
		'parsecsBoard',
		'probabilityDistribution',
		'objects'
	],
	#classInstVars : [
		'parsecsBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomGenerator class >> with: objects distributedBy: probabilytyDistribution [

	^ self new
		  initializeWith: objects
		  distributedBy: probabilytyDistribution
]

{ #category : #generating }
RandomGenerator >> generateRandomObjectsWith: numberOfObjects [
"Como que le falta declaratividad pero no se me ocurre otra forma de poder reutilizarlo para las cartas también"
	| objectsGenerated |
	objectsGenerated := OrderedCollection new.
	1 to: numberOfObjects do: [ :number | 
		objectsGenerated add:
			(objects at: probabilityDistribution generateRandom) deepCopy ].
	^ objectsGenerated
]

{ #category : #initialization }
RandomGenerator >> initializeWith: collectionOfObjects distributedBy: aProbabilityDistribution [

objects := collectionOfObjects.
probabilityDistribution := aProbabilityDistribution 
]
