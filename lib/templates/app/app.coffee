# require vendor libraries
_ = require('vendor/underscore')._
require('vendor/titanium_utils').apply(Ti.App)

# This is a single context application with multiple windows in a stack
do -> require('initialize').initApp()
