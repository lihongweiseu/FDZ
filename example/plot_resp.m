%%
%%%%%%%%%%%%%%%%%%%% 1. Displacement %%%%%%%%%%%%%%%%%%%%
ti=char('(a)','(b)','(c)','(d)'); % title label
ylimt=zeros(1,2);temp_ylimt=zeros(1,2);
yloc=zeros(2,2);temp_loc=zeros(2,2);
figure('Name','dis');set(gcf,'Position',[0 0 900 400]);
for i=1:1:2 % x-dir, y-dir
    subplot(2,2,i);
    plot(t,us0(21+i,:)*100,'Color',[0.5,0.5,0.5],'linestyle',':','linewidth',2);hold on;
    plot(t,usl(21+i,:)*100,'b--','linewidth',1.5);hold on;
    plot(t,usf(21+i,:)*100,'r','linewidth',1.5);grid on;
    subplot(2,2,2+i);
    plot(t,ubl(i,:)*100,'b--','linewidth',1.5);hold on;
    plot(t,ubf(i,:)*100,'r','linewidth',1.5);grid on;
end

for j=1:1:2
    subplot(2,2,2*j-1);
    axis tight;ylimt=ylim;
    
    subplot(2,2,2*j);
    axis tight;temp_ylimt=ylim;
    if temp_ylimt(1)<ylimt(1)
        ylimt(1)=temp_ylimt(1);
    end
    if temp_ylimt(2)>ylimt(2)
        ylimt(2)=temp_ylimt(2);
    end
    
    subplot(2,2,2*j-1);
    xlim([0 ceil(t(end))]); ylim(ylimt);
    subplot(2,2,2*j);
    xlim([0 ceil(t(end))]); ylim(ylimt);
end

for i=1:1:2
    for j=1:1:2
        subplot(2,2,2*j-2+i);
        axesH = gca;
        set(axesH,'fontsize',12,'TickLabelInterpreter','latex');
        axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
        xlabel('\textbf{Time (s)}','fontsize',12,'interpreter','latex');
        ylabel('\textbf{Disp. (cm)}','fontsize',12,'interpreter','latex');
        h1=get(get(axesH,'xlabel'),'position');h2=get(get(axesH,'ylabel'),'extent');
        yloc(j,i)=h1(2);temp_loc(j,i)=h2(1);
    end
end
xloc=max(max(temp_loc));
for i=1:1:2
   for j=1:1:2
       subplot(2,2,2*j-2+i);
       text(xloc,yloc(j,i),['\textbf{' ti(2*j-2+i,:) '}'],'fontsize',12,'interpreter','latex');
   end
