function varargout = mergeBF(varargin)
% MERGEBF MATLAB code for mergeBF.fig
%      MERGEBF, by itself, creates a new MERGEBF or raises the existing
%      singleton*.
%
%      H = MERGEBF returns the handle to a new MERGEBF or the handle to
%      the existing singleton*.
%
%      MERGEBF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MERGEBF.M with the given input arguments.
%
%      MERGEBF('Property','Value',...) creates a new MERGEBF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mergeBF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mergeBF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mergeBF

% Last Modified by GUIDE v2.5 10-May-2017 21:10:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mergeBF_OpeningFcn, ...
                   'gui_OutputFcn',  @mergeBF_OutputFcn, ...
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


% --- Executes just before mergeBF is made visible.
function mergeBF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mergeBF (see VARARGIN)

% Choose default command line output for mergeBF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mergeBF wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function result = MERGE(hObject, handles)
% edit and show
minx = str2double(get(handles.min_x, 'String')); 
if(minx<1)
    set(handles.min_x, 'String', 1);
    minx=1;
end
maxx = str2double(get(handles.max_x, 'String'));
if(maxx>size(handles.img_f,1))
    set(handles.max_x, 'String', size(handles.img_f,1));
    maxx=size(handles.img_f,1);
end
miny = str2double(get(handles.min_y, 'String'));
if(miny<1)
    set(handles.min_y, 'String', 1);
    miny=1;
end
maxy = str2double(get(handles.max_y, 'String'));
if(maxy>size(handles.img_f,2))
    set(handles.max_y, 'String', size(handles.img_f,2));
    maxy=size(handles.img_f,2);
end
scale = str2double(get(handles.pos_s, 'String'));
pos_h = str2double(get(handles.pos_h, 'String')); 
if(pos_h<1)
    set(handles.pos_h, 'String', 1);
    pos_h =1 ;
end
pos_w = str2double(get(handles.pos_w, 'String'));
if(pos_w<1)
    set(handles.pos_w, 'String', 1);
    pos_w =1 ;
end
rotate = str2double(get(handles.pos_r, 'String'));
result = handles.img_b;
temp_f = imresize(handles.img_f(minx:maxx, miny:maxy,:), scale);
temp_s = repmat(imresize(handles.img_s(minx:maxx, miny:maxy,:), scale),[1,1,3]);
temp_f = imrotate(temp_f,rotate,'bilinear');
temp_s = imrotate(temp_s,rotate,'bilinear');
h_max = min(size(result, 1), pos_h+size(temp_f, 1)-1);
w_max = min(size(result, 2), pos_w+size(temp_f, 2)-1);
temp_f = temp_f(pos_h-pos_h+1:h_max-pos_h+1, pos_w-pos_w+1:w_max-pos_w+1,:);
temp_s = temp_s(pos_h-pos_h+1:h_max-pos_h+1, pos_w-pos_w+1:w_max-pos_w+1,:);
result(pos_h:h_max, pos_w:w_max, :) = temp_f.*temp_s + result(pos_h:h_max, pos_w:w_max, :).*(1-temp_s);
imshow(result, 'parent', handles.result);
% end
set(handles.text_debug, 'String','down');

% --- Outputs from this function are returned to the command line.
function varargout = mergeBF_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function bfilename_Callback(hObject, eventdata, handles)
% hObject    handle to bfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bfilename as text
%        str2double(get(hObject,'String')) returns contents of bfilename as a double


% --- Executes during object creation, after setting all properties.
function bfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ffilename_Callback(hObject, eventdata, handles)
% hObject    handle to ffilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ffilename as text
%        str2double(get(hObject,'String')) returns contents of ffilename as a double


