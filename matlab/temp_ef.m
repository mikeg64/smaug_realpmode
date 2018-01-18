


figure;
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
   val1=reshape(wd(2,nrange,nrange,nrange),124,124,124);
   val3=reshape(wd(4,nrange,nrange,nrange),124,124,124);
   val2=reshape(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange),124,124,124);


   val4=(val1./val2);
   val3=(val3./val2);

   %val4=sqrt(val1.^2 + val3.^2);

   myval=shiftdim(val4,1);
   
     
val3=reshape(wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange),124,124,124); 
val2=reshape(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange),124,124,124); 
val1=reshape(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange),124,124,124); 
    
val4=sqrt(val1.^2 + val3.^2+val2.^2);
mytval=shiftdim(val4,1);

mv1=shiftdim(val1,1);
mv2=shiftdim(val2,1);
mv3=shiftdim(val3,1);

mx1=shiftdim(x1,1);
mx2=shiftdim(x2,1);
mx3=shiftdim(x3,1);



%energy flux
   val1=reshape(wd(5,nrange,nrange,nrange),124,124,124)+reshape(wd(9,nrange,nrange,nrange),124,124,124); %energy
   val2=reshape(wd(5,nrange,nrange,nrange),124,124,124);  %perturbed energy
   val3=reshape(wd(9,nrange,nrange,nrange),124,124,124);  %background energy
   val4=reshape(wd(1,nrange,nrange,nrange),124,124,124)+reshape(wd(10,nrange,nrange,nrange),124,124,124); %density
   val5=reshape(wd(2,nrange,nrange,nrange),124,124,124);  % vertical (x) component momentum
   myval=shiftdim(val1,1);
   myval2=shiftdim(val2,1);
   myval3=shiftdim(val3,1);
   myval4=shiftdim(val4,1);
   myval5=shiftdim(val5,1);
   myval6=shiftdim(reshape(wd(3,nrange,nrange,nrange),124,124,124),1);
   myval7=shiftdim(reshape(wd(4,nrange,nrange,nrange),124,124,124),1);
   
   myval8=shiftdim(reshape(wd(6,nrange,nrange,nrange),124,124,124),1);
   myval9=shiftdim(reshape(wd(7,nrange,nrange,nrange),124,124,124),1);
   myval10=shiftdim(reshape(wd(8,nrange,nrange,nrange),124,124,124),1);

   myval11=shiftdim(reshape(wd(11,nrange,nrange,nrange),124,124,124),1);
   myval12=shiftdim(reshape(wd(12,nrange,nrange,nrange),124,124,124),1);
   myval13=shiftdim(reshape(wd(13,nrange,nrange,nrange),124,124,124),1);
  
   
   eflux=(gamma-1).*(myval2-((myval5.*myval5+myval6.*myval6+myval7.*myval7)./(2.*myval4))).*(myval5./myval4);
   eflux=eflux-(gamma-1).*((myval8.*myval8+myval9.*myval9+myval10.*myval10)/2+(myval8.*myval11+myval9.*myval12+myval10.*myval13)).*(myval5./myval4);
   eflux=eflux+(myval8.*myval11+myval9.*myval12+myval10.*myval13).*(1./(mu)).*(myval5./myval4);
   eflux=eflux+(myval5.*myval8+myval6.*myval9+myval7.*myval10).*(1./(mu)).*(myval11./myval4);












 	R=8.3e+003;
	mu=1.257E-6;
	mu_gas=0.6;
	gamma=1.66667;
 
     %typedef enum vars {rho, mom1, mom2, mom3, energy, b1, b2, b3,energyb,rhob,b1b,b2b,b3b} CEV;

%compute temperature

TP=reshape(wd(5,nrange,nrange,nrange)+wd(9,nrange,nrange,nrange),124,124,124);
TP=TP-0.5*reshape((wd(2,nrange,nrange,nrange).^2+wd(3,nrange,nrange,nrange).^2+wd(4,nrange,nrange,nrange).^2)./(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange)),124,124,124);
TP=(gamma-1.d0).*TP;
TP=TP-(gamma-2.d0).*0.5*reshape((wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange)).^2+(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange)).^2+(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange)).^2,124,124,124);



%TP=(gamma-1.d0).*TP;
%TP=shiftdim(mu_gas.*TP./R./val2,1);

mu=1.0;
TP1=(1.0/gamma*mu)*((reshape((wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange)).^2+(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange)).^2+(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange)).^2,124,124,124))./TP);
TP1=sqrt(TP1);
TP1=shiftdim(TP1,1);

   maxv=max(max(max(TP1)));
minv=min(min(min(TP1)));
  %isovalue=0.1909;
  isovalue=minv+(maxv-minv)/2;







  [C,hcs1]=contour((reshape(mytval(65,:,:),[124 124]))',[1 2 4 6],'ShowText','on');


clabel(C,hcs1)
set(findobj(gca,'Type','patch','UserData',1),'EdgeColor',[0 1 0])
set(findobj(gca,'Type','patch','UserData',2),'EdgeColor',[0 1 0])
set(findobj(gca,'Type','patch','UserData',4),'EdgeColor',[0 1 0])
set(findobj(gca,'Type','patch','UserData',6),'EdgeColor',[0 1 0])


%for n=1:length(hcs1)
%  set(hcs1,'color',[0 1 0]);
%end
 
 hold on 
  sect=eflux( 65,:,:);
h=surf((reshape(sect,[124 124]))','LineStyle','none');
  view(0,90);
% view(-37.5,15);
  
  
 hcs=contour((reshape(TP1(65,:,:),[124 124]))',[0.5 1.0 1.5 2.0],'ShowText','on');

 


%   hold on;
   set(h,'EdgeColor','none','FaceColor','interp');
%   
  colormap(jet(256));

  
  
  
  
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

maxval=max(max(sect));
minval=min(min(sect));


  
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
  
%maxval=2.0;
%minval=0;


maxval=0.0008;
minval=-0.0005;


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
  
  ylabel(hc,'Vz [m/s]');
  
  set(gca,'Xdir','reverse')
  
  print('-djpeg', imfile);
  
  hold off
  

  
