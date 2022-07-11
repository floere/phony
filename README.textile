"!{float:right}https://secure.travis-ci.org/floere/phony.png!":http://travis-ci.org/floere/phony
!https://coveralls.io/repos/floere/phony/badge.svg?branch=master(Coverage Status)!:https://coveralls.io/r/floere/phony?branch=master
"!https://codeclimate.com/github/floere/phony.png!":https://codeclimate.com/github/floere/phony
!http://inch-ci.org/github/floere/phony.png!:http://inch-ci.org/github/floere/phony

h1. Phony

Disclaimer: Phony works with international numbers only, such as @61 412 345 678@!

The (admittedly crazy) goal of this Gem is to be able to normalize/format/split all phone numbers in the world.

Used in: "airbnb.com":http://airbnb.com, "socialcam.com":http://socialcam.com, "zendesk.com":http://www.zendesk.com/ (and many, many others).

h2(#memory). Runtime Memory Usage

According to "memory_profiler":https://github.com/SamSaffron/memory_profiler, the Phony gem uses roughly 1MB of memory per Ruby process.
Usage was generated using (look for @Total retained@): @ruby -e 'require "memory_profiler"; MemoryProfiler.report(allow_files: "phony"){ require "phony" }.pretty_print'@

h2. Description

This gem normalizes, formats and splits "*E164 phone numbers*":http://en.wikipedia.org/wiki/E.164. A valid E164 phone number *must* include a country code.

E164 numbers are international numbers with a country dial prefix, usually an area code and a subscriber number. For example, the Australian number @+61 412 345 678@ can be broken down into the following components:
* Country Code (CC): a country code of @61@
* National Destination Code (NDC): a mobile number denoted by the @4@ (specific to Australia)
* Local Number Part: a subscriber number of @12 345 678@

It currently handles the countries listed at the end of this README.

It is covered by roughly 2,250 tests that run in 2 seconds (April 2019).
If it doesn't work, please "enter an issue":http://github.com/floere/phony/issues or better, fork and "send a pull request":http://github.com/floere/phony/pulls.

h2. Installation

With Rails? Check out: https://github.com/joost/phony_rails.

With Bundler: Append @gem 'phony'@ to your @Gemfile@ and @bundle install@ it.

Without Bundler: Run @gem install phony@ from your command line.

h2(#usage). Usage docs

Phony uses "qed":https://github.com/rubyworks/qed as docs and to run its functional tests. Start here for usage docs: "Usage index":./qed/index.md.

h3(#normalizing). Phony.normalize(number)

Normalize intelligently removes all non-numeric characters of a number. Do it before storing a number in a DB.

"Phony.normalize docs":./qed/normalize.md

@Phony.normalize('1-888-407-4747').assert == '18884074747'@

h3(#formatting). Phony.format(number, options = {})

Format formats a normalized number according to a country's predominant formatting. Lots of options for int'l, national, local formatting.

"Phony.format docs":./qed/format.md

@Phony.format('41443643532').assert == '+41 44 364 35 32'@

h3(#plausibility). Phony.plausible?(number, options = {})

Is a number plausible?

"Phony.plausible? docs":./qed/plausibility.md

@Phony.assert.plausible?('+41 44 111 22 33')@

h3(#splitting). Phony.split(number)

Split a number into its parts: CC, NDC, local.

"Phony.split docs":./qed/split.md

@Phony.split('3928061371').assert == ['39', '2', '806', '1371']@

NB If a country does not have an NDC, @#split@ will return @false@ in the NDC position, for example for Denmark:

@Phony.split('4512121212').assert == ['45', false, '12', '12', '12', '12']@

h3(#loading). Loading only a country subset (Phony 2.18.0+).

Use this in case you'd like to save "memory":#memory that is used by Phony's CC rules.

"Phony::Config.load docs":./qed/config.md

First, @require 'phony/config'@.
Then, one of the following, which will load the rest of Phony.

Load only these CCs:
@Phony::Config.load(only: ['41', '44'])@

Loads everything except these CCs:
@Phony::Config.load(except: ['41', '44'])@

Convenience form of @only@:
@Phony::Config.load('41', '44')@

Each of these loads the rest of Phony.

Memory usage can be checked using (look for @Total retained@):
@ruby -e 'require "memory_profiler"; MemoryProfiler.report(allow_files: "phony"){ require "phony/config"; Phony::Config.load("1") }.pretty_print'@
For example, when just loading the NANP CC, the retained memory usage is ~63kB.

h2. List of Handled Countries

Mildly unmaintained list: Abhas, Afghan, Algerian, Argentina, Austrian, Australian, Azerbaijani, Belgian, Brazilian, Cambodian, Chilean, Chinese, Croatian, Cuban, Cypriot, Czech, Danish, Dutch, Egyptian, El Salvadorian, Estonian, French, German, Ghanan, Gibraltar, Greek, Haiti, Hong Kong, Hungarian, Indian, Iran, Irish, Israel, Italian, Japanese, Kazakh, Liberian, Lithuanian, Luxembourgian, Malaysian, Malta, Mexican, Monaco, Morocco, New Zealand, Nigerian, Norwegian, Peruvian, Polish, Romanian, Russian, Rwandan, Seychelles, Singapore, Slovakian, South African, South Korean, South Osetian, Spanish, Sri Lankan, Sudan, Swedish, Swiss, Thailand, Tunisian, Turkish, Liechtenstein, UK, US, Venezuelan, Vietnamese, and Zambian numbers.

h2. Proud Sponsors

* Renuo AG (July 22 –): "Github":https://github.com/renuo, "Homepage":https://www.renuo.ch

h2. License

MIT.
See "LICENSE":./LICENSE file.
