Class {
	#name : #LightYear,
	#superclass : #UnitMeasure,
	#instVars : [
		'lightYears'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LightYear class >> with: aNumber [
	^ self new initializeWith: aNumber
]

{ #category : #initialization }
LightYear >> initializeWith: lightYear [

	lightYears := lightYear
]

{ #category : #evaluating }
LightYear >> value [

	^lightYears 
]

{ #category : #accessing }
LightYear >> valueAsParsec [

	^ lightYears // 3
]
