# Speech-Command-Recognition-MATLAB-


Three word classification between "Yes", "No" and "Marvin in MATLAB

Speech commands recognition in this case was made with help of using and modifying following code sources:
  1. Coursera Machine learning course by Stanford (Andrew Ng) - coursera_code
  2. Theodoros Giannakopolous, Aggelos Pikrakis, "Introduction to audio analysis: A MATLAB approach", First edition 2014 - audio_analysis_book_code
  
  Features used for testing:
  - Zero Crossing Rate
  - Energy
  - Energy entropy
  - Spectral Centroid
  - Spectral Spread
  - Spectral Flux
  - Spectral Entropy
  - Spectral Rolloff
  - Harmonic Ratio
  - Fundamental frequency
  
  
Classification method used: Logistic Regression
  
Optimization: Conjugate gradient method (fmincg.m)

Function used for testing prediction: detect_command.m
