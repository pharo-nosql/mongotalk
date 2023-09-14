"
This class is taken from the Cryptography package, kudos to their original authors.

PBKDF2 implementation based on RFC 2898 (http://tools.ietf.org/html/rfc2898).

Example: 

```
derivedKey := PBKDF2 new
	hashFunction: SHA1;
	password: 'password';
	salt: 'salt';
	iterations: 4096;
	length: 256;
	deriveKey.
```
		
You can also use some convenience class methods. E.g.:
```
derivedKey := PBKDF2 derivedKeySHA1Password: password salt: salt.`
```

## Defaults:

- prf: HMAC-SHA-1
- iterations: 1000
- length: 16 Bytes
	

"
Class {
	#name : #MongoPBKDF2,
	#superclass : #Object,
	#instVars : [
		'prf',
		'hLen',
		'p',
		's',
		'c',
		'dkLen'
	],
	#category : #'Mongo-Core-Auth'
}

{ #category : #'instance creation' }
MongoPBKDF2 class >> derivedKeyHashFunction: hashClass password: password salt: salt [
	^ PBKDF2 new
		hashFunction: hashClass;
		password: password;
		salt: salt;
		deriveKey
]

{ #category : #'instance creation' }
MongoPBKDF2 class >> derivedKeyHashFunction: hashClass password: password salt: salt iterations: iterations length: length [
	^ PBKDF2 new
		hashFunction: hashClass;
		password: password;
		salt: salt;
		iterations: iterations;
		length: length;
		deriveKey
]

{ #category : #'instance creation' }
MongoPBKDF2 class >> derivedKeyPseudoRandomFunction: prf password: password salt: salt iterations: iterations length: length [
	^ PBKDF2 new
		prf: prf;
		password: password;
		salt: salt;
		iterations: iterations;
		length: length;
		deriveKey
]

{ #category : #'instance creation' }
MongoPBKDF2 class >> derivedKeySHA1Password: password salt: salt [
	^ PBKDF2 new
		password: password;
		salt: salt;
		deriveKey
]

{ #category : #accessing }
MongoPBKDF2 >> c: anInteger [
	c := anInteger
]

{ #category : #accessing }
MongoPBKDF2 >> deriveBlock: i [
	| u un |
	un := prf
		key: p;
		digestMessage: s , (i asByteArrayOfSize: 4).
	u := un.
	c - 1
		timesRepeat: [ 
			un := prf digestMessage: un.
			u := u bitXor: un ].
	^ u
]

{ #category : #accessing }
MongoPBKDF2 >> deriveKey [
	| l |
	dkLen > (((2 raisedTo: 32) - 1) * hLen)
		ifTrue: [ self error: 'derived key too long' ].	"If dkLen > (2^32 - 1) * hLen, output 'derived key too long' and
         stop."
	l := (dkLen / hLen) ceiling.	"Let l be the number of hLen-octet blocks in the derived key,
         rounding up"	"r := dkLen - ((l - 1) * hLen)."	"and let r be the number of octets in the last
         block:"
	^ (ByteArray streamContents: [ :dkStream | 1 to: l do: [ :i | dkStream nextPutAll: (self deriveBlock: i) ] ]) contents
		copyFrom: 1
		to: dkLen
]

{ #category : #accessing }
MongoPBKDF2 >> dkLen: anInteger [
	dkLen := anInteger
]

{ #category : #accessing }
MongoPBKDF2 >> hashFunction: anHashFunction [
	self prf: anHashFunction new hmac
]

{ #category : #initialization }
MongoPBKDF2 >> initialize [
	self
		hashFunction: SHA1;
		iterations: 1000;
		length: 16
]

{ #category : #accessing }
MongoPBKDF2 >> iterations: anInteger [
	self c: anInteger
]

{ #category : #accessing }
MongoPBKDF2 >> length: anInteger [
	self dkLen: anInteger
]

{ #category : #accessing }
MongoPBKDF2 >> p: aByteArray [
	p := aByteArray
]

{ #category : #accessing }
MongoPBKDF2 >> password: aString [
	self p: aString asByteArray
]

{ #category : #accessing }
MongoPBKDF2 >> prf: aPseudoRandomFunction [
	prf := aPseudoRandomFunction.
	hLen := self prfHLen: aPseudoRandomFunction
]

{ #category : #accessing }
MongoPBKDF2 >> prfHLen: aPseudoRandomFunction [
	^ aPseudoRandomFunction digestSize
]

{ #category : #accessing }
MongoPBKDF2 >> prfKey: k message: m [
	^ prf
		key: k;
		digestMessage: m
]

{ #category : #accessing }
MongoPBKDF2 >> s: aByteArray [
	s := aByteArray
]

{ #category : #accessing }
MongoPBKDF2 >> salt: aString [
	self s: aString asByteArray
]
