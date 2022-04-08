

directory='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv100G/';
extension='.out';
%bdir='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/';
%rdirectory='spic_5b2_2_bv100G';

bdir='/Users/mikegriffiths/proj';
rdirectory='/smaug-realpmode-data';

%directory=[bdir,rdirectory,'/matlabdat/'];
directory=[bdir,rdirectory,'/'];



%matfile=[directory,'vvzverustime.mat'];
matfile=[directory,'pvvt.mat'];

%load(matfile);
evelv0G=evel2Mm_vh_0G;
evelv=(evel2Mm_vh(1:617,:)-evelv0G)./(evel2Mm_vh(1:617,:)+evelv0G);
ss1=evelv;
sz=size(evelv);
nt=sz(1);

%ss1=reshape(evelv(62,:,:),[124,nt]);
s1=surf(ss1(1:600,1:45)');  %low and mid chromosphere
s1.EdgeColor = 'none';
s1.FaceAlpha=0.7;


hold on

ss2=sqrt(evel2Mm_b)'; %plotting in units of kG
test=(((ss2-(min(min(ss2(:,1:700)))))*1000000));

 [M,c]=contour(test(1:45,1:600),4);
 c.LineWidth = 2;


%ss3=1e4*(evel2Mm_bet)'; %plotting 1/beta
 %[M,c]=contour(ss3(1:45,1:600),1,'linecolor','r');
 %c.LineWidth = 2; 
 
 
zlimv=3*[-1 1];


xlimv=[0 600]; %time limit
ylimv=[0 45];

hc=colorbar();
caxis(zlimv);

yticks={'0';'0.6667';'1.333';'2.0';'2.667';'3.333';'4.0'};
yticks=cell(11,1);
for i=1:11
   yticks{i,1} = sprintf('%.2f',0.0625+5*(i-1)*0.03125);
end
%yticks={sprintf('%.6f',a), sprintf('%.6f',a), sprintf('%.6f',a), sprintf('%.6f',a)}

%set(hc,'Zlim',zlimv);
set(gca,'Xlim',xlimv,'Ylim',ylimv);

set(gca,'YTickLabel',yticks)


%colorbar;
xlabel(gca,'Time (seconds)');
ylabel(gca,'Height (Mm)');
%xlabel(gca,'Distance (Mm)');



view(2);