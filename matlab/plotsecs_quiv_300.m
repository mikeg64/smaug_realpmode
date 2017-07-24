   


%for i=9:1:9
% 180s drver
%  for i=2:1:1127

% 300s driver
%  for i=1:1:1428
for i=178:1:178
       
       
%         directory='/fastdata/cs1mkg/smaug/spic5b0_3_3d/';
        directory='/fastdata/cs1mkg/smaug/smaug3d_kinktest/';

extension='.out';

%ndirectory='/fastdata/cs1mkg/smaug/spic5b0_3_3d/images_comp/';
ndirectory='/fastdata/cs1mkg/smaug/smaug3d_kinktest/images_comp/';

nextension='.jpg';  
       
% for i=20:1:20     

%for i=200:200
%for i=0:5:30    

id=int2str(500*i);
%filename=[directory,'zerospic1__',id,extension];
filename=[directory,'_',id,extension];
imfile=[ndirectory,'im1_',id,nextension];
timetext=['time=',int2str(i),'s'];
disp([id filename]);



   %fid=fopen(trim(filename));
    fid=fopen((filename));
   %fseek(fid,pictsize(ifile)*(npict(ifile)-1),'bof');
try
   headline=trim(setstr(fread(fid,79,'char')'));
catch
   continue;
end
   it=fread(fid,1,'integer*4'); time=fread(fid,1,'float64');
 
   ndim=fread(fid,1,'integer*4');
   neqpar=fread(fid,1,'integer*4'); 
   nw=fread(fid,1,'integer*4');
   nx=fread(fid,3,'integer*4');
   
   nxs=nx(1)*nx(2)*nx(3);
   varbuf=fread(fid,7,'float64');
   
   gamma=varbuf(1);
   eta=varbuf(2);
   g(1)=varbuf(3);
   g(2)=varbuf(4);
   g(3)=varbuf(5);
   
   
   varnames=trim(setstr(fread(fid,79,'char')'));
   
   for idim=1:ndim
      X(:,idim)=fread(fid,nxs,'float64');
   end
   
   for iw=1:nw
      %fread(fid,4);
      w(:,iw)=fread(fid,nxs,'float64');
      %fread(fid,4);
   end
   
   nx1=nx(1);
   nx2=nx(2);
   nx3=nx(3);
   
   xx=reshape(X(:,1),nx1,nx2,nx3);
   yy=reshape(X(:,2),nx1,nx2,nx3);
   zz=reshape(X(:,3),nx1,nx2,nx3);
   
   
 
  % extract variables from w into variables named after the strings in wnames
wd=zeros(nw,nx1,nx2,nx3);
for iw=1:nw
  
     tmp=reshape(w(:,iw),nx1,nx2,nx3);
     wd(iw,:,:,:)=tmp;
end


%w=tmp(iw);
  

clear tmp; 
   
   
   fclose(fid);




%plot sections through 3d array
   %slice=48;
   x=linspace(0,4,128);
   y=linspace(0,4,128);
   z=linspace(0,6,128);
   
   xmin=3;
   xmax=126;
   ymin=3;
   ymax=126;  
    
   
   nrange=3:126;
   
   ax=x(nrange);
   ay=y(nrange);
   az=z(nrange);

      xsec=1:4:128;
   ysec=1:4:128;
   nx=32;
   ny=32;
   
 nxo=124;
nyo=124;
nzo=124;
nrange1=3:126;
nrange2=3:126;
nrange3=3:126;
nrange=3:126;

% xmax=4;
% ymax=4;
% zmax=6;


%128,256,256 these are input dimensions including ghost cells
% nxo=124;
% nyo=248;
% nzo=248;
% nrange2=3:250;
% nrange3=3:250;
% nrange1=3:126;
% nrange=3:126;
   
   
   
    % Decide where in data space you want to plot cones. This example selects the 
    % full range of x and y in eight steps and the range 3 to 15 in four steps in z 
    % using linspace and meshgrid.
    nxrange = linspace(xmin,xmax,8);
    nyrange = linspace(ymin,ymax,8);
    nzrange = 3:4:126;
    [cx cy cz] = meshgrid(nxrange,nyrange,nzrange);
    
    

    









   %plot sections through 3d array
   %slice=48;
   x=linspace(0,4,128);
   y=linspace(0,4,128);
   z=linspace(0,6,128);
   
   
   
   
   nrange=3:126;
   
   ax=x(nrange);
   ay=y(nrange);
   az=z(nrange);
%    [x1,x2,x3] = meshgrid(nrange,nrange,nrange);
%    
%    val1=reshape(wd(4,nrange,nrange,nrange),124,124,124);
%    val2=reshape(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange),124,124,124);
%    uu=shiftdim(val1./val2,1);
% %   % val3=reshape(wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange),124,124,124);
% %    val3=reshape(wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange),124,124,124);
% %    uu=shiftdim(val3,1);
%    
%    
%    val1=reshape(wd(3,nrange,nrange,nrange),124,124,124);
%    val2=reshape(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange),124,124,124);
%    uv=shiftdim(val1./val2,1);
% %  %  val3=reshape(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange),124,124,124);
% %  val3=reshape(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange),124,124,124);
% %    uv=shiftdim(val3,1);
% 
%    
%    
%    val1=reshape(wd(2,nrange,nrange,nrange),124,124,124);
%    val2=reshape(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange),124,124,124);
%    uw=shiftdim(val1./val2,1);
% %   % val3=reshape(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange),124,124,124);
% %   val3=reshape(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange),124,124,124);
% %    uw=shiftdim(val3,1);
%    
 
