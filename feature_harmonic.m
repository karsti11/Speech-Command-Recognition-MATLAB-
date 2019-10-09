function [HR, f0] = feature_harmonic(window, Fs, M, m0)

if nargin < 3
    M = round(0.016*Fs);
end
%compute autocorrelation:
R = xcorr(window);
g = R(length(window));

R = R(length(window) + 1:end);
i = 2;
if nargin < 4
    %estimate m0 (as the first zero crossing of R)
    m0 = length(R) + 1;
    while i <= length(R)
        if R(i) < 0 && R(i-1) >= 0
            m0 = i;
            break;
        end
        i = i +1;
    end
end

if M > length(R) M = length(R); end
%compute normalized autocorrelation:
Gamma = zeros(M,1);
csum = cumsum(window.^2);

Gamma(m0:M) = R(m0:M) ./ (sqrt((g*csum(end-m0:-1:end-M)))+eps);
Z = feature_zcr(Gamma);
if Z > 0.15
    HR = 0;
    f0 = 0;
else
    %compute T0 and harmonic ratio:
    if isempty(Gamma)
        HR = 1;
        blag = 0;
        Gamma = zeros(M,1);
    else
        [HR, blag] = max(Gamma);
    end
    %get fundamental frequency:
    f0 = Fs / blag;
    if f0 > 5000 f0 = 0; end
    if HR < 0.1 f0 = 0; end
end