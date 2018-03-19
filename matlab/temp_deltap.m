
%ndirectory='/fastdata/cs1mkg/smaug/spic_5b2_2_bv150G/images_3d_vsecs_magc/';
ndirectory=[directory,'im_2d_deltap/'];
imfile=[ndirectory,'im1t_',id,nextension];

figure('Visible','off','IntegerHandle','Off');

%figure;
hold on;




%plot sections through 3d array
   %slice=48;
   x=linspace(0,127,128);
   y=linspace(0,127,128);
   z=linspace(0,127,128);
   
   
   
   
   nrange=3:126;
   
   ax=x(nrange);
   ay=y(nrange);
   az=z(nrange);
   [x1,x2,x3] = meshgrid(ax,ay,az);
   %typedef enum vars {rho, mom1, mom2, mom3, energy, b1, b2, b3,energyb,rhob,b1b,b2b,b3b} CEV;

%compute background pressure
 val2=reshape(wd(1,nrange1,nrange2,nrange3)+wd(10,nrange1,nrange2,nrange3),nxo,nyo,nzo);

TP=reshape(wd(5,nrange,nrange,nrange),124,124,124);
TP=TP-0.5*reshape((wd(2,nrange,nrange,nrange).^2+wd(3,nrange,nrange,nrange).^2+wd(4,nrange,nrange,nrange).^2)./(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange)),124,124,124);
TP=(gamma-1.d0).*TP;
val4=TP;




TP= -0.5*reshape((wd(6,nrange,nrange,nrange)).^2+(wd(7,nrange,nrange,nrange)).^2+(wd(8,nrange,nrange,nrange)).^2,124,124,124);
TP=TP-reshape((wd(6,nrange,nrange,nrange).*wd(11,nrange,nrange,nrange))+(wd(7,nrange,nrange,nrange).*wd(12,nrange,nrange,nrange))+(wd(8,nrange,nrange,nrange).*wd(13,nrange,nrange,nrange)),124,124,124);
TP=(gamma-2.d0).*TP;
val4=val4+TP;



%TP=TP-0.5*reshape((wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange)).^2+(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange)).^2+(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange)).^2,124,124,124);






   %val4=sqrt(val1.^2 + val3.^2);





   myval=shiftdim(val4,1);
   
     
    val3=reshape(wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange),124,124,124); 
    val2=reshape(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange),124,124,124); 
    val1=reshape(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange),124,124,124);

%    val3=reshape(wd(6,nrange,nrange,nrange),124,124,124); 
%    val2=reshape(wd(7,nrange,nrange,nrange),124,124,124); 
%    val1=reshape(wd(8,nrange,nrange,nrange),124,124,124);


    
    
val4=sqrt(val1.^2 + val3.^2+val2.^2);
mytval=shiftdim(val4,1);
%     val3=reshape(wd(11,nrange,nrange,nrange),124,124,124); 
%     val2=reshape(wd(12,nrange,nrange,nrange),124,124,124); 
%     val1=reshape(wd(13,nrange,nrange,nrange),124,124,124);

mv1=shiftdim(val1,1);
mv2=shiftdim(val2,1);
mv3=shiftdim(val3,1);

mx1=shiftdim(x1,1);
mx2=shiftdim(x2,1);
mx3=shiftdim(x3,1);





 	R=8.3e+003;
	mu=1.257E-6;
	mu_gas=0.6;
	gamma=1.66667;
 
     %typedef enum vars {rho, mom1, mom2, mom3, energy, b1, b2, b3,energyb,rhob,b1b,b2b,b3b} CEV;

%compute temperature
% val2=reshape(wd(1,nrange1,nrange2,nrange3)+wd(10,nrange1,nrange2,nrange3),nxo,nyo,nzo);

%TP=reshape(wd(5,nrange,nrange,nrange)+wd(9,nrange,nrange,nrange),124,124,124);
%TP=TP-0.5*reshape((wd(2,nrange,nrange,nrange).^2+wd(3,nrange,nrange,nrange).^2+wd(4,nrange,nrange,nrange).^2)./(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange)),124,124,124);
%TP=TP-0.5*reshape((wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange)).^2+(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange)).^2+(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange)).^2,124,124,124);
%TP=(gamma-1.d0).*TP;
%TP=shiftdim(mu_gas.*TP./R./val2,1);




%compute temperature
% val2=reshape(wd(1,nrange1,nrange2,nrange3)+wd(10,nrange1,nrange2,nrange3),nxo,nyo,nzo);





