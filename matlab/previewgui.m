function varargout = previewgui(varargin)
% PREVIEWGUI MATLAB code for previewgui.fig
%      PREVIEWGUI, by itself, creates a new PREVIEWGUI or raises the existing
%      singleton*.
%
%      H = PREVIEWGUI returns the handle to a new PREVIEWGUI or the handle to
%      the existing singleton*.
%
%      PREVIEWGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREVIEWGUI.M with the given input arguments.
%
%      PREVIEWGUI('Property','Value',...) creates a new PREVIEWGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before previewgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to previewgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help previewgui

% Last Modified by GUIDE v2.5 11-Jan-2018 09:25:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @previewgui_OpeningFcn, ...
                   'gui_OutputFcn',  @previewgui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before previewgui is made visible.
function previewgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to previewgui (see VARARGIN)

% Choose default command line output for previewgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

handles.directory='/fastdata/cs1mkg/smaug/spic_5b2_2_bv200G/';
%handles.directory=uigetdir();
handles.extension='.out';
handles.ndirectory=[handles.directory,'impreview/'];
%ndirectory='/fastdata/cs1mkg/smaug/spic_5b2_2_bv200G/impreview/';
handles.nextension='.jpg';

%figure;
handles.pic=1000;
handles.picstart=handles.pic;

handles.sb1=2; %slice for base 1
handles.svx1=108; % slice for vertical x
handles.svy1=108; % slice for vertical y

handles.rootfilename='zerospic1__'
    
handles.id=int2str(handles.pic);
%handles.id=int2str(1000*i);
handles.filename=[handles.directory,'/',handles.rootfilename,handles.id,handles.extension];
handles.timetext=['time=',int2str(i),'s'];
handles.imfile=[handles.ndirectory,'im1_',handles.id,handles.nextension];
handles.figfile=[handles.ndirectory,'fig1_',handles.id,'.fig'];

