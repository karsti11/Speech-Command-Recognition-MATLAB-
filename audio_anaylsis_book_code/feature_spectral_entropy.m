function En = feature_spectral_entropy(windowFFT, numOfShortBlocks)

fftLength = length(windowFFT);
%total frame (spectral) energy
Eol = sum(windowFFT.^2);

%length of subframe
subWinLength = floor(fftLength / numOfShortBlocks);

if length(windowFFT) ~= subWinLength * numOfShortBlocks
    windowFFT = windowFFT(1:subWinLength * numOfShortBlocks);
end

%define sub frames
subWindows = reshape(windowFFT, subWinLength, numOfShortBlocks);

%compute spectral sub-energies
s = sum(subWindows.^2) / (Eol + eps);

% compute spectral entropy
En = - sum(s .* log2(s + eps));