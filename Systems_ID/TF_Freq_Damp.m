function [SysId] = TF_Freq_Damp(in,out,fc,Ts,butter_order,nfft,f_min,f_max,nn,np)
[B,A]=butter(butter_order,fc/((1/Ts)/2),'low');  
in = filtfilt(B,A,in);
out = filtfilt(B,A,out);

[TF_full,Freq_full] = tfestimate(in,out,hamming(nfft),.6*nfft,round(nfft),1/Ts);
f_start = find(Freq_full>= f_min,1,'first');
f_end = find(Freq_full<= f_max,1,'last');
freq_series = Freq_full(f_start:f_end);
TF = TF_full(f_start:f_end);

magnitud = abs(TF);
dB = db(magnitud);
phase = angle(TF);
ang = -abs((180/pi)*phase);

SysId.freq_series=freq_series;
SysId.dB=dB;
SysId.ang=ang;

if nn==0||np==0
    return;
end

freq_rad = 2*pi*freq_series; % convert Freq from Hz to rad/s
[num_id,den_id] = invfreqs(magnitud.*exp(1i*phase),freq_rad,nn,np,ones(1,length(freq_series)));

magnitud_id = freqs(num_id,den_id,freq_rad);
dB_id = db(magnitud_id);  
ang_id = -abs(angle(magnitud_id)*(180/pi));

sys = tf(num_id,den_id);
[w,xi] = damp(sys);

SysId.dB_id=dB_id;
SysId.ang_id=ang_id;
SysId.Freq=w(1:2:end,:)/2/pi;
SysId.Damp=xi(1:2:end,:)*100;

end

