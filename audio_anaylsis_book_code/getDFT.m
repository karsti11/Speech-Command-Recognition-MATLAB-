function [FFT, Freq] = getDFT(signal, Fs, PLOT)

N = length(signal);

FFT = abs(fft(signal))/N;

if nargin == 2
    FFT = FFT(1:ceil(N/2));
    Freq = (Fs/2) * (1:ceil(N/2)) / ceil(N/2);
else
    if (nargin == 3)
        FFT = fftshift(FFT);
        if mod(N,2) == 0
            Freq = -N/2:N/2-1;
        else
            Freq = -(N-1) / 2:(N-1)/2;
        end
        Freq = (Fs/2) * Freq ./ ceil(N/2);
    end
end

 