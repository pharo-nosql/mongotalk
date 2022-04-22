Class {
	#name : #MongoMovingAverageCalculatorTest,
	#superclass : #TestCase,
	#instVars : [
		'calculator'
	],
	#category : 'Mongo-Client-Tests'
}

{ #category : #tests }
MongoMovingAverageCalculatorTest >> testFirstValue [
	calculator := MongoMovingAverageCalculator new.
	calculator add: 10.
	self assert: calculator average equals: 10.
]

{ #category : #tests }
MongoMovingAverageCalculatorTest >> testInitiallyNaN [
	calculator := MongoMovingAverageCalculator new.
	self assert: calculator average == Float nan.

]

{ #category : #tests }
MongoMovingAverageCalculatorTest >> testReset [
	calculator := MongoMovingAverageCalculator new.
	calculator add: 10.
	calculator add: 20.
	calculator add: 30.
	calculator reset.
	self assert: calculator average == Float nan.

]

{ #category : #tests }
MongoMovingAverageCalculatorTest >> testWeightedValues [
	calculator := MongoMovingAverageCalculator new.
	calculator add: 10.
	calculator add: 20.
	self assert: calculator average closeTo: 12.
	calculator add: 30.
	self assert: calculator average closeTo: 15.6.

]
