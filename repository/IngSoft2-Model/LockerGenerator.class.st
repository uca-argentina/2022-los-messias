Class {
	#name : #LockerGenerator,
	#superclass : #Object,
	#instVars : [
		'parsecsBoard',
		'effects',
		'probabilityDistribution'
	],
	#classInstVars : [
		'parsecsBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LockerGenerator class >> with: effects distributedBy: probabilytyDistribution [

	^ self new initializeWith: effects distrutedBy: probabilytyDistribution
]

{ #category : #generating }
LockerGenerator >> generateRandomLockersWith: numberOfLockers [

	| lockers |
	lockers := OrderedCollection new.
	lockers add: LockerNoEffect new.
	2 to: numberOfLockers do: [ :number | 
	lockers add: (effects at: (probabilityDistribution generateRandom )) ].
	^ lockers
]

{ #category : #initialization }
LockerGenerator >> initializeWith: collectionOfEffects distributedBy: aProbabilityDistribution [

effects := collectionOfEffects.
probabilityDistribution := aProbabilityDistribution 
]

{ #category : #initialization }
LockerGenerator >> initializeWith: aEffects distrutedBy: aProbabilityDistribution [ 
	effects := aEffects.
	probabilityDistribution := aProbabilityDistribution 
]