disp([handles.id handles.filename]);
   fid=fopen(trim(handles.filename));
   %fseek(fid,pictsize(ifile)*(npict(ifile)-1),'bof');
   handles.headline=trim(setstr(fread(fid,79,'char')'));
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
handles.wd=zeros(nw,nx1,nx2,nx3);
for iw=1:nw
  
     tmp=reshape(w(:,iw),nx1,nx2,nx3);
     handles.wd(iw,:,:,:)=tmp;
end


%w=tmp(iw);
  

clear tmp; 
   
   
   fclose(fid);




%plot sections through 3d array
   %slice=48;
   x=linspace(0,4,128);
   y=linspace(0,4,128);
   z=linspace(0,6,128);
   
   
   
   
   handles.nrange=3:126;
   
   ax=x(handles.nrange);
   ay=y(handles.nrange);
   az=z(handles.nrange);
   [x1,x2,x3] = meshgrid(ax,ay,az);


	R=8.3e+003;
	mu=1.257E-6;
	mu_gas=0.6;
	gamma=1.66667;

 
   guidata(hObject,handles); 
    
%typedef enum vars {rho, mom1, mom2, mom3, energy, b1, b2, b3,energyb,rhob,b1b,b2b,b3b} CEV;





 



% This sets up the initial plot - only do when we are invisible
% so window can get raised using previewgui.
if strcmp(get(hObject,'Visible'),'off')
    
    
   
   subplot(2,2,1)
   hold on

   myval=shiftdim(reshape(handles.wd(2,handles.nrange,handles.nrange,handles.nrange)./(handles.wd(1,handles.nrange,handles.nrange,handles.nrange)+handles.wd(10,handles.nrange,handles.nrange,handles.nrange)),124,124,124),1);
   h=slice(myval,handles.svx1, handles.svy1,[handles.sb1  85]);  %used for 2,2 mode
 
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
   text(-100,0,175,handles.timetext);
title('velocity');

    hold off


  
   subplot(2,2,2)
 hold on
   myval=shiftdim(reshape(handles.wd(1,handles.nrange,handles.nrange,handles.nrange),124,124,124),1);
   h=slice(myval,handles.svx1, handles.svy1,[handles.sb1  85]);  %used for 2,2 mode
 
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
   text(-100,0,175,handles.timetext);
 title('density' );

    hold off


   subplot(2,2,3)
 hold on
   myval=shiftdim(reshape(handles.wd(5,handles.nrange,handles.nrange,handles.nrange),124,124,124),1);
   h=slice(myval,handles.svx1, handles.svy1,[handles.sb1  85]);  %used for 2,2 mode
 
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
   text(-100,0,175,handles.timetext);
 title('E' );

    hold off


   subplot(2,2,4)
 hold on

   myval=shiftdim(reshape(handles.wd(6,handles.nrange,handles.nrange,handles.nrange),124,124,124),1);
   h=slice(myval,handles.svx1, handles.svy1,[handles.sb1  85]);  %used for 2,2 mode
 
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
   text(-100,0,175,handles.timetext);
 title('B' );

    hold off

end

  print('-djpeg', handles.imfile);



% UIWAIT makes previewgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = previewgui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% axes(handles.axes1);
% cla;

%popup_sel_index = get(handles.popupmenu1, 'Value');


   subplot(2,2,1)
   hold on

   myval=shiftdim(reshape(handles.wd(2,handles.nrange,handles.nrange,handles.nrange)./(handles.wd(1,handles.nrange,handles.nrange,handles.nrange)+handles.wd(10,handles.nrange,handles.nrange,handles.nrange)),124,124,124),1);
   h=slice(myval,handles.svx1, handles.svy1,[handles.sb1  85]);  %used for 2,2 mode
 
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
   text(-100,0,175,handles.timetext);
title('velocity');

    hold off


  
   subplot(2,2,2)
 hold on
   myval=shiftdim(reshape(handles.wd(1,handles.nrange,handles.nrange,handles.nrange),124,124,124),1);
   h=slice(myval,handles.svx1, handles.svy1,[handles.sb1  85]);  %used for 2,2 mode
 
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
   text(-100,0,175,handles.timetext);
 title('density' );

    hold off


   subplot(2,2,3)
 hold on
   myval=shiftdim(reshape(handles.wd(5,handles.nrange,handles.nrange,handles.nrange),124,124,124),1);
   h=slice(myval,handles.svx1, handles.svy1,[handles.sb1  85]);  %used for 2,2 mode
 
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
   text(-100,0,175,handles.timetext);
 title('E' );

    hold off


   subplot(2,2,4)
 hold on

   myval=shiftdim(reshape(handles.wd(6,handles.nrange,handles.nrange,handles.nrange),124,124,124),1);
   h=slice(myval,handles.svx1, handles.svy1,[handles.sb1  85]);  %used for 2,2 mode
 
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
   text(-100,0,175,handles.timetext);
 title('B' );

    hold off

  print('-djpeg', handles.imfile);






% switch popup_sel_index
%     case 1
%         plot(rand(5));
%     case 2
%         plot(sin(1:0.01:25.99));
%     case 3
%         bar(1:.5:10);
%     case 4
%         plot(membrane);
%     case 5
%         surf(peaks);
% end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --------------------------------------------------------------------
function Open_1_Callback(hObject, eventdata, handles)
% hObject    handle to Open_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sdir=uigetdir();
if exist(sdir,'dir')
    handles.directory=sdir;
else
    handles.directory='/fastdata/cs1mkg/smaug/spic_5b2_2_bv200G';
end
guidata(hObject,handles); 

% --- Executes on slider movement.
function slider_sb1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_sb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.sb1=get(hObject,'Value');
  guidata(hObject,handles); 

% --- Executes during object creation, after setting all properties.
function slider_sb1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_sb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_svx1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_svx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.svx1=get(hObject,'Value');
  guidata(hObject,handles);
  

% --- Executes during object creation, after setting all properties.
function slider_svx1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_svx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
  guidata(hObject,handles); 

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
handles.rootfilename=get(hObject,'String');
 guidata(hObject,handles); 

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editpic_Callback(hObject, eventdata, handles)
% hObject    handle to editpic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editpic as text
%        str2double(get(hObject,'String')) returns contents of editpic as a double
handles.pic=str2double(get(hObject,'String'));
handles.id=str2double(get(hObject,'String'));
  guidata(hObject,handles); 

% --- Executes during object creation, after setting all properties.
function editpic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editpic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slidersvy1_Callback(hObject, eventdata, handles)
% hObject    handle to slidersvy1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.svy1=get(hObject,'Value');
  guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slidersvy1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slidersvy1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton_newpic.
function pushbutton_newpic_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_newpic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.directory=uigetdir();
handles.extension='.out';
% handles.ndirectory=[handles.directory,'impreview/'];
%ndirectory='/fastdata/cs1mkg/smaug/spic_5b2_2_bv200G/impreview/';
handles.nextension='.jpg';

%figure;
% handles.pic=1000;
handles.picstart=handles.pic;

% handles.sb1=2; %slice for base 1
% handles.svx1=108; % slice for vertical x
% handles.svy1=108; % slice for vertical y
% 
% handles.rootfilename='zerospic1__'
    
handles.id=int2str(handles.pic);
%handles.id=int2str(1000*i);
handles.filename=[handles.directory,'/',handles.rootfilename,handles.id,handles.extension];
handles.timetext=['time=',int2str(handles.id),'s'];
handles.imfile=[handles.ndirectory,'im1_',handles.id,handles.nextension];
handles.figfile=[handles.ndirectory,'fig1_',handles.id,'.fig'];

disp([handles.id handles.filename]);
   fid=fopen(trim(handles.filename));
   %fseek(fid,pictsize(ifile)*(npict(ifile)-1),'bof');
   handles.headline=trim(setstr(fread(fid,79,'char')'));
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
handles.wd=zeros(nw,nx1,nx2,nx3);
for iw=1:nw
  
     tmp=reshape(w(:,iw),nx1,nx2,nx3);
     handles.wd(iw,:,:,:)=tmp;
end


%w=tmp(iw);
  

clear tmp; 
   
   
   fclose(fid);
 guidata(hObject,handles); 
