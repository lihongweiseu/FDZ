% ------ generate chirp input ------
clc, clear, close all
dt=0.005; fs = 1/dt; %sampling time and sampling rate
t= 0:1/fs:420; %7 minutes
fmin=.005; fmax=30; %minimum and maximum frequencies
in=chirp(t,fmin,t(end),fmax,'quadratic',-90);

% ------ stucture information ------
err=0.005; Nt=84001;
load STRUC.mat;
m = STRUC.m; %(10^3kg) mass of base
M = STRUC.M; K = STRUC.K; C = STRUC.C;  %(10^3kg 10^3kgm^2) (kN/m) (kNs/m)
R = STRUC.R; H = STRUC.H; dh = STRUC.dh;
MK=-M\K;MC=-M\C;m_RC=m\R'*C;m_RK=m\R'*K;

% FIX system
A0=[zeros(24,24) eye(24);MK MC]; B0=[zeros(24,3);-R];
C0=eye(48);D0=zeros(48,3);

% ELA system
kl=H*919.422;cl=H*27.717;%cl=H*27.717;%cl=H*183.884;
mkl=m\kl;mcl=m\cl;
Al=[zeros(24,24) eye(24) zeros(24,6);MK-R*m_RK MC-R*m_RC R*mkl R*mcl;zeros(3,51) eye(3);m_RK m_RC -mkl -mcl];
Bl=[zeros(51,3);-eye(3)]; Cl=eye(54); Dl=zeros(54,3);

% FDZ system
A_h=pi()*0.45^2/0.5; % geometric parameters of the VE damper: shear area over shear heihgt
G1=4.794E3;G2=4.793E2; eta=2.483E2; alpha=0.520;  a_0=(G1+G2)/eta;b_1=A_h*G1; b_0=b_1*G2/eta;
GL=zeros(1,Nt-1);GL(1)=-alpha;UL=Nt-1;T=dt^alpha;
for i=2:1:Nt-1
    temp=(1+alpha)/i;GL(i)=GL(i-1)*(1-temp);
    if abs(err>temp)
        UL=i-1;
        break;
    end
end
As=[zeros(24,24) eye(24) zeros(24,6);MK-R*m_RK MC-R*m_RC zeros(24,6);zeros(3,51) eye(3);m_RK m_RC zeros(3,6)];
Bs=[zeros(24,6);zeros(24,3) R/m;zeros(3,6);-eye(3) -inv(m)]; Cs=eye(54); Ds=zeros(54,6);
sys=ss(As,Bs,Cs,Ds) ;sysd=c2d(sys,dt);Asd=sysd.A;Bsd=sysd.B;Csd=sysd.C;Dsd=sysd.D;% convert continous SS to discrete SS
Ab=-a_0*T*eye(3); Bb=T*eye(3); Cb=(b_0-a_0*b_1)*H; Db=b_1*H;
xb_initial=zeros(3,1);xs_initial=zeros(54,1);
Reduce=zeros(3,54);Reduce(:,49:51)=eye(3);

% ------ stucture output ------
a_FIX=zeros(8,Nt,3);  % 3 dirs, 8 floors
a_ELA=zeros(9,Nt,3);  % 3 dirs, base + 8 floors
a_FDZ=zeros(9,Nt,3);  % 3 dirs, base + 8 floors

for dir=1:1:3 % dir=1,2,3 means x-dir, y-dir, y-dir.
    % earthquake
    ag=zeros(3,Nt);
    ag(dir,:)=in;
    
    % FIX system
    resp_uncontroled=lsim(ss(A0,B0,C0,D0),ag,t,zeros(48,1));
    us0=resp_uncontroled(:,1:24)';  % u-displacement,s0-superstructure without bearings
    vs0=resp_uncontroled(:,25:48)'; % v-volcity
    ab_as0=MK*us0+MC*vs0; % absolute acceleration
    
    % ELA system
    resp_l=lsim(ss(Al,Bl,Cl,Dl),ag,t,zeros(54,1));
    usl=resp_l(:,1:24)'; % sl-superstructure with liear bearings
    vsl=resp_l(:,25:48)';
    ubl=resp_l(:,49:51)'; % bl-base with liear bearings
    vbl=resp_l(:,52:54)';
    ab_asl=MK*usl+MC*vsl;
    ab_abl=Al(52:54,:)*[usl;vsl;ubl;vbl];
    
    % FDZ system
    agt=[t' ag'];sim('fss2016a_'); clear fss_sf;
    usf=usb.data(:,1:24)'; % s-superstructure f-fractional bearings
    vsf=usb.data(:,25:48)';
    ubf=usb.data(:,49:51)'; % b-base
    Fgf=Fb.data'; % force of the ground
    ab_asf=MK*usf+MC*vsf;
    ab_abf=As(52:54,1:48)*[usf;vsf]+Bs(52:54,4:6)*Fgf;
    
    a_ELA(1,:,dir)=ab_abl(dir,:);
    a_FDZ(1,:,dir)=ab_abf(dir,:);
    
    
    for floor=1:1:8
        a_FIX(floor,:,dir)=ab_as0(3*floor-3+dir,:); %FIX system
        a_ELA(floor+1,:,dir)=ab_asl(3*floor-3+dir,:); %ELA system
        a_FDZ(floor+1,:,dir)=ab_asf(3*floor-3+dir,:); %FDZ system
    end
end

% ------ save data ------
in_out.t=t; in_out.Ts=dt; in_out.fs=fs; in_out.Nt=Nt; in_out.in=in;
in_out.a_FIX=a_FIX; in_out.a_ELA=a_ELA; in_out.a_FDZ=a_FDZ; 
save('input_output_xyr.mat', '-struct','in_out');