TP=reshape(wd(5,nrange,nrange,nrange)+wd(9,nrange,nrange,nrange),124,124,124);
TP=TP-0.5*reshape((wd(2,nrange,nrange,nrange).^2+wd(3,nrange,nrange,nrange).^2+wd(4,nrange,nrange,nrange).^2)./(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange)),124,124,124);
TP=(gamma-1.d0).*TP;
TP=TP-(gamma-2.d0).*0.5*reshape((wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange)).^2+(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange)).^2+(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange)).^2,124,124,124);



%TP=(gamma-1.d0).*TP;
%TP=shiftdim(mu_gas.*TP./R./val2,1);

%mu=1.0;
TP1=(1.0/gamma)*((reshape((wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange)).^2+(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange)).^2+(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange)).^2,124,124,124))./TP);
TP1=sqrt(mu)*1.0e4*sqrt(TP1);
TP1=shiftdim(TP1,1);

   maxv=max(max(max(TP1)));
minv=min(min(min(TP1)));
  %isovalue=0.1909;
  isovalue=minv+(maxv-minv)/2;












   %P = [2 1 3];
   %x1 = permute(x1, P);
   %x2 = permute(x2, P);
   %x3 = permute(x3, P);
   %myval = permute(myval, P);
   
 %  myval=TP1;
  %h= slice(myval,64, 64, 4);
  %figure('Visible','off','IntegerHandle','Off');
  %hold on;
  %h=slice(myval,80, 64,8);
  %h=slice(myval,96, 96,[5 49 100]);  %used for 0,1 mode
  %h=slice(myval,96, 96,[5 49 100]);  %used for 1,1 mode
  %h=slice(myval,108, 108,[5 49 85]);  %used for 2,2 mode
  %h=slice(myval,108, 108,[5 49]);  %used for 2,2 mode
  %h=slice(myval,108, 96,[5 49 100]);  %used for 0,1 mode
  %h=slice(myval,65, 65,[5 49 100]);  %used for 0,0 mode
  % h=slice(myval,108, 108,[5  ]);  %used for 0,0 mode
  %   h=slice(myval,[], [],[5  ]);  %used for 0,0 mode
  %h=slice(myval,65, 65,[5 49 100]);
 % h=slice(myval,96, 96,[5 49 ]);  %used for 0,1 mode

  %h=slice(myval,105, 96,8);
  %[C,hcs1]=contour((reshape(mytval(65,:,:),[124 124]))',[1 2 4 6],'ShowText','on');
  %[C,hcs1]=contour((reshape(mytval(65,:,:),[124 124]))',[1 5 10 20],'ShowText','on');
 [C,hcs1]=contour((reshape(mytval(65,:,:),[124 124]))',[1 4 6 8],'ShowText','on');
clabel(C,hcs1)
set(findobj(gca,'Type','patch','UserData',1),'EdgeColor',[0 1 0])
set(findobj(gca,'Type','patch','UserData',2),'EdgeColor',[0 1 0])
set(findobj(gca,'Type','patch','UserData',4),'EdgeColor',[0 1 0])
set(findobj(gca,'Type','patch','UserData',6),'EdgeColor',[0 1 0])


%for n=1:length(hcs1)
%  set(hcs1,'color',[0 1 0]);
%end
 
 hold on 
  sect=myval( 65,:,:);
h=surf((reshape(sect,[124 124]))','LineStyle','none');
  view(0,90);
% view(-37.5,15);
  
  
 hcs=contour((reshape(TP1(65,:,:),[124 124]))',[0.5 1.0 1.5 2.0],'ShowText','on');

 


%   hold on;
   set(h,'EdgeColor','none','FaceColor','interp');
%   
  colormap(jet(256));

%mytval=TP1;
% if i>30
%    % hcs=contourslice(mytval,[],[],[35 49 80]);
%  % hcs=contourslice(mytval,[],[],[49 80]);
%  hcs=contourslice(mytval,[],[],[49 80 ]);
%   contvals = get(hcs,'cdata'); %data values for the contours
% colors=unique(cat(1,contvals{:}));
% colors=colors(~isnan(colors));
% 
% 
% % Loop through all the patches returned by CONTOURSLICE, 
% % and designate a linestyle for each
% % Define the line style (note that this can be changed 
% % since the code is written generally)
% %linespec = {'-','--',':','-.'};
% linespec = {'-.','-',':','--'};
% %linecspec = {'-','--',':','-.'};
% linestyles = repmat(linespec,1,ceil(length(colors)/length(linespec)));
% linestyles = {linestyles{1:length(colors)}};
% 
% 
% for n=1:length(hcs)
%     % Find the unique color number associated with the handle
%     color = find(max(get(hcs(n),'cdata'))==colors);
%     % Convert the color to the associated linestyle
%     linestyle = linestyles{color};
%     set(hcs(n),'linestyle',linestyle);
%     set(hcs(n),'CDataMapping','direct');
% %     set(hcs(n),'color',[0 0 0]);
% end
% 
% end

  
  
%    [sx sy sz] = meshgrid(20:20:120,20:20:120,20);
%  % [sx sy sz] = meshgrid(50:5:70,50:5:70,10);
%   
%   msx=shiftdim(sx,1);
% msy=shiftdim(sy,1);
% msz=shiftdim(sz,1);
% %sx1=shiftdim(sx,1);
% %sy1=shiftdim(sy,1);
% %sz1=shiftdim(sz,1);
% 
%  %h=streamline(stream3(mx1,mx2,mx3,mv1,mv2,mv3,msx,msy,msz));
%  h=streamline(stream3(x1,x2,x3,mv1,mv2,mv3,sx,sy,sz));
%  %h=streamline(stream3(x1,x2,x3,val1,val2,val3,sx,sy,sz));
% 
% 
% 
% 
% 
% 
% 
%      isovalue1=1.0;
%      fv1 = patch(isosurface(x1,x2,x3,TP1,isovalue1));
%       isonormals(x1,x2,x3,TP1,fv1);
%      set(fv1,'FaceColor','green','EdgeColor','none','FaceAlpha',0.15);
%      
% %           isovalue2=1.8e6;
% %      fv2 = patch(isosurface(x1,x2,x3,TP,isovalue2));
% %       isonormals(x1,x2,x3,TP,fv2);
% %      set(fv2,'FaceColor','red','EdgeColor','none','FaceAlpha',0.3); 
% %      alpha(0.3);
%       daspect([1,1,1])
% %view(3); 
% %axis tight;
% %camlight; 
% %lighting gouraud ;
% 
% 

  
  
  
  
  %grid off;
  %set(h,'XData',ax,'YData',ay,'ZData',az);
  hax=get(h,'Children');
%   set(gca,'CameraPosition',[-606.298 -914.02 280.537]);
  set(gca,'Xlim',[0 124],'Ylim',[0 124],'Zlim',[0 124]);
  
  %set(gca,'ZTickLabel',{'0';'1.6';'3.2'})
  %set(gca,'YTickLabel',{'0';'1.6';'3.2'})



  set(gca,'ZTickLabel',{'0';'1.6';'3.2'})
  %set(gca,'XTickLabel',{'0';'1.6';'3.2'})
  set(gca,'XTickLabel',{'0';'0.63';'1.26';'1.89';'2.52';'3.15';'3.78'})
  set(gca,'YTickLabel',{'0.09';'0.99';'1.94';'2.88';'3.83';'4.77';'5.72'})
  %set(gca,'ZTickLabel',{'0.09';'0.35';'0.61';'0.87';'1.13';'1.39';'1.65'})
  %cmap=colormap('Jet');
  
  
  
  
   max1=max(myval);
  max2=max(max1);
  max3=max(max2);
  
  min1=min(myval);
  min2=min(min1);
  min3=min(min2);
  
 % maxval=50;
 % minval=-50;




  
  if min3<minval
      minval=min3;
  end
  
  if max3>maxval
      maxval=max3;
  end
  
  if minval > -100
       ;% minval=-100;
  end
  
  if maxval<100
     ;% maxval=100;
  end
  
maxval=0.0014;
minval=-0.001;

  cmap=colormap(jet(256));
  caxis([minval maxval]);
  %caxis([-0.6 0.6]);
  %caxis([4*10^5 3*10^6]);
  divmap=diverging_map(linspace(0,1,256),[0.23 0.299 0.754],[0.706 0.016 0.15]);
  colormap(divmap);
  %colormap(cmap);
  
hold on;
  

 
  
  hc=colorbar();
  %set(hc,'Ylim',[minval maxval]);
  %set(hc,'Ylim',[-0.6 0.6]);
  %set(hc,'Ylim',[4*10^5 3*10^6]);
  text(-100,0,165,timetext);
  %title('Vertical Velocity for Solar Atmosphere with a Sinusoidal (0,0) Mode Driver of Period673.4s, Applied at a Height of 100km');
  %title('Vertical Velocity for Solar Atmosphere with a Sinusoidal (3,3) Mode Driver of Period 100.0s, Applied at a Height of 100km');
  zlabel('x-distance (Mm)');
  xlabel('y-distance (Mm)');
  ylabel('Height (Mm)');
  
  ylabel(hc,'Perturbed Pressure [Pa]');
  
  set(gca,'Xdir','reverse')
  
  print('-djpeg', imfile);
  
  hold off
  

  
