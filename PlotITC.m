

clear all
close all
clc

pathout='E:\WMprecision\ERSP\noERP\';
% pathout='D:\WMprecision_load4\ERSP\';
% eeglab;
% trigger={'111','112','121','122','213','223'};
time=[-1.8         2.5];

% sub=[2:5, 7:10, 12:17 20:36]; 
sub=[1:6 8:14,16:36]; 
for i =1:length(sub)
    load([pathout,'Data_sub',num2str(sub(i)),'_ITC.mat']);
    NITC(i,:,:,:) = abs(NeturalITC);
    VITC(i,:,:,:) = abs(ValidITC);
%     NITC(i,:,:,:) =  angle(NeturalITC);
%     VITC(i,:,:,:) =  angle(ValidITC);
end

subDif = squeeze(VITC(:,10,7,475)) - squeeze(NITC(:,10,7,475));
circ_plot(subDif,'pretty','bo',true,'linewidth',2,'color','r'),
% Dif = squeeze(mean(subDif(:,10,:,:),1));
v_n=SubValidRT-SubNeturalRT;
[ca pa] = circ_corrcl(subDif([2:24 26:33]),v_n([2:24 26:33]));
AVGNITC=mean(NITC,1);
AVGVITC=mean(VITC,1);

    AVGNITC =squeeze(AVGNITC);
    AVGVITC =squeeze(AVGVITC);
%     
    for a=1:57
        for b =1:900
    [htf(a,b),ptf(a,b)]=ttest(squeeze(NITC(:,10,a,b)),squeeze(VITC(:,10,a,b)));
        end
    end
    ptf(ptf>0.05)=1;

    for a=[1:57 59:61]
    [htopo(a),ptopo(a)]=ttest(squeeze(mean(mean(NITC(:,a,3:11,415:510),4),3)),squeeze(mean(mean(VITC(:,a,3:11,415:510),4),3)));
    end
    ptopo(ptopo>0.05)=1;    
    
    figure;
       topoplot( squeeze(mean(mean(AVGVITC([1:57 59:61],15:29,368:487),3),2))-squeeze(mean(mean(AVGNITC([1:57 59:61],15:29,368:487),3),2)), 'Channel_64.sfp', 'electrodes','on','maplimits',[0,1],  'plotrad',0.7,'headrad',0.69,'noplot','off' );
       colormap(othercolor('BuDRd_18'));
       colorbar;
       
    figure;
       topoplot(ptopo([1:57,59:61])', 'Channel_64.sfp', 'electrodes','on','maplimits',[0,0.001],  'plotrad',0.7,'headrad',0.69,'noplot','off' );
       colormap(othercolor('BuDRd_18'));
       colorbar;

       
       figure;
       topoplot(squeeze(mean(mean(AVGVITC([1:57 59:61],3:11,415:510),3),2)), 'Channel_64.sfp', 'electrodes','on', 'maplimits',[0.15,0.3], 'plotrad',0.7,'headrad',0.69,'noplot','off' );
       colormap(othercolor('BuDRd_18'));
       colorbar;
       
         
    figure;
       topoplot(squeeze(mean(mean(AVGNITC([1:57 59:61],3:11,415:510),3),2)), 'Channel_64.sfp', 'electrodes','on', 'maplimits',[0.15,0.3], 'plotrad',0.7,'headrad',0.69,'noplot','off' );
       colormap(othercolor('BuDRd_18'));
       colorbar;       
       
figure;
hh=surf(times,frequencies, squeeze(AVGNITC(10,:,:)));
set(hh,'edgecolor','none');
       colormap(othercolor('BuDRd_18'));
colorbar;
axis([-1500,2200, 2, 30]);
caxis([0,0.5]);
% title(['Valid - Neutral channel',num2str(c)]);  

subValidITC = squeeze(mean(mean(VITC(:,10,3:11,402:548),3),4));
subNeutralITC = squeeze(mean(mean(NITC(:,10,3:11,402:548),3),4));
       
figure;
hh=surf(times,frequencies, squeeze(AVGNITC(56,:,:)));
set(hh,'edgecolor','none');
colormap(othercolor('BuDRd_18'));
colorbar;
axis([0,1500, 2, 30]);
caxis([-90,90]);
% title(['Valid - Neutral channel',num2str(c)]);  


figure;
hh=surf(times*1000,frequencies, abs(squeeze(AVGVITC(10,:,:))-squeeze(AVGNITC(10,:,:))));
set(hh,'edgecolor','none');
       colormap(othercolor('BuDRd_18'));
colorbar;
axis([-500,1500, 5, 30]);
caxis([0,90]);
% title(['Valid - Neutral channel',num2str(c)]);  


figure;
hh=surf(times*1000,frequencies,fdr(ptf));
set(hh,'edgecolor','none');
       colormap(othercolor('BuDRd_18'));
colorbar;
axis([-500,1500, 2, 30]);
caxis([0,0.1]);
% title(['Valid - Neutral channel',num2str(c)]);




figure;
hh=surf(times*1000,frequencies, Dif);
set(hh,'edgecolor','none');
       colormap(othercolor('BuDRd_18'));
colorbar;
axis([-1500,2200, 2, 30]);
caxis([0,0.5]);
