%% Read saved data, set values
clc, clear; close all; warning off;
load('input_output_xyr.mat')
in = detrend(in); 

fc = 90;                    % Cut off freq. [Hz]
butter_order=12;
nfft = 2^14;
f_min = .01;
f_max = 20;

%% Determine np_ELA, np_FDZ
% out=detrend(a_FDZ(5,:,1));
% SysId_try = TF_Freq_Damp(in,out,fc,Ts,butter_order,nfft,f_min,f_max,22,22);
% 
% figure('Name','check');
% subplot(2,1,1); % magnitude
% 
% semilogx(SysId_try.freq_series,SysId_try.dB,'LineStyle','-','color','b','linewidth',1); hold on; grid on;
% semilogx(SysId_try.freq_series,SysId_try.dB_id,'LineStyle','-','color','r','linewidth',1);%ylim([-50,50]);
% xlim([0,20]);
% 
% subplot(2,1,2); % Phase
% semilogx(SysId_try.freq_series,SysId_try.ang,'LineStyle','-','color','b','linewidth',1); hold on; grid on;
% semilogx(SysId_try.freq_series,SysId_try.ang_id,'LineStyle','-','color','r','linewidth',1);
% xlim([0,20]);

%% System identification
ELA_np=zeros(2,9,3); % order of numerator and denominator, base + 8 floors, 3 dirs
ELA_np(:,:,1)=[...   % x-dir
    20 20 20 20 20 20 20 20 20;
    20 22 22 22 22 22 22 22 22];
ELA_np(:,:,2)=[...   % y-dir
    20 20 20 20 20 20 20 20 20;
    20 22 22 22 22 22 22 22 22];
ELA_np(:,:,3)=[...   % r-dir
    20 20 20 20 20 20 20 20 20;
    20 20 20 20 20 20 20 20 20];

FDZ_np=zeros(2,9,3); % order of numerator and denominator, base + 8 floors, 3 dirs
FDZ_np(:,:,1)=[...   % x-dir
    22 32 22 22 22 22 22 22 22;
    22 32 22 24 22 24 24 24 24];
FDZ_np(:,:,2)=[...   % y-dir
    26 22 20 22 22 22 22 22 22;
    26 24 22 24 24 24 24 24 24];
FDZ_np(:,:,3)=[...   % r-dir
    24 22 22 20 20 20 20 20 20;
    24 22 22 20 20 20 20 20 20];

a_FIX_id=cell(8,3); a_ELA_id=cell(9,3); a_FDZ_id=cell(9,3); % base + 8 floors, 3 directions.
for dir=1:1:3
    out=detrend(a_ELA(1,:,dir));
    a_ELA_id{1,dir} = TF_Freq_Damp(in,out,fc,Ts,butter_order,nfft,f_min,f_max,ELA_np(1,1,dir),ELA_np(2,1,dir));
    out=detrend(a_FDZ(1,:,dir));
    a_FDZ_id{1,dir} = TF_Freq_Damp(in,out,fc,Ts,butter_order,nfft,f_min,f_max,FDZ_np(1,1,dir),FDZ_np(2,1,dir));
    
    for floor=1:1:8   
        out=detrend(a_FIX(floor,:,dir));
        a_FIX_id{floor,dir} = TF_Freq_Damp(in,out,fc,Ts,butter_order,nfft,f_min,f_max,0,0);
        out=detrend(a_ELA(1+floor,:,dir));
        a_ELA_id{1+floor,dir} = TF_Freq_Damp(in,out,fc,Ts,butter_order,nfft,f_min,f_max,ELA_np(1,1+floor,dir),ELA_np(2,1+floor,dir));
        out=detrend(a_FDZ(1+floor,:,dir));
        a_FDZ_id{1+floor,dir} = TF_Freq_Damp(in,out,fc,Ts,butter_order,nfft,f_min,f_max,FDZ_np(1,1+floor,dir),FDZ_np(2,1+floor,dir));
    end
end

ti=char('(a)','(b)','(c)','(d)'); % title label

figure('Name','sys_TF_a');set(gcf,'Position',[0 0 900 400]);
for dir=1:1:2 % x-dir, y-dir
    subplot(2,2,dir);
    semilogx(a_FIX_id{8,dir}.freq_series,a_FIX_id{8,dir}.dB,'LineStyle',':','color',[0.5,0.5,0.5],'linewidth',2); hold on; grid on;
    semilogx(a_ELA_id{1+8,dir}.freq_series,a_ELA_id{1+8,dir}.dB,'LineStyle','--','color','b','linewidth',1.5); hold on;
    semilogx(a_FDZ_id{1+8,dir}.freq_series,a_FDZ_id{1+8,dir}.dB,'LineStyle','-','color','r','linewidth',1.5);
    subplot(2,2,2+dir);
    semilogx(a_ELA_id{1,dir}.freq_series,a_ELA_id{1,dir}.dB,'LineStyle','--','color','b','linewidth',1.5); hold on;grid on;
    semilogx(a_FDZ_id{1,dir}.freq_series,a_FDZ_id{1,dir}.dB,'LineStyle','-','color','r','linewidth',1.5); 