% --- Executes during object creation, after setting all properties.
function ffilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ffilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadimage.
function loadimage_Callback(hObject, eventdata, handles)
% hObject    handle to loadimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get para
handles.bpathname = ['..\frame\' get(handles.bfilename, 'String') '\im'];
handles.fpathname = ['..\frame\' get(handles.ffilename, 'String') '_align_crop\im'];
handles.spathname = ['..\out\' get(handles.ffilename, 'String') '\im'];
% read image
index_b = 1;
index_s = 1;
index_f = 1;
zerostr = '0000';
handles.img_b = im2double(imread([handles.bpathname, zerostr(1:4-floor(log10(index_b))), int2str(index_b), '.png']));
handles.img_f = im2double(imread([handles.fpathname, zerostr(1:4-floor(log10(index_f))), int2str(index_f), '.png']));
handles.img_s = im2double(imread([handles.spathname, zerostr(1:4-floor(log10(index_f))), int2str(index_f), '.png']));
% edit and show
minx = 1;
maxx = size(handles.img_f, 1);
miny = 1;
maxy = size(handles.img_f, 2);
scale = 0.5;
pos_h = 1;
pos_w = 1;
rotate = -90;
%
guidata(hObject,handles);
% setting
set(handles.frame_num_b, 'String', num2str(index_b));
set(handles.frame_num_f, 'String', num2str(index_f));
set(handles.frame_num_s, 'String', num2str(index_s));
set(handles.min_x, 'String', num2str(minx));
set(handles.max_x, 'String', num2str(maxx));
set(handles.min_y, 'String', num2str(miny));
set(handles.max_y, 'String', num2str(maxy));
set(handles.pos_h, 'String', num2str(pos_h));
set(handles.pos_w, 'String', num2str(pos_w));
set(handles.pos_r, 'String', num2str(rotate));
set(handles.pos_s, 'String', num2str(scale));
set(handles.text_debug, 'String','down');
% run
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

function pos_h_Callback(hObject, eventdata, handles)
% hObject    handle to pos_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_h as text
%        str2double(get(hObject,'String')) returns contents of pos_h as a double
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function pos_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pos_w_Callback(hObject, eventdata, handles)
% hObject    handle to pos_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_w as text
%        str2double(get(hObject,'String')) returns contents of pos_w as a double
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function pos_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pos_s_Callback(hObject, eventdata, handles)
% hObject    handle to pos_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_s as text
%        str2double(get(hObject,'String')) returns contents of pos_s as a double
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function pos_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pos_r_Callback(hObject, eventdata, handles)
% hObject    handle to pos_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_r as text
%        str2double(get(hObject,'String')) returns contents of pos_r as a double
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function pos_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveresult.
function saveresult_Callback(hObject, eventdata, handles)
% hObject    handle to saveresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_debug, 'String','running...');
result = MERGE(hObject, handles);
set(handles.text_debug, 'String','down');
path = ['..\out\' get(handles.bfilename, 'String') '_' get(handles.ffilename, 'String') '\im'];
index = str2double(get(handles.frame_num_s, 'String'));
zerostr = '0000';
% figure,  imshow(result);
set(handles.text_debug, 'String', [path, zerostr(1:4-floor(log10(index))), int2str(index), '.png']);
imwrite(result, [path, zerostr(1:4-floor(log10(index))), int2str(index), '.png']);


% --- Executes on button press in preimage.
function preimage_Callback(hObject, eventdata, handles)
% hObject    handle to preimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index_b = str2double(get(handles.frame_num_b,'String')) - 1;
index_f = str2double(get(handles.frame_num_f,'String')) - 1;
index_s = str2double(get(handles.frame_num_s,'String')) - 1;
set(handles.frame_num_b, 'String', index_b);
set(handles.frame_num_f, 'String', index_f);
set(handles.frame_num_s, 'String', index_s);
zerostr = '0000';
handles.img_b = im2double(imread([handles.bpathname, zerostr(1:4-floor(log10(index_b))), int2str(index_b), '.png']));
handles.img_f = im2double(imread([handles.fpathname, zerostr(1:4-floor(log10(index_f))), int2str(index_f), '.png']));
handles.img_s = im2double(imread([handles.spathname, zerostr(1:4-floor(log10(index_f))), int2str(index_f), '.png']));
guidata(hObject,handles);
%
set(handles.text_debug, 'String','running...');
result = MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes on button press in nextimage.
function nextimage_Callback(hObject, eventdata, handles)
% hObject    handle to nextimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index_b = str2double(get(handles.frame_num_b,'String')) + 1;
index_f = str2double(get(handles.frame_num_f,'String')) + 1;
index_s = str2double(get(handles.frame_num_s,'String')) + 1;
set(handles.frame_num_b, 'String', index_b);
set(handles.frame_num_f, 'String', index_f);
set(handles.frame_num_s, 'String', index_s);
zerostr = '0000';
handles.img_b = im2double(imread([handles.bpathname, zerostr(1:4-floor(log10(index_b))), int2str(index_b), '.png']));
handles.img_f = im2double(imread([handles.fpathname, zerostr(1:4-floor(log10(index_f))), int2str(index_f), '.png']));
handles.img_s = im2double(imread([handles.spathname, zerostr(1:4-floor(log10(index_f))), int2str(index_f), '.png']));
guidata(hObject,handles);
%
set(handles.text_debug, 'String','running...');
result = MERGE(hObject, handles);
set(handles.text_debug, 'String','down');


function min_x_Callback(hObject, eventdata, handles)
% hObject    handle to min_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_x as text
%        str2double(get(hObject,'String')) returns contents of min_x as a double
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function min_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_x_Callback(hObject, eventdata, handles)
% hObject    handle to max_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_x as text
%        str2double(get(hObject,'String')) returns contents of max_x as a double
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function max_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_y_Callback(hObject, eventdata, handles)
% hObject    handle to min_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_y as text
%        str2double(get(hObject,'String')) returns contents of min_y as a double
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function min_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_y_Callback(hObject, eventdata, handles)
% hObject    handle to max_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_y as text
%        str2double(get(hObject,'String')) returns contents of max_y as a double
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function max_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_num_b_Callback(hObject, eventdata, handles)
% hObject    handle to frame_num_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_num_b as text
%        str2double(get(hObject,'String')) returns contents of frame_num_b as a double
%
index_b = str2double(get(handles.frame_num_b,'String')) + 1;
zerostr = '0000';
handles.img_b = im2double(imread([handles.bpathname, zerostr(1:4-floor(log10(index_b))), int2str(index_b), '.png']));
guidata(hObject,handles);
%
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function frame_num_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_num_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_num_f_Callback(hObject, eventdata, handles)
% hObject    handle to frame_num_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_num_f as text
%        str2double(get(hObject,'String')) returns contents of frame_num_f as a double
index_f = str2double(get(handles.frame_num_f,'String')) + 1;
index_s = index_f;
zerostr = '0000';
handles.img_s = im2double(imread([handles.spathname, zerostr(1:4-floor(log10(index_s))), int2str(index_s), '.png']));
handles.img_f = im2double(imread([handles.fpathname, zerostr(1:4-floor(log10(index_f))), int2str(index_f), '.png']));
guidata(hObject,handles);
%
set(handles.text_debug, 'String','running...');
MERGE(hObject, handles);
set(handles.text_debug, 'String','down');

% --- Executes during object creation, after setting all properties.
function frame_num_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_num_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_num_s_Callback(hObject, eventdata, handles)
% hObject    handle to frame_num_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_num_s as text
%        str2double(get(hObject,'String')) returns contents of frame_num_s as a double

% --- Executes during object creation, after setting all properties.
function frame_num_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_num_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
