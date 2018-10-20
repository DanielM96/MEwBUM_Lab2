function varargout = GUI_SoundRecorder(varargin)
% GUI_SOUNDRECORDER MATLAB code for GUI_SoundRecorder.fig
%      GUI_SOUNDRECORDER, by itself, creates a new GUI_SOUNDRECORDER or raises the existing
%      singleton*.
%
%      H = GUI_SOUNDRECORDER returns the handle to a new GUI_SOUNDRECORDER or the handle to
%      the existing singleton*.
%
%      GUI_SOUNDRECORDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SOUNDRECORDER.M with the given input arguments.
%
%      GUI_SOUNDRECORDER('Property','Value',...) creates a new GUI_SOUNDRECORDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_SoundRecorder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SoundRecorder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SoundRecorder

% Last Modified by GUIDE v2.5 17-Oct-2018 20:58:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SoundRecorder_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SoundRecorder_OutputFcn, ...
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


% --- Executes just before GUI_SoundRecorder is made visible.
function GUI_SoundRecorder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_SoundRecorder (see VARARGIN)

% Choose default command line output for GUI_SoundRecorder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_SoundRecorder wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global recordedSound;
evalin('base','clear');
recordedSound = [];


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SoundRecorder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_time as text
%        str2double(get(hObject,'String')) returns contents of edit1_time as a double


% --- Executes during object creation, after setting all properties.
function edit1_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1_start.
function pushbutton1_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs recordedSound;
% recordedSound = [];
regTime = str2double(get(handles.edit1_time,'String'));
if ~isnan(regTime)
    Fs = 44100;
    recObj = audiorecorder(Fs,16,1);
    recordblocking(recObj,regTime);
    recordedSound = getaudiodata(recObj);
    axes(handles.axes1_tv);
    plot(recordedSound);
    zoom on;
else
    msgbox('Podaj czas rejestracji dŸwiêku.','B³¹d','warn');
end

% --- Executes on button press in pushbutton2_play.
function pushbutton2_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global recordedSound Fs;
if ~isempty(recordedSound)
    sound(recordedSound,Fs);
else
    msgbox('Nie ma czego odtwarzaæ. Nagraj dŸwiêk.','B³¹d','warn');
end

% --- Executes on button press in pushbutton3_analyze.
function pushbutton3_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global recordedSound Fs;
if ~isempty(recordedSound)
    assignin('base','rec',recordedSound);
    assignin('base','Fs',Fs);
    GUI_SoundAnalysis;
else
    msgbox('Nie ma czego analizowaæ. Nagraj dŸwiêk.','B³¹d','warn');
end


% --- Executes on button press in pushbutton4_exit.
function pushbutton4_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalin('base','clear');
delete(handles.figure1);
