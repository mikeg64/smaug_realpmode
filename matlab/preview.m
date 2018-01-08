
directory='/fastdata/cs1mkg/smaug/spic_5b2_2_bv200G/';
extension='.out';
ndirectory=[directory,'impreview/'];
%ndirectory='/fastdata/cs1mkg/smaug/spic_5b2_2_bv200G/impreview/';
nextension='.jpg';

figure;
pic=1;
picstart=pic;

sb1=2; %slice for base 1
svx1=2; % slice for vertical x
svy1=108; % slice for vertical y

for i=picstart:1:pic
    

id=int2str(1000*i);
filename=[directory,'zerospic1__',id,extension];
timetext=['time=',int2str(i),'s'];
imfile=[ndirectory,'im1_',id,nextension];
figfile=[ndirectory,'fig1_',id,'.fig'];

disp([id filename]);
   fid=fopen(trim(filename));
   %fseek(fid,pictsize(ifile)*(npict(ifile)-1),'bof');
   headline=trim(setstr(fread(fid,79,'char')'));
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
   
   
   
   
   nrange=3:126;
   
   ax=x(nrange);
   ay=y(nrange);
   az=z(nrange);
   [x1,x2,x3] = meshgrid(ax,ay,az);
%     val1=reshape(wd(2,nrange,nrange,nrange),124,124,124);%z component
%    val1=reshape(wd(3,nrange,nrange,nrange),124,124,124);
%   val3=reshape(wd(4,nrange,nrange,nrange),124,124,124);
%    val2=reshape(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange),124,124,124);


%   val1=(val1./val2);
%   val3=(val3./val2);

 %  val4=sqrt(val1.^2 + val3.^2);

   
%    myval=shiftdim(val1,1);
%   myval=shiftdim(val4,1);
%    myval=shiftdim(val1,1);
  
%   myval=shiftdim(reshape(wd(2,nrange,nrange,nrange)./(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange)),124,124,124),1);


%    val1=reshape(wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange),124,124,124); 
%    val2=reshape(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange),124,124,124); 
%    val3=reshape(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange),124,124,124);


%     val1=reshape(wd(11,nrange,nrange,nrange),124,124,124); 
%     val2=reshape(wd(12,nrange,nrange,nrange),124,124,124); 
%     val3=reshape(wd(13,nrange,nrange,nrange),124,124,124);

%val4=sqrt(val1.^2 + val2.^2 + val3.^2);

   
   % myval=shiftdim(val4,1);

  %mc=reshape(val4(120,:,:),124,124);

	R=8.3e+003;
	mu=1.257E-6;
	mu_gas=0.6;
	gamma=1.66667;

 % sabx=reshape(wd(11,nrange,nrange,nrange),124,124,124);
%saby=reshape(wd(12,nrange,nrange,nrange),124,124,124);
%sabz=reshape(wd(13,nrange,nrange,nrange),124,124,124);
%TP=reshape(wd(9,nrange,nrange,nrange),124,124,124);
%TP=TP-(sabx.^2.0+saby.^2.0+sabz.^2.0)./2.0;
%TP=(gamma-1.d0).*TP;

%h=contourslice(x1,x2,x3,myval,1:9, [],0);
%h=contour3(mc,30);

   %mval is T
  
   %mytval=shiftdim(mu_gas.*TP./R./val2,1);  
    
    
%typedef enum vars {rho, mom1, mom2, mom3, energy, b1, b2, b3,energyb,rhob,b1b,b2b,b3b} CEV;


   %P = [2 1 3];
   %x1 = permute(x1, P);
   %x2 = permute(x2, P);
   %x3 = permute(x3, P);
   %myval = permute(myval, P);
   
   
   subplot(2,2,1)
   hold on

   myval=shiftdim(reshape(wd(2,nrange,nrange,nrange)./(wd(1,nrange,nrange,nrange)+wd(10,nrange,nrange,nrange)),124,124,124),1);
   h=slice(myval,svx1, svy1,[sb1  85]);  %used for 2,2 mode
 
