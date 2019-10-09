function Entropy = feature_energy_entropy(window, numOfShortBlocks)

%total frame energy
Eol = sum(window.^2);
winLength = length(window);
subWinLength = floor(winLength / numOfShortBlocks);

if length(window) ~= subWinLength * numOfShortBlocks
    window = window(1:subWinLength * numOfShortBlocks);
end
%get subwindows
subWindows = reshape(window, subWinLength, numOfShortBlocks);
%compute normalized sub-frame energies
s = sum(subWindows.^2) / (Eol+eps);
%compute entropy of the normalized sub-frame energies
Entropy = -sum(s.*log2(s+eps));