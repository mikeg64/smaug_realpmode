
%distance time plots created using 
%pvvt180_01.m
%pvvt300_01.m
%pvvt180_00.m
%pvvt300_00.m
%these generated from 


%ndirectory='/fastdata/cs1mkg/smaug/spic6b0_3d_rep/images';
%ndirectory='/fastdata/cs1mkg/smaug/spic5b0_3d/images';

bdir='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/';
rdirectory='spic_5b2_2_bv100G';
directory=[bdir,rdirectory,'/matlabdat/'];




%imfile=[ndirectory,'dt_',id,nextension];

%title(gca,'Distance Time Plot for the 0,0 Mode (x dir) 300.0s Driver (Horizontal Section in Chromosphere at 1Mm )'); 
%title(gca,'Distance Time Plot for the 0,0 Mode (x dir) 300.0s Driver (Horizontal Section in Transition Layer at 2.06Mm )'); 
%title(gca,'Distance Time Plot for the 0,0 Mode (x dir) 300.0s Driver (Horizontal Section in Corona at 4.3Mm )');
ptitle1='Distance Time Plot for the ';
ptitle2=' Mode 300.0s (y-Vertical Section at 2Mm)';



yticks={'0.09';'0.99';'1.94';'2.88';'3.83';'4.77';'5.72';'6.67'};
%old not used? yticks={'1.78';'2.22';'2.68';'3.12';'3.57';'4.02';'4.47';'4.91';'5.36';'5.81'};
%%yticks={'0';'0.6667';'1.333';'2.0';'2.667';'3.333';'4.0'};






%0,0 mode
figure;
matfile=[directory,'spic_5b2_2_bv100G_ydir_vvt_bv100G.mat'];
load(matfile);

%load('/data/cs1mkg/smaug_realpmode/matlab/timedistplot/spic_4b2_2_bv20G_xdir_vvt.mat');
%load('/fastdata/cs1mkg/smaug/matlabdat/spic6b0_3d_xdir_vverustime.mat');

%dtplot=evelchrom_vh;  %  horizontal section in chrom at  20
%dtplot=eveltran_vh;   %  horizontal section in transition layer at 42
%dtplot=evelcor_vh;    %  horizontal section in corona at 90

dtplot=evel2Mm_vh;  %vertical section at 2Mm  62
%dtplot=evel1Mm_vh;  %vertical section at 1Mm  31
%dtplot=evelp5Mm_vh;  %vertical section at 0.5Mm 15

dtp00=dtplot;
smode=' 100G (2,2) ';
subplot(1,2,1);
surf(real(dtp00'),'LineStyle','none');
zlimv=8*[-1 1];


xlimv=[0 400]; %time limit
ylimv=[0 124];

hold on
hc=colorbar();
caxis(zlimv);
%set(hc,'Zlim',zlimv);
set(gca,'Xlim',xlimv,'Ylim',ylimv);

 view(0,90);
%set(gca,'CameraPosition',[400 45 17320.508]);


set(gca,'YTickLabel',yticks)


%colorbar;
ylabel(gca,'Time (seconds)');
%xlabel(gca,'Height (Mm)');
xlabel(gca,'Distance (Mm)');
xticks={'0';'0.6667';'1.333';'2.0';'2.667';'3.333';'4.0'};


ptitle=[smode,ptitle2];
title(gca,ptitle);






yticks={'0';'0.6667';'1.333';'2.0';'2.667';'3.333';'4.0'};

%dtplot=evelchrom_vh;  %  horizontal section in chrom at  20
dtplot=eveltran_vh;   %  horizontal section in transition layer at 42
%dtplot=evelcor_vh;    %  horizontal section in corona at 90

%dtplot=evel2Mm_vh;  %vertical section at 2Mm  62
%dtplot=evel1Mm_vh;  %vertical section at 1Mm  31
%dtplot=evelp5Mm_vh;  %vertical section at 0.5Mm 15

dtp00=dtplot;
smode=' 100G (2,2) ';
subplot(1,2,2);
surf(real(dtp00)','LineStyle','none');
zlimv=8*[-1 1];


ylimv=[0 124]; %time limit
xlimv=[0 600];

hold on
hc=colorbar();
caxis(zlimv);
%set(hc,'Zlim',zlimv);
set(gca,'Xlim',xlimv,'Ylim',ylimv);

 view(0,90);
%set(gca,'CameraPosition',[400 45 17320.508]);


set(gca,'YTickLabel',yticks)


%colorbar;
xlabel(gca,'Time (seconds)');
%xlabel(gca,'Height (Mm)');
ylabel(gca,'Distance (Mm)');


ptitle=[smode,ptitle2];
title(gca,ptitle);





%hold off



clear('evelchrom_vh', 'eveltran_vh', 'evelcor_vh','evel2Mm_vh', 'evel1Mm_vh', 'evelp5Mm_vh' );
