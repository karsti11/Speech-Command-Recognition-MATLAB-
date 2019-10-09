[filenames, pathname, filterindex] = uigetfile( '*.wav', 'WAV-files (*.wav)','Pick a file', 'MultiSelect', 'on');
   %in case only one selected
   y = zeros(16000, length(filenames));
   fs = zeros(length(filenames),1);
for K = 1 : length(filenames)
  
  thisfullname = fullfile(pathname, filenames{K});
  
  y1 = audioread(thisfullname);
  L = length(y1);
  if L < 16000
      y1 = padarray(y1,16000-L,0,'post');
  end
  y(:,K) = y1;
  %speechIn6 = myVAD(speechIn6);
  %fMatrix6(1,o) = {mfccf(ncoeff,speechIn6,FS6)};
  
end


