%clear all; close all;
err=0.005; format long
% Earthquake
dt=0.005;
E_intens=1;      % EQ Intensity
E_swit=3;        % EQ Switch 1:Newhall 2:Sylmar 3:El Centro 4:Rinaldi 5:Kobe 6:Jiji 7:Erzinkan
E_direc=1;       % EQ Direction 1:FP-X,FN-Y 2:FN-X,FP-Y

if E_direc==1
    x_direc=1;y_direc=2;
else 
    x_direc=2;y_direc=1;
end

switch E_swit
    case 1
        load newhall.txt;
        Nt=length(newhall(:,1)');   ag=zeros(3,Nt); ag(x_direc,:)=newhall(:,1)';  ag(y_direc,:)=newhall(:,2)';
    case 2
        load sylmar.txt;
        Nt=length(sylmar(:,1)');    ag=zeros(3,Nt); ag(x_direc,:)=sylmar(:,1)';   ag(y_direc,:)=sylmar(:,2)';
    case 3
        load elcentro.txt;
        Nt=length(elcentro(:,1)');  ag=zeros(3,Nt); ag(x_direc,:)=elcentro(:,1)'; ag(y_direc,:)=elcentro(:,2)';
    case 4
        load rinaldi.txt;
        Nt=length(rinaldi(:,1)');   ag=zeros(3,Nt); ag(x_direc,:)=rinaldi(:,1)';  ag(y_direc,:)=rinaldi(:,2)';
    case 5
        load kobe.txt;
        Nt=length(kobe(:,1)');      ag=zeros(3,Nt); ag(x_direc,:)=kobe(:,1)';     ag(y_direc,:)=kobe(:,2)';
    case 6
        load jiji.txt;
        Nt=length(jiji(:,1)');      ag=zeros(3,Nt); ag(x_direc,:)=jiji(:,1)';     ag(y_direc,:)=jiji(:,2)';
    case 7
        load erzikan.txt;
        Nt=length(erzikan(:,1)');   ag=zeros(3,Nt); ag(x_direc,:)=erzikan(:,1)';  ag(y_direc,:)=erzikan(:,2)';
end
ag=ag/100*E_intens;   % (m/s-2)
ag(3,:)=zeros(1,Nt); t=(0:1:Nt-1)*dt;

% Parameters of the superstrucrure and the base
load STRUC.mat;
m = STRUC.m; %(10^3kg) mass of base
M = STRUC.M; K = STRUC.K; C = STRUC.C;  %(10^3kg 10^3kgm^2) (kN/m) (kNs/m)
R = STRUC.R; H = STRUC.H; dh = STRUC.dh;
% R is the matrix of earthquake influence coefficients. H is the location matrix
MK=-M\K;MC=-M\C;m_RC=m\R'*C;m_RK=m\R'*K;

% Response without bearings
A0=[zeros(24,24) eye(24);MK MC]; B0=[zeros(24,3);-R];
C0=eye(48);D0=zeros(48,3);
resp_uncontroled=lsim(ss(A0,B0,C0,D0),ag,t,zeros(48,1));
us0=resp_uncontroled(:,1:24)'; % u-displacement,s0-superstructure without bearings
vs0=resp_uncontroled(:,25:48)'; % v-volcity
ab_as0=MK*us0+MC*vs0; % absolute acceleration

% Response with linear bearings
kl=H*919.422;cl=H*27.717;
mkl=m\kl;mcl=m\cl;
Al=[zeros(24,24) eye(24) zeros(24,6);MK-R*m_RK MC-R*m_RC R*mkl R*mcl;zeros(3,51) eye(3);m_RK m_RC -mkl -mcl];
Bl=[zeros(51,3);-eye(3)]; Cl=eye(54); Dl=zeros(54,3);
resp_l=lsim(ss(Al,Bl,Cl,Dl),ag,t,zeros(54,1));
usl=resp_l(:,1:24)'; % sl-superstructure with liear bearings
vsl=resp_l(:,25:48)';
ubl=resp_l(:,49:51)'; % bl-base with liear bearings
vbl=resp_l(:,52:54)';
ab_abl=Al(52:54,:)*[usl;vsl;ubl;vbl]; ab_asl=MK*usl+MC*vsl;

% Response with fractional bearings
A_h=pi()*0.27^2/0.18; % geometric parameters of the VE damper: shear area over shear heihgt 0.41^2/0.25 0.27^2/0.18
%parameters of FDZe model identified by the experiments. G1,G2,yita (kpa).
G1=4.794E3;G2=4.793E2; eta=2.483E2; alpha=0.520;  a_0=(G1+G2)/eta;b_1=A_h*G1; b_0=b_1*G2/eta;
wa=zeros(1,Nt-1);wa(1)=alpha;UL=Nt-1;T=dt^alpha;
for i=2:1:Nt-1
    temp=(1+alpha)/i;wa(i)=wa(i-1)*(1-temp);
    if abs(err>temp)
        UL=i-1;
        break;
    end
end
%superstucture subsystem
As=[zeros(24,24) eye(24) zeros(24,6);MK-R*m_RK MC-R*m_RC zeros(24,6);zeros(3,51) eye(3);m_RK m_RC zeros(3,6)];
Bs=[zeros(24,6);zeros(24,3) R/m;zeros(3,6);-eye(3) -inv(m)]; Cs=eye(54); Ds=zeros(54,6);
sys=ss(As,Bs,Cs,Ds) ;sysd=c2d(sys,dt);Asd=sysd.A;Bsd=sysd.B;Csd=sysd.C;Dsd=sysd.D;% convert continous SS to discrete SS
%bearing subsystem
Ab=-a_0*T*eye(3); Bb=T*eye(3); Cb=(b_0-a_0*b_1)*H; Db=b_1*H;
xb_initial=zeros(3,1);xs_initial=zeros(54,1);
Reduce=zeros(3,54);Reduce(:,49:51)=eye(3);aN=alpha*[1;1;1];

%simulation
input=[t' ag'];sim('fsim_2016a');
usf=usb.data(:,1:24)'; % s-superstructure f-fractional bearings
vsf=usb.data(:,25:48)';
ubf=usb.data(:,49:52)'; % b-base
Fgf=Fb.data'; % force of the ground
ab_abf=As(52:54,1:48)*[usf;vsf]+Bs(52:54,4:6)*Fgf; ab_asf=MK*usf+MC*vsf;

%drift
dus0=zeros(8,Nt,3);dusl=zeros(8,Nt,3);dusf=zeros(8,Nt,3);
for i=1:1:3
    dus0(1,:,i)=us0(i,:)/dh(1);
    dusl(1,:,i)=usl(i,:)/dh(1);
    dusf(1,:,i)=usf(i,:)/dh(1);
    for j=2:1:8
        dus0(j,:,i)=(us0(i+(j-1)*3,:)-us0(i+(j-2)*3,:))/dh(j);
        dusl(j,:,i)=(usl(i+(j-1)*3,:)-usl(i+(j-2)*3,:))/dh(j);
        dusf(j,:,i)=(usf(i+(j-1)*3,:)-usf(i+(j-2)*3,:))/dh(j);
    end
end

% Force of floor and base
Fs0=zeros(24,Nt);Fsl=Fs0;Fsf=Fs0; % force of floor
Fs0(1:3,:)=R'*(C*vs0+K*us0); % force of first storey
Fsl(1:3,:)=R'*(C*vsl+K*usl); 
Fsf(1:3,:)=Fgf+m*ab_abf;% to verified: Fsf_veri=R'*(C*vsf+K*usf);
Fg0=Fs0(1:3,:)-m*ag;  % force of the ground
Fgl=Fsl(1:3,:)-m*ab_abl;
for i=1:1:7
    Fs0(3*i+1:3*i+3,:)=Fs0(3*i-2:3*i,:)+M(3*i-2:3*i,3*i-2:3*i)*ab_as0(3*i-2:3*i,:);
    Fsl(3*i+1:3*i+3,:)=Fsl(3*i-2:3*i,:)+M(3*i-2:3*i,3*i-2:3*i)*ab_asl(3*i-2:3*i,:);
    Fsf(3*i+1:3*i+3,:)=Fsf(3*i-2:3*i,:)+M(3*i-2:3*i,3*i-2:3*i)*ab_asf(3*i-2:3*i,:);
end

%Evaluation
V0l=zeros(1,Nt);V0f=zeros(1,Nt); % Peak base shear
V1l=zeros(1,Nt);V1f=zeros(1,Nt); % Peak structure shear (at first storey level)
dil=zeros(1,Nt);dif=zeros(1,Nt); % Peak base displacement
dfl=zeros(8,Nt);dff=zeros(8,Nt); % Peak inter-storey drift
afl=zeros(8,Nt);aff=zeros(8,Nt); % Peak absolute floor acceleration
sigma_dl=sqrt(rms(ubl(1,:))^2+rms(ubl(2,:))^2);sigma_df=sqrt(rms(ubf(1,:))^2+rms(ubf(2,:))^2); % RMS base displacement
sigma_al=zeros(1,8);sigma_af=zeros(1,8); % RMS absolute floor acceleration
Jl=zeros(1,7);Jf=zeros(1,7);

for i=1:1:Nt
    V0l(i)=sqrt(Fgl(1,i)^2+Fgl(2,i)^2);
    V1l(i)=sqrt(Fsl(1,i)^2+Fsl(2,i)^2);
    dil(i)=sqrt(ubl(1,i)^2+ubl(2,i)^2);
    
    V0f(i)=sqrt(Fgf(1,i)^2+Fgf(2,i)^2);
    V1f(i)=sqrt(Fsf(1,i)^2+Fsf(2,i)^2);
    dif(i)=sqrt(ubf(1,i)^2+ubf(2,i)^2);
end
Jl(1)=max(V0l(:));Jl(2)=max(V1l(:));Jl(3)=max(dil(:));
Jf(1)=max(V0f(:));Jf(2)=max(V1f(:));Jf(3)=max(dif(:));

for j=1:1:8
    for i=1:1:Nt
        dfl(j,i)=sqrt(dusl(j,i,1)^2+dusl(j,i,2)^2);
        afl(j,i)=sqrt(ab_asl(3*j-2,i)^2+ab_asl(3*j-1,i)^2);
        
        dff(j,i)=sqrt(dusf(j,i,1)^2+dusf(j,i,2)^2);
        aff(j,i)=sqrt(ab_asf(3*j-2,i)^2+ab_asf(3*j-1,i)^2);
    end
    sigma_al(j)=sqrt(rms(ab_asl(3*j-2,:))^2+rms(ab_asl(3*j-1,:))^2);
    sigma_af(j)=sqrt(rms(ab_asf(3*j-2,:))^2+rms(ab_asf(3*j-1,:))^2);
end
Jl(4)=max(max(dfl));Jl(5)=max(max(afl));Jl(6)=max(sigma_dl);Jl(7)=max(sigma_al);
Jf(4)=max(max(dff));Jf(5)=max(max(aff));Jf(6)=max(sigma_df);Jf(7)=max(sigma_af);
J=Jf./Jl;