%lev=63;
%lev=92;
lev=108;
% %   nr2=lev:1:lev;
% %    nr1=1:8:124;
% %    nr3=1:8:124;
   
     nr2=lev:1:lev;
   nr1=1:8:124;
   nr3=1:8:124;

  %[x1,x3,x2] = meshgrid(nr2,nr1,nr3);
% %    [x1,x3,x2] = meshgrid(nr2,nr1,nr3);
%      [x1,x2,x3] = meshgrid(nr1,nr2,nr3);
     [x1,x2,x3] = meshgrid(nr1,nr2,nr3);
     
     
   snr1=size(nr1);
   snr2=size(nr2);
   snr3=size(nr3);

    x1=shiftdim(x1,1);
    x2=shiftdim(x2,1);
    x3=shiftdim(x3,1);
    
   val3=reshape(wd(2,nr1,nr2,nr3)./(wd(1,nr1,nr2,nr3)+wd(10,nr1,nr2,nr3)),snr1(2),snr2(2),snr3(2));
   uu=shiftdim(val3,1);

   val3=reshape(wd(3,nr1,nr2,nr3)./(wd(1,nr1,nr2,nr3)+wd(10,nr1,nr2,nr3)),snr1(2),snr2(2),snr3(2));
   uv=shiftdim(val3,1);
  
   val3=reshape(wd(4,nr1,nr2,nr3)./(wd(1,nr1,nr2,nr3)+wd(10,nr1,nr2,nr3)),snr1(2),snr2(2),snr3(2));
   uw=shiftdim(val3,1);






      val1=reshape(wd(2,nrange,nrange,nrange),124,124,124);
   val2=reshape(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange),124,124,124);


   myval=shiftdim(val1./val2,1);

   
   % Draw the cones, setting the scale factor to 5 to make the cones larger than 
    % the default size:
    %hcones = coneplot(x1,x2,x3,uu,uv,uw,cx,cy,cz,5);
    % Set the coloring of each cone using FaceColor and EdgeColor:
    %set(hcones,'FaceColor','red','EdgeColor','none')
    
    [sx,sy,sz] = meshgrid(nxrange,nyrange,1);
    %plot3(sx(:),sy(:),sz(:),'*r');
    zmax = max(x3(:)); zmin = min(x3(:));

    %streamline(x1,x2,x3,uu,uv,uw,sx(:),sy(:),sz(:))
     
    
    %streamline(x1,x2,x3,uu,uv,uw)
%streamline(uu,uv,uw)
    % Calculate the magnitude of the vector field (which represents wind speed) to 
    % generate scalar data for the slice command:
   % hold on
   
   
   %P = [2 1 3];
   %x1 = permute(x1, P);
   %x2 = permute(x2, P);
   %x3 = permute(x3, P);
   %myval = permute(myval, P);
   
   
  %h= slice(myval,64, 64, 4);
  %h=figure();
  %hold on;
   
     % streamslice(x1,x2,x3,uu,uv,uw,[],[],(zmax-zmin)/2);
    %streamslice(x1,x2,x3,uu,uv,uw,[],(zmax-zmin)/2,[]);
     %streamslice(x1,x2,x3,uu,uv,uw,0.3*(zmax-zmin),[],[],0.5); 
   % streamslice(x1,x2,x3,uu,uv,uw,(zmax-zmin)/2,[],[],0.5);
 %streamslice(x1,x2,x3,uu,uv,uw,0.33*(zmax-zmin),[],[],0.5);
