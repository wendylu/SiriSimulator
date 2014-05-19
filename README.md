SiriSimulator
=============

An app that mimics the visual elements of Siri. Can be configured to show resting, listening, loading, and loaded states.

## Get Started

```
git clone git@github.com:wendylu/SiriSimulator.git
```

## Requirements

SiriSimulator requires iOS 7.1 or higher and ARC

## About This Project

**SiriSimulator runs on four states:**  
You can tap the info icon in the lower left corner to test out these states.

`kSiriStateSmallWave` corresponds the intial "resting" state of Siri when it is first activated
    
`kSiriStateLargeWave` corresponds to the "listening" state of Siri when it has detected speech
    
`kSiriStateLoading` corresponds to the "loading" state of Siri after the user stops speaking
    
`kSiriStateLoaded` corresponds to the "loaded" state of Siri after it has finished processing and returned a response

![Imgur](http://i.imgur.com/P23mvn2.gif)