end
subplot(2,2,1);
legend({'\textbf{FIX system}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',10,'interpreter','latex','location','NorthEast');
max_ub=zeros(3,2);
max_ub(1,1)=max(abs(ubl(1,:)));max_ub(1,2)=max(abs(ubl(2,:)));
max_ub(2,1)=max(abs(ubf(1,:)));max_ub(2,2)=max(abs(ubf(2,:)));
max_ub(3,1)=(max_ub(1,1)-max_ub(2,1))/max_ub(1,1);
max_ub(3,2)=(max_ub(1,2)-max_ub(2,2))/max_ub(1,2);

%%
%%%%%%%%%%%%%%%%%%%% 2. Absolute acceleration %%%%%%%%%%%%%%%%%%%%
yloc=zeros(2,2);temp_loc=zeros(2,2);
figure('Name','ab_acc');set(gcf,'Position',[0 0 900 400]);
for i=1:1:2 % x-dir, y-dir
    subplot(2,2,i);
    plot(t,ab_as0(21+i,:),'Color',[0.5,0.5,0.5],'linestyle',':','linewidth',2);hold on;
    plot(t,ab_asl(21+i,:),'b--','linewidth',1.5);hold on;
    plot(t,ab_asf(21+i,:),'r','linewidth',1.5);grid on;
    subplot(2,2,2+i);
    plot(t,ab_abl(i,:),'b--','linewidth',1.5);hold on;
    plot(t,ab_abf(i,:),'r','linewidth',1.5);grid on;
end

for j=1:1:2
    subplot(2,2,2*j-1);
    axis tight;ylimt=ylim;
    
    subplot(2,2,2*j);
    axis tight;temp_ylimt=ylim;
    if temp_ylimt(1)<ylimt(1)
        ylimt(1)=temp_ylimt(1);
    end
    if temp_ylimt(2)>ylimt(2)
        ylimt(2)=temp_ylimt(2);
    end
    
    subplot(2,2,2*j-1);
    xlim([0 ceil(t(end))]); ylim(ylimt);
    subplot(2,2,2*j);
    xlim([0 ceil(t(end))]); ylim(ylimt);
end

for i=1:1:2
    for j=1:1:2
        subplot(2,2,2*j-2+i);
        axesH = gca;
        set(axesH,'fontsize',12,'TickLabelInterpreter','latex');
        axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
        xlabel('\textbf{Time (s)}','fontsize',12,'interpreter','latex');
        ylabel('\textbf{Ab. Acc. (m~s$^{\bf{-2}}$)}','fontsize',12,'interpreter','latex');
        h1=get(get(axesH,'xlabel'),'position');h2=get(get(axesH,'ylabel'),'extent');
        yloc(j,i)=h1(2);temp_loc(j,i)=h2(1);
    end
end
xloc=max(max(temp_loc));
for i=1:1:2
   for j=1:1:2
       subplot(2,2,2*j-2+i);
       text(xloc,yloc(j,i),['\textbf{' ti(2*j-2+i,:) '}'],'fontsize',12,'interpreter','latex');
   end
end
subplot(2,2,1);
legend({'\textbf{FIX system}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',10,'interpreter','latex','location','NorthEast');
max_ab=zeros(3,2);
max_ab(1,1)=max(abs(ab_abl(1,:)));max_ab(1,2)=max(abs(ab_abl(2,:)));
max_ab(2,1)=max(abs(ab_abf(1,:)));max_ab(2,2)=max(abs(ab_abf(2,:)));
max_ab(3,1)=(max_ab(1,1)-max_ab(2,1))/max_ab(1,1);
max_ab(3,2)=(max_ab(1,2)-max_ab(2,2))/max_ab(1,2);

%%
%%%%%%%%%%%%%%%%%%%% 3. Maxmum drift, absolute acceleration and shear force %%%%%%%%%%%%%%%%%%%%
max_d0=zeros(2,8); max_dl=zeros(2,8); max_df=zeros(2,8);
max_a0=zeros(2,9); max_al=zeros(2,9); max_af=zeros(2,9);
max_F0=zeros(2,9); max_Fl=zeros(2,9); max_Ff=zeros(2,9);
figure('Name','drift_ratio');set(gcf,'Position',[0 0 720 450]);
num_dir=1;
for i=1:1:num_dir
    max_a0(i,1)=max(abs(ag(i,:)));
    max_al(i,1)=max(abs(ab_abl(i,:)));
    max_af(i,1)=max(abs(ab_abf(i,:)));
    
    max_F0(i,1)=max(abs(Fg0(i,:)))/1e4;
    max_Fl(i,1)=max(abs(Fgl(i,:)))/1e4;
    max_Ff(i,1)=max(abs(Fgf(i,:)))/1e4;
    
    for j=1:1:8 % floor number
        max_d0(i,j)=100*max(abs(dus0(j,:,i)));
        max_dl(i,j)=100*max(abs(dusl(j,:,i)));
        max_df(i,j)=100*max(abs(dusf(j,:,i)));
        
        max_a0(i,j+1)=max(abs(ab_as0(3*(j-1)+i,:)));
        max_al(i,j+1)=max(abs(ab_asl(3*(j-1)+i,:)));
        max_af(i,j+1)=max(abs(ab_asf(3*(j-1)+i,:)));
        
        max_F0(i,j+1)=max(abs(Fs0(3*(j-1)+i,:)))/1e4;
        max_Fl(i,j+1)=max(abs(Fsl(3*(j-1)+i,:)))/1e4;
        max_Ff(i,j+1)=max(abs(Fsf(3*(j-1)+i,:)))/1e4;
    end
    subplot(num_dir,3,3*i-2);
    ba=barh([flipud(max_d0(i,:))' flipud(max_dl(i,:))' flipud(max_df(i,:))'],1,'FaceColor','flat'); grid on;
    set(ba(1),'FaceColor',[0.7,0.7,0.7]);set(ba(2),'FaceColor','b');set(ba(3),'FaceColor','r');
    xlim([0 ceil(max(max_d0(i,:))*2)/2]); ylim([0.5 8.5]);
    xlabel('\textbf{Drift~(\%)}','fontsize',12,'interpreter','latex');
    
    subplot(num_dir,3,3*i-1);
    ba=barh([flipud(max_a0(i,:))' flipud(max_al(i,:))' flipud(max_af(i,:))'],1,'FaceColor','flat'); grid on;
    set(ba(1),'FaceColor',[0.7,0.7,0.7]);set(ba(2),'FaceColor','b');set(ba(3),'FaceColor','r');
    xlim([0 10*ceil(max(max_a0(i,:))/10)]); ylim([0.5 9.5]);
    xlabel('\textbf{Peak Ab. Acc.~(m~s$^{\bf{-2}}$)}','fontsize',12,'interpreter','latex');
    set(gca,'YTickLabel',{'\textbf{B}','\textbf{1}','\textbf{2}','\textbf{3}','\textbf{4}','\textbf{5}','\textbf{6}','\textbf{7}','\textbf{8}'},'fontsize',12);
    
    subplot(num_dir,3,3*i);
    ba=barh([flipud(max_F0(i,:))' flipud(max_Fl(i,:))' flipud(max_Ff(i,:))'],1,'FaceColor','flat'); grid on;
    set(ba(1),'FaceColor',[0.7,0.7,0.7]);set(ba(2),'FaceColor','b');set(ba(3),'FaceColor','r');
    xlim([0 10*ceil(max(max_F0(i,:))/10)]);ylim([0.5 9.5]);
    xlabel('\textbf{Peak Force~(10$^{\bf{4}}$kN)}','fontsize',12,'interpreter','latex');
    set(gca,'YTickLabel',{'\textbf{B}','\textbf{1}','\textbf{2}','\textbf{3}','\textbf{4}','\textbf{5}','\textbf{6}','\textbf{7}','\textbf{8}'},'fontsize',12);
end

for i=1:1:3*num_dir
    subplot(num_dir,3,i);
    ylabel('\textbf{Floor}','fontsize',12,'interpreter','latex');
    axesH = gca ; 
    set(axesH,'fontsize',12,'TickLabelInterpreter','latex');
    axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
    ylabel('\textbf{Floor}','fontsize',12,'interpreter','latex');
    h1=get(get(axesH,'xlabel'),'position');h2=get(get(axesH,'ylabel'),'extent');
    text(h2(1),h1(2),['\textbf{' ti(i,:) '}'],'fontsize',12,'interpreter','latex');
end

subplot(num_dir,3,3);
legend({'\textbf{FIX system}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',10,'interpreter','latex','location','NorthEast');
redu_d=zeros(8,3,2);redu_d_average=0;
for i=1:2
    for j=1:1:8
        redu_d(j,1,i)=(max_d0(i,j)-max_dl(i,j))/max_d0(i,j);
        redu_d(j,2,i)=(max_d0(i,j)-max_df(i,j))/max_d0(i,j);
        redu_d(j,3,i)=(max_dl(i,j)-max_df(i,j))/max_dl(i,j);
        redu_d_average=redu_d_average+redu_d(j,3,i);
    end
end
redu_d_average=redu_d_average/16;