%   streamslice(x1,x2,x3,uu,uv,uw,0.5*(zmax-zmin),[],[],0.5);
 %streamslice(x1,x2,x3,uu,uv,uw,[],0.66*(zmax-zmin),[],0.5);
 %streamtube(x1,x2,x3,uu,uv,uw,sx,sy,sz);
  %streamslice(x1,x2,x3,uu,uv,uw,0.9*(zmax-zmin),[],[],0.5); 
       %h=slice(uw,80, 64,8);
       
       
       %compute stream line
       ns=9; %number of streamlines
       np=50;
       scx=zeros(ns,np);
       scy=zeros(ns,np);
       scz=zeros(ns,np);
       
       %starting points
       ssx=zeros(ns);
       ssy=zeros(ns);
       ssz=zeros(ns);
       
       %nxrange = linspace(3,126,8);
       %nyrange = linspace(3,126,8);
       %compute starting points
       ii=1;
       for i=32:32:96
           for j=32:32:96
               ssx(ii)=i;
               ssy(ii)=j;
               ssz(ii)=1;
               
               ii=ii+1;
           end
       end
        %dl=3.0/126.0;
        dl=0.1;
% % %         for i=1:ns
% % %                scx(i,1)=ssx(i);
% % %                scy(i,1)=ssy(i);
% % %                scz(i,1)=ssz(i);
% % % 
% % %            for j=2:np
% % %                
% % %                
% % % %                uuinterp=uu(int32(scx(i,j-1)),int32(scy(i,j-1)),int32(scz(i,j-1)));
% % % %                uvinterp=uv(int32(scx(i,j-1)),int32(scy(i,j-1)),int32(scz(i,j-1)));
% % % %                uwinterp=uw(int32(scx(i,j-1)),int32(scy(i,j-1)),int32(scz(i,j-1)));
% % %                %bb=sqrt(uuinterp*uuinterp+uvinterp*uvinterp+uwinterp*uwinterp);
% % %                
% % %                %http://en.wikipedia.org/wiki/Trilinear_interpolation
% % %                uuinterp=triinterp(scx(i,j-1),scy(i,j-1),scz(i,j-1),uu,x1,x2,x3);
% % %                uvinterp=triinterp(scx(i,j-1),scy(i,j-1),scz(i,j-1),uv,x1,x2,x3);
% % %                uwinterp=triinterp(scx(i,j-1),scy(i,j-1),scz(i,j-1),uw,x1,x2,x3);
% % %                bb=sqrt(uuinterp*uuinterp+uvinterp*uvinterp+uwinterp*uwinterp);
% % %                
% % %                scx(i,j)=scx(i,j-1)-dl*uuinterp/bb;
% % %                scy(i,j)=scy(i,j-1)-dl*uvinterp/bb;
% % %                scz(i,j)=scz(i,j-1)-dl*uwinterp/bb;
% % %    
% % %            end  
% % %         end   
       
       
       
%         for i=1:ns
%            plot3(scx(i,:),scy(i,:),scz(i,:)); 
%            hold on;
%         end
     
%      quiver3(x2,x1,x3,1.*uw,1.*uv,1.*uu,'Color',[0 0.498 0], 'LineWidth',1.5)

% %    quiver3(x2,x3,x1,1.*uw,1.*uv,1.*uu,'Color',[0 0.498 0], 'LineWidth',1.5)
% quiver3(x1,x2,x3,1.*uu,1.*uv,1.*uw,'Color',[0 0.498 0], 'LineWidth',1.5)
uu=reshape(uu,[16 16]);
uv=reshape(uv,[16 16]);
uw=reshape(uw,[16 16]);

%comment out these lines to view figure for interactive mode (uncomment for
%batch work)
figure;
%  figure('Visible','off','IntegerHandle','Off');
hold on;




         quiver3(x1,x2,x3,10.*uu,10.*uv,10.*uw,'Color',[0 0.498 0], 'LineWidth',1.5)
       
       hold on;
     %h=slice(myval,65, 65,[5 49 100]); 
    % h=slice(myval,[], [63],[5 49 100]); 
    % h=slice(myval,[], [93],[5 49 100]); 
    h=slice(myval,[], [109],[5 49 100]);
       
       
       hold on;
       set(h,'EdgeColor','none','FaceColor','interp');
       
      %set(h,'XData',ax,'YData',ay,'ZData',az);
      hax=get(h,'Children');
      
  nrange=3:126; 
  
 	R=8.3e+003;
	mu=1.257E-6;
	mu_gas=0.6;
	gamma=1.66667;
 
  
%compute temperature
 val2=reshape(wd(1,nrange1,nrange2,nrange3)+wd(10,nrange1,nrange2,nrange3),nxo,nyo,nzo);