%sect=myval( :,:,5);
%h=surf(sect','LineStyle','none');

 view(-37.5,15);

    set(h,'EdgeColor','none','FaceColor','interp');
  

      max1=max(myval);
      max2=max(max1);
      max3=max(max2);

      min1=min(myval);
      min2=min(min1);
      min3=min(min2);

      
      maxval=max3;
      minval=min3;
      
  cmap=colormap(jet(256));
  caxis([minval maxval]);
  divmap=diverging_map(linspace(0,1,256),[0.23 0.299 0.754],[0.706 0.016 0.15]);
  colormap(divmap);  
  hc=colorbar(); 
    set(hc,'Ylim',[minval maxval]); 
   text(-100,0,175,timetext);
title('velocity');

    hold off


  
   subplot(2,2,2)
 hold on
   myval=shiftdim(reshape(wd(1,nrange,nrange,nrange),124,124,124),1);
   h=slice(myval,svx1, svy1,[sb1  85]);  %used for 2,2 mode
 
%sect=myval( :,:,5);
%h=surf(sect','LineStyle','none');

 view(-37.5,15);

    set(h,'EdgeColor','none','FaceColor','interp');
  

      max1=max(myval);
      max2=max(max1);
      max3=max(max2);

      min1=min(myval);
      min2=min(min1);
      min3=min(min2);

      
      maxval=max3;
      minval=min3;
      
  cmap=colormap(jet(256));
  caxis([minval maxval]);
  divmap=diverging_map(linspace(0,1,256),[0.23 0.299 0.754],[0.706 0.016 0.15]);
  colormap(divmap);  
  hc=colorbar(); 
    set(hc,'Ylim',[minval maxval]); 
   text(-100,0,175,timetext);
 title('density' );

    hold off


   subplot(2,2,3)
 hold on
   myval=shiftdim(reshape(wd(5,nrange,nrange,nrange),124,124,124),1);
   h=slice(myval,svx1, svy1,[sb1  85]);  %used for 2,2 mode
 
%sect=myval( :,:,5);
%h=surf(sect','LineStyle','none');

 view(-37.5,15);

    set(h,'EdgeColor','none','FaceColor','interp');
  

      max1=max(myval);
      max2=max(max1);
      max3=max(max2);

      min1=min(myval);
      min2=min(min1);
      min3=min(min2);

      
      maxval=max3;
      minval=min3;
      
  cmap=colormap(jet(256));
  caxis([minval maxval]);
  divmap=diverging_map(linspace(0,1,256),[0.23 0.299 0.754],[0.706 0.016 0.15]);
  colormap(divmap);  
  hc=colorbar(); 
    set(hc,'Ylim',[minval maxval]); 
   text(-100,0,175,timetext);
 title('E' );

    hold off


   subplot(2,2,4)
 hold on

   myval=shiftdim(reshape(wd(6,nrange,nrange,nrange),124,124,124),1);
   h=slice(myval,svx1, svy1,[sb1  85]);  %used for 2,2 mode
 
%sect=myval( :,:,5);
%h=surf(sect','LineStyle','none');

 view(-37.5,15);

    set(h,'EdgeColor','none','FaceColor','interp');
  

      max1=max(myval);
      max2=max(max1);
      max3=max(max2);

      min1=min(myval);
      min2=min(min1);
      min3=min(min2);

      
      maxval=max3;
      minval=min3;
      
  cmap=colormap(jet(256));
  caxis([minval maxval]);
  divmap=diverging_map(linspace(0,1,256),[0.23 0.299 0.754],[0.706 0.016 0.15]);
  colormap(divmap);  
  hc=colorbar(); 
    set(hc,'Ylim',[minval maxval]); 
   text(-100,0,175,timetext);
 title('B' );

    hold off




  print('-djpeg', imfile);
  
  % savefig( figfile);
  % load(figfile);
 
  
end 
  
