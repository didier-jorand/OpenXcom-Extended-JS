# JSUI Readme

## Overview

JSUI defines _mirror_ classes of the OpenXcom `Interface` classes,
in order to provide access to the game UI element in Javascript.



## Implementation

Each Javascript class mirrors the methods of an OpenXcom class.

These methods are triggered by a proxy class (C++) which inherits
from the OpenXcom class.

Example

(C++) TextButton <=inherit= (C++) JSTextButton <-wrappers- (Javascript) JSTextButton