TP=reshape(wd(5,nrange,nrange,nrange)+wd(9,nrange,nrange,nrange),124,124,124);
TP=TP-0.5*reshape((wd(2,nrange,nrange,nrange).^2+wd(3,nrange,nrange,nrange).^2+wd(4,nrange,nrange,nrange).^2)./(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange)),124,124,124);
TP=TP-0.5*reshape((wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange)).^2+(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange)).^2+(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange)).^2,124,124,124);


% sabx=reshape(wd(11,nrange1,nrange2,nrange3),nxo,nyo,nzo);
% saby=reshape(wd(12,nrange1,nrange2,nrange3),nxo,nyo,nzo);
% sabz=reshape(wd(13,nrange1,nrange2,nrange3),nxo,nyo,nzo);
% TP=reshape(wd(9,nrange1,nrange2,nrange3),nxo,nyo,nzo);
% TP=TP-(sabx.^2.0+saby.^2.0+sabz.^2.0)./2.0;
TP=(gamma-1.d0).*TP;

TP=shiftdim(mu_gas.*TP./R./val2,1);




   maxv=max(max(max(TP)));
minv=min(min(min(TP)));
  %isovalue=0.1909;
  isovalue=minv+(maxv-minv)/2;
  
%   itstep=itstep+1;
%   maxva(itstep)=maxv;
%   minva(itstep)=minv;
%   ava(itstep)=minv+(maxv-minv)/2;
  
    
   
   ax=x(nrange);
   ay=y(nrange);
   az=z(nrange);
   [x1,x2,x3] = meshgrid(nrange,nrange,nrange);
  
  
  
  
     isovalue1=2.0e6;
     fv1 = patch(isosurface(x1,x2,x3,TP,isovalue1));
      isonormals(x1,x2,x3,TP,fv1);
     set(fv1,'FaceColor','green','EdgeColor','none','FaceAlpha',0.3);
     
%           isovalue2=1.8e6;
%      fv2 = patch(isosurface(x1,x2,x3,TP,isovalue2));
%       isonormals(x1,x2,x3,TP,fv2);
%      set(fv2,'FaceColor','red','EdgeColor','none','FaceAlpha',0.3); 
%      alpha(0.3);
      daspect([1,1,1])
view(3); 
axis tight;
camlight; 
lighting gouraud ;
       
       hold on;     
      
      
%       set(gca,'CameraPosition',[911.383 -585.056 176.313]);
      %set(gca,'CameraPosition',[491.298 -661.02 631.537]);
       view(-37.5,15);
      set(gca,'Xlim',[0 124],'Ylim',[0 124],'Zlim',[0 124]);

      set(gca,'XTickLabel',{'0';'1.6';'3.2'})
      set(gca,'YTickLabel',{'0';'1.6';'3.2'})
      set(gca,'ZTickLabel',{'0.09';'0.99';'1.94';'2.88';'3.83';'4.77';'5.72'})
      cmap=colormap('Jet');
      %caxis([-4000 5000]);
      caxis([-0.0044 0.0027]);
      
         max1=max(myval);
  max2=max(max1);
  max3=max(max2);
  
  min1=min(myval);
  min2=min(min1);
  min3=min(min2);
  
  maxval=10;
  minval=-10;

%  maxval=2;
%  minval=-2;



mval=50;
%  mval=5;

  
  if min3<minval
      minval=min3;
  end
  
  if max3>maxval
      maxval=max3;
  end
  
  if minval > -mval
        minval=-mval;
  end
  
  if maxval<mval
      maxval=mval;
  end
  
  cmap=colormap(jet(256));
  caxis([minval maxval]);
  %caxis([-0.6 0.6]);
  %caxis([4*10^5 3*10^6]);
  divmap=diverging_map(linspace(0,1,256),[0.23 0.299 0.754],[0.706 0.016 0.15]);
  colormap(divmap);
      
      ylabel(gca,'x (Mm)');
zlabel(gca,'Height (Mm)');
xlabel(gca,'y (Mm)');
   text(-110,0,0,timetext); 
%  title(gca,'Vz Slices, isosurface for 2e6K and Velocity Vectors');
%    text(0,200,0,timetext);
%title(gca,'Driver Period 300s, Mode 0,1');      
title(gca,{'Slices for Vz (m/s), Velocity Vectors and 2e6K isosurface';'Driver Period 300s, Mode 2,3 '});      
      
      %colormap(cmap);
      hc=colorbar();
      %set(hc,'Ylim',[-4000 5000]);
      %set(hc,'Ylim',[-0.0044 0.0027]);
      
  set(hc,'Ylim',[minval maxval]);
      
       
  print('-djpeg', imfile);
  
  hold off
   
%    clf;
%    close(gcf);
%    clear all;
  
end
  
