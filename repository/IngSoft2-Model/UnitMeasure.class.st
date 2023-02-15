Class {
	#name : #UnitMeasure,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #evaluating }
UnitMeasure >> value [

self subclassResponsibility .
]

{ #category : #accessing }
UnitMeasure >> valueAsParsec [

	self subclassResponsibility
]
