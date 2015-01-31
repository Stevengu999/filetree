validation
validateExtensionMethodCategory: categoryName for: className selector: selector
  "https://github.com/dalehenrich/filetree/issues/136"

  "method category must match the package name for extension methods... guard against manual editing mistakes"

  "extracted from PackageInfo>>isForeignClassExtension:"

  | prefix prefixSize catSize |
  true
    ifTrue: [ 
      "https://github.com/GsDevKit/gsDevKitHome/issues/53: faulty filetree package validation logic"
      ^ self ].
  prefix := '*' , self packageNameFromPackageDirectory asLowercase.
  categoryName
    ifNotNil: [ 
      (categoryName isEmpty not
        and: [ 
          categoryName first = $*
            and: [ 
              "asLowercase needed in GemStone 3.1.0.6?"
              self verifyCategory: categoryName asLowercase matches: prefix ] ])
        ifTrue: [ ^ self ] ].
  self
    error:
      'Method protocol ' , categoryName printString , ' for the method '
        , selector printString , ' in class ' , className printString
        , ' is inconsistent with the package name ' , prefix printString