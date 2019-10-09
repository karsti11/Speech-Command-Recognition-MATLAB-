function detect_command(theta_mat)

recorder = audiorecorder(16000,16,1);

disp('Please record your voice...');
drawnow();
recordblocking(recorder, 1);
play(recorder);

data = getaudiodata(recorder);

Features_data = TestingFeatures(data,16000,0.05,0.05);
Features_data = Features_data';
Features_data = Features_data(:);

dataFeatures = [1; Features_data];
data_predict = theta_mat * dataFeatures;

[word_num, word_index] = max(data_predict);

switch word_index
    case 1
        disp('Detected word is "Yes"')
    case 2
        disp('Detected word is "No"')
    case 3
        disp('Detected word is "Marvin"')
end

