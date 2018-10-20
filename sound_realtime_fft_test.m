clear;
clc;
Fs = 44100;
T = 1;
t = 0:1/Fs:T-1/Fs;
nfft = 2^nextpow2(Fs);
numUniq = ceil((nfft+1)/2);
f = (0:numUniq-1)'*Fs/nfft;

figure;
hAx(1) = subplot(211);
hLine(1) = line('XData',t, 'YData',nan(size(t)), 'Color','b', 'Parent',hAx(1));
xlabel('Time (s)'), ylabel('Amplitude');
hAx(2) = subplot(212);
hLine(2) = line('XData',f, 'YData',nan(size(f)), 'Color','b', 'Parent',hAx(2));
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)');
set(hAx, 'Box','on', 'XGrid','on', 'YGrid','on');

recObj = audiorecorder(Fs,8,1);

disp('Start speaking...');
for i=1:10
    recordblocking(recObj, T);

    sig = getaudiodata(recObj);
    fftMag = 20*log10( abs(fft(sig,nfft)) );

    set(hLine(1), 'YData',sig);
    set(hLine(2), 'YData',fftMag(1:numUniq));
    title(hAx(1), num2str(i,'Interval = %d'));
    drawnow;
end
disp('Done.');