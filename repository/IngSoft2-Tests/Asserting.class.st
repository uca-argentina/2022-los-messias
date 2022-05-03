Class {
	#name : #Asserting,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
Asserting >> should: creationOfAnObject raise: error withMessage: errorMessage [

self should: creationOfAnObject raise: error whoseDescriptionIncludes: errorMessage description: 'Test did not failed as expected'.
]