end

for i=1:1:2
    for j=1:1:2
        subplot(2,2,2*j-2+i);
        axis([.1 20 -60 30]);
        set(gca,'xtick',[.1 .3  1 2 4 8  20],'ytick',-60:30:30)
        axesH = gca;
        set(axesH,'fontsize',12,'TickLabelInterpreter','latex');
        axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
        xlabel('\textbf{Frequency~(Hz)}','fontsize',12,'interpreter','latex');
        ylabel('\textbf{Magnitude.~(dB)}','fontsize',12,'interpreter','latex');
        h1=get(get(axesH,'xlabel'),'position');h2=get(get(axesH,'ylabel'),'extent');
        text(h2(1),h1(2),['\textbf{' ti(2*j-2+i,:) '}'],'fontsize',12,'interpreter','latex');
    end
end

subplot(2,2,1);
legend({'\textbf{FIX system}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',10,'interpreter','latex','location','SouthWest');

%% Natural requencies and damping ratios
FIX_Freq_Damp=zeros(24,2); % 24 modes; first colum: freqs, second colum: damping ratios.
eigenval2_FIX=[49.62	65.66	91.05	496.42	557.82	860.45	1674.41	1793.83	2858.65	3292.80	3511.06	5583.47	5743.95	5958.46	7453.32	7928.58	9248.47	9702.50	10431.08	11673.94	12011.94	12912.83	15828.77	17720.57]; 
for i=1:1:24
    FIX_Freq_Damp(i,1)=sqrt(eigenval2_FIX(i))/2/pi;
    FIX_Freq_Damp(i,2)=5;
end

ELA_Freq_Damp=zeros(9,8,2); FDZ_Freq_Damp=zeros(9,8,2); % first 9 modes, base + 8 floors, freq + damping ratios.

for dir=1:1:3
    for i=1:1:3
        for floor=1:1:8
            ELA_Freq_Damp(3*i+dir-3,floor,1)=a_ELA_id{1+floor,dir}.Freq(i);
            ELA_Freq_Damp(3*i+dir-3,floor,2)=a_ELA_id{1+floor,dir}.Damp(i);
            FDZ_Freq_Damp(3*i+dir-3,floor,1)=a_FDZ_id{1+floor,dir}.Freq(i);
            FDZ_Freq_Damp(3*i+dir-3,floor,2)=a_FDZ_id{1+floor,dir}.Damp(i);
        end
    end
end

ELA_Freq_Damp_xyr=zeros(9,4); % 9 modes; first colum: freqs mean, second colum: freqs std.
FDZ_Freq_Damp_xyr=zeros(9,4); % third colum: Damps mean, forth colum: Damps std.
ELA_Freq_Damp_xyr(:,1)=mean(ELA_Freq_Damp(:,:,1),2);
ELA_Freq_Damp_xyr(:,2)=std(ELA_Freq_Damp(:,:,1),1,2);
ELA_Freq_Damp_xyr(:,3)=mean(ELA_Freq_Damp(:,:,2),2);
ELA_Freq_Damp_xyr(:,4)=std(ELA_Freq_Damp(:,:,2),1,2);

FDZ_Freq_Damp_xyr(:,1)=mean(FDZ_Freq_Damp(:,:,1),2);
FDZ_Freq_Damp_xyr(:,2)=std(FDZ_Freq_Damp(:,:,1),1,2);
FDZ_Freq_Damp_xyr(:,3)=mean(FDZ_Freq_Damp(:,:,2),2);
FDZ_Freq_Damp_xyr(:,4)=std(FDZ_Freq_Damp(:,:,2),1,2);

ELA_Freq_Damp_sort=sortrows(ELA_Freq_Damp_xyr,1);
FDZ_Freq_Damp_sort=sortrows(FDZ_Freq_Damp_xyr,1);

num_bar=3; num_group=9;
x_loc=zeros(1,num_bar*num_group);
group_width = min(0.8, num_bar/(num_bar + 1.5));
for i=1:1:num_group
    for j=1:1:num_bar
        x_loc(num_bar*(i-1)+j)= i- group_width/2 + (2*j-1) * group_width / (2*num_bar);
    end
end
text_dir=char(...
    'x','y','x','y','x','y','r','r','r',...
    'y','x','x','x','y','y','r','r','r',...
    'y','y','y','x','x','x','r','r','r');

figure('Name','Freq_damp');set(gcf,'Position',[0 0 720 450]);
subplot(2,1,1);
Freq_mean_bar=[FIX_Freq_Damp(1:num_group,1) ELA_Freq_Damp_sort(1:num_group,1) FDZ_Freq_Damp_sort(1:num_group,1)];
Freq_std_bar=[ELA_Freq_Damp_sort(1:num_group,2) FDZ_Freq_Damp_sort(1:num_group,2)];
ba=bar(Freq_mean_bar);hold on; grid on;
set(ba(1),'FaceColor',[0.7,0.7,0.7]);set(ba(2),'FaceColor','b');set(ba(3),'FaceColor','r');
errorbar(Freq_mean_bar(:,2),Freq_std_bar(:,1),'.','CapSize',15,'MarkerSize',1,'LineWidth',2,'color',[0 0.8 0])
xx = (1:num_group) + 1 * group_width / 3;
errorbar(xx,Freq_mean_bar(:,3),Freq_std_bar(:,2),'.','CapSize',15,'MarkerSize',1,'LineWidth',2,'color',[0 0.8 0])
ylim([0 9]); set(gca, 'ytick', 0:3:9);
set(gca,'XTickLabel','');
delta=0.3;
for i=1:1:num_bar*num_group
    mode_dir = text(x_loc(i), -delta,['\textbf{' text_dir(i,:) '}'],'fontsize',12,'interpreter','latex');
    set(mode_dir, 'HorizontalAlignment','center','VerticalAlignment','middle');
end
for i=1:1:num_group
    text_xlabel= text(i, -4*delta,['\textbf{' num2str(i) '}'],'fontsize',12,'interpreter','latex');
    set(text_xlabel, 'HorizontalAlignment','center','VerticalAlignment','middle');
end
text_mode= text(5, -6*delta,'\textbf{Mode}','fontsize',12,'interpreter','latex');
set(text_mode, 'HorizontalAlignment','center','VerticalAlignment','middle');
h2=get(get(gca,'ylabel'),'extent');
text(h2(1), -4*delta,'\textbf{(a)}','fontsize',12,'interpreter','latex');
ylabel('\textbf{Frequency (Hz)}','fontsize',12,'interpreter','latex');
legend({'\textbf{FIX system}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',10,'interpreter','latex','location','northwest');

subplot(2,1,2);
damp_mean_bar=[FIX_Freq_Damp(1:num_group,2) ELA_Freq_Damp_sort(1:num_group,3) FDZ_Freq_Damp_sort(1:num_group,3)];
damp_std_bar=[ELA_Freq_Damp_sort(1:num_group,4) FDZ_Freq_Damp_sort(1:num_group,4)];
ba=bar(damp_mean_bar); hold on; grid on;
set(ba(1),'FaceColor',[0.7,0.7,0.7]);set(ba(2),'FaceColor','b');set(ba(3),'FaceColor','r');
errorbar(damp_mean_bar(:,2),damp_std_bar(:,1),'.','CapSize',15,'MarkerSize',1,'LineWidth',2,'color',[0 0.8 0])
errorbar(xx,damp_mean_bar(:,3),damp_std_bar(:,2),'.','CapSize',15,'MarkerSize',1,'LineWidth',2,'color',[0 0.8 0])
ylim([0 24]); set(gca, 'ytick', 0:6:24);
set(gca,'XTickLabel','');
delta=0.8;
for i=1:1:num_bar*num_group
    mode_dir = text(x_loc(i), -delta,['\textbf{' text_dir(i,:) '}'],'fontsize',12,'interpreter','latex');
    set(mode_dir, 'HorizontalAlignment','center','VerticalAlignment','middle');
end
for i=1:1:num_group
    text_xlabel= text(i, -4*delta,['\textbf{' num2str(i) '}'],'fontsize',12,'interpreter','latex');
    set(text_xlabel, 'HorizontalAlignment','center','VerticalAlignment','middle');
end
text_mode= text(5, -6*delta,'\textbf{Mode}','fontsize',12,'interpreter','latex');
set(text_mode, 'HorizontalAlignment','center','VerticalAlignment','middle');
h2=get(get(gca,'ylabel'),'extent');
text(h2(1), -4*delta,'\textbf{(b)}','fontsize',12,'interpreter','latex');
ylabel('\textbf{Damping ratio (\%)}','fontsize',12,'interpreter','latex');

for i=1:1:2
    subplot(2,1,i);axesH = gca;
    set(axesH,'TickLabelInterpreter','latex');
    axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
    set(gca,'fontsize',12);
end