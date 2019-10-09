function F = feature_spectral_flux(windowFFT, windowFFTPrev)

%normalize the two spectra
windowFFT = windowFFT / sum(windowFFT);
windowFFTPrev = windowFFTPrev / sum(windowFFTPrev + eps);

%compute the spectral flux as the sum of square distances
F = sum((windowFFT - windowFFTPrev) .^ 2);