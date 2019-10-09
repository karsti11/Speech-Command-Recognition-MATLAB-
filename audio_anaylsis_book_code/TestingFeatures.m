function Features = TestingFeatures(signal, fs, win, step)
% size of signal eg. 16000x1
if (size(signal,2) > 1)
    signal = (sum(signal,2)/2);
end

windowLength = round(win * fs);
step = round(step * fs);
curPos = 1;
L = length(signal);

numOfFrames = floor((L-windowLength)/step) + 1;

numOfFeatures = 3;
Features = zeros(numOfFeatures, numOfFrames);
Ham = window(@hamming, windowLength);


for i = 1:numOfFrames
    frame = signal(curPos:curPos + windowLength - 1);
    frame = frame .* Ham;
    frameFFT = getDFT(frame, fs);
    if (sum(abs(frame))>eps)
        %Features(1,i) = feature_zcr(frame);
        %Features(1,i) = feature_energy(frame);
        %Features(1,i) = feature_energy_entropy(frame, 10);
%         
         if (i==1) frameFFTPrev = frameFFT; end
         [Centr, Spread] = ...
             feature_spectral_centroid(frameFFT, fs);
         Features(1,i) = Centr;
         Features(2,i) = Spread;
         Features(3,i) = feature_spectral_entropy(frameFFT, 10);
         %Features(1,i) = feature_spectral_flux(frameFFT, frameFFTPrev);
         %Features(2,i) = feature_spectral_rolloff(frameFFT, 0.90);
%        
         %[HR, F0] = feature_harmonic(frame, fs);
         %Features(3,i) = HR;
         %Features(1,i) = F0;
        %Features(8,i) = Features(3,i) / Features(1,i);
        %Features(9,i) = Features(3,i) / Features(2,i);
        %Features(10,i) = Features(4,i) / Features(1,i);
        %Features(11,i) = Features(4,i) / Features(2,i);
    else
        Features(:,i) = zeros(numOfFeatures, 1);
    end
    curPos = curPos + step;
    frameFFTPrev = frameFFT;
end
%Features(35, :) = medifilt1(Features(35, :),3);


        
        
