function varargout = CVProject(varargin)
% CVPROJECT MATLAB code for CVProject.fig
%      CVPROJECT, by itself, creates a new CVPROJECT or raises the existing
%      singleton*.
%
%      H = CVPROJECT returns the handle to a new CVPROJECT or the handle to
%      the existing singleton*.
%
%      CVPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CVPROJECT.M with the given input arguments.
%
%      CVPROJECT('Property','Value',...) creates a new CVPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CVProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CVProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CVProject

% Last Modified by GUIDE v2.5 24-Dec-2017 21:45:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CVProject_OpeningFcn, ...
                   'gui_OutputFcn',  @CVProject_OutputFcn, ...
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


% --- Executes just before CVProject is made visible.
function CVProject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CVProject (see VARARGIN)

% Choose default command line output for CVProject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CVProject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CVProject_OutputFcn(hObject, eventdata, handles) 
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
    [rawname, rawpath] = uigetfile({'*.mp4*';'*.avi*'},'Select Image Data');
    fullname = [rawpath rawname];
    global vid;
    vid = VideoReader(fullname);
    numframes = vid.NumberOfFrames()
    global num_of_frames;
    num_of_frames = vid.NumberOfFrames();
    set(handles.edit1, 'String', num_of_frames);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
    global vid;
    editText = get(handles.edit2,'String');
    frame_num=str2num(editText);
    global frame;
    frame = read(vid,frame_num);
    axes(handles.axes1);
    imshow(frame);

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global frame;
BW = im2bw(frame);
axes(handles.axes2);
newimg = dilation(BW);
imshow(newimg);

areaofimg = areaofobj(newimg);
centcoord = centerofobj(newimg);

%find the 2 biggest objects and store their indices
maxa = 0;
maxb = 0;
max1a = 0;
max1b = 0;
for x = 1 : size(areaofimg)
    if areaofimg(x) > maxb
        max1b = maxb;
        max1a = maxa;
        maxb = areaofimg(x);
        maxa = x;
    else
        if areaofimg(x) > max1b
            max1b = areaofimg(x);
            max1a = x;
        end
    end
end

x1 = centcoord(maxa, 1);
y1 = centcoord(maxa, 2);
x2 = centcoord(max1a, 1);
y2 = centcoord(max1a, 2);

%how many cm in 1 pixel%
pixel_len = pixel(frame)

%calculate number of pixels between car start and end point%

dis = distance(newimg,y1,y2)

%calculate actual distance between car start and end point%

realdist = dis * pixel_len
set(handles.edit4, 'String', realdist);



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
