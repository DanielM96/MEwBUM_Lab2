function varargout = GUI_Playback(varargin)
% GUI_PLAYBACK MATLAB code for GUI_Playback.fig
%      GUI_PLAYBACK, by itself, creates a new GUI_PLAYBACK or raises the existing
%      singleton*.
%
%      H = GUI_PLAYBACK returns the handle to a new GUI_PLAYBACK or the handle to
%      the existing singleton*.
%
%      GUI_PLAYBACK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PLAYBACK.M with the given input arguments.
%
%      GUI_PLAYBACK('Property','Value',...) creates a new GUI_PLAYBACK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Playback_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Playback_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Playback

% Last Modified by GUIDE v2.5 21-Oct-2018 15:21:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Playback_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Playback_OutputFcn, ...
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


% --- Executes just before GUI_Playback is made visible.
function GUI_Playback_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Playback (see VARARGIN)

% Choose default command line output for GUI_Playback
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Playback wait for user response (see UIRESUME)
% uiwait(handles.figure1);
evalin('base','clear; clc;');
global Fs t octaves fullSound isSoundRegistered;
Fs = 44100;
T = 0.5; % 0,5 sekundy
t = 1/Fs:1/Fs:T; % czas trwania sygna³u
fullSound = [];
isSoundRegistered = 0;
% oktawy
% subkontra - kontra - wielka - ma³a - razkreœlna -...- szeœciokreœlna
octaves = [ 16 33 65 131 262 523 1046 2093 4186 8372;...    % C
    18 37 73 147 294 587 1175 2349 4699 9398;...            % D
    21 41 82 165 330 659 1318 2637 5274 10548;...           % E
    22 44 87 175 349 698 1397 2794 5587 11175;...           % F
    24 49 98 196 392 784 1568 3136 6272 12544;...           % G
    27 55 110 220 440 880 1760 3520 7040 14080;...          % A
    31 62 123 247 494 988 1976 3951 7902 15805;...          % H
    33 65 131 262 523 1046 2093 4186 8372 16744 ];          % C2

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Playback_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1_exit.
function pushbutton1_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);


% --- Executes on button press in pushbutton2_note_c.
function pushbutton2_note_c_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_note_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t selectedOctave octaves fullSound isSoundRegistered;
% dŸwiêk C
fSound = octaves(1,selectedOctave);
soundSignal = sin(2*pi*fSound*t);
sound(soundSignal,Fs);
spectrogram(soundSignal,1024,512,1024,Fs);
zoom on;
if isSoundRegistered
    if isempty(fullSound)
        fullSound = fullSound';
    end
    fullSound = [ fullSound; soundSignal' ];
end

% --- Executes on button press in pushbutton3_note_d.
function pushbutton3_note_d_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3_note_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t selectedOctave octaves fullSound isSoundRegistered;
% dŸwiêk D
fSound = octaves(2,selectedOctave);
soundSignal = sin(2*pi*fSound*t);
sound(soundSignal,Fs);
spectrogram(soundSignal,1024,512,1024,Fs);
zoom on;
if isSoundRegistered
    if isempty(fullSound)
        fullSound = fullSound';
    end
    fullSound = [ fullSound; soundSignal' ];
end

% --- Executes on button press in pushbutton4_note_e.
function pushbutton4_note_e_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4_note_e (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t selectedOctave octaves fullSound isSoundRegistered;
% dŸwiêk E
fSound = octaves(3,selectedOctave);
soundSignal = sin(2*pi*fSound*t);
sound(soundSignal,Fs);
spectrogram(soundSignal,1024,512,1024,Fs);
zoom on;
if isSoundRegistered
    if isempty(fullSound)
        fullSound = fullSound';
    end
    fullSound = [ fullSound; soundSignal' ];
end

% --- Executes on button press in pushbutton5_note_f.
function pushbutton5_note_f_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5_note_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t selectedOctave octaves fullSound isSoundRegistered;
% dŸwiêk F
fSound = octaves(4,selectedOctave);
soundSignal = sin(2*pi*fSound*t);
sound(soundSignal,Fs);
spectrogram(soundSignal,1024,512,1024,Fs);
zoom on;
if isSoundRegistered
    if isempty(fullSound)
        fullSound = fullSound';
    end
    fullSound = [ fullSound; soundSignal' ];
end

% --- Executes on button press in pushbutton6_note_g.
function pushbutton6_note_g_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6_note_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t selectedOctave octaves fullSound isSoundRegistered;
% dŸwiêk G
fSound = octaves(5,selectedOctave);
soundSignal = sin(2*pi*fSound*t);
sound(soundSignal,Fs);
spectrogram(soundSignal,1024,512,1024,Fs);
zoom on;
if isSoundRegistered
    if isempty(fullSound)
        fullSound = fullSound';
    end
    fullSound = [ fullSound; soundSignal' ];
end

% --- Executes on button press in pushbutton7_note_a.
function pushbutton7_note_a_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7_note_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t selectedOctave octaves fullSound isSoundRegistered;
% dŸwiêk A
fSound = octaves(6,selectedOctave);
soundSignal = sin(2*pi*fSound*t);
sound(soundSignal,Fs);
spectrogram(soundSignal,1024,512,1024,Fs);
zoom on;
if isSoundRegistered
    if isempty(fullSound)
        fullSound = fullSound';
    end
    fullSound = [ fullSound; soundSignal' ];
end

% --- Executes on button press in pushbutton8_note_h.
function pushbutton8_note_h_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8_note_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t selectedOctave octaves fullSound isSoundRegistered;
% dŸwiêk H
fSound = octaves(7,selectedOctave);
soundSignal = sin(2*pi*fSound*t);
sound(soundSignal,Fs);
spectrogram(soundSignal,1024,512,1024,Fs);
zoom on;
if isSoundRegistered
    if isempty(fullSound)
        fullSound = fullSound';
    end
    fullSound = [ fullSound; soundSignal' ];
end

% --- Executes on button press in pushbutton9_note_c_2.
function pushbutton9_note_c_2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9_note_c_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs t selectedOctave octaves fullSound isSoundRegistered;
% dŸwiêk C2
fSound = octaves(8,selectedOctave);
soundSignal = sin(2*pi*fSound*t);
sound(soundSignal,Fs);
spectrogram(soundSignal,1024,512,1024,Fs);
zoom on;
if isSoundRegistered
    if isempty(fullSound)
        fullSound = fullSound';
    end
    fullSound = [ fullSound; soundSignal' ];
end


% --- Executes on selection change in popupmenu1_octave_selector.
function popupmenu1_octave_selector_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1_octave_selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1_octave_selector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1_octave_selector
global selectedOctave;
selectedOctave = get(hObject,'Value');
if selectedOctave >= 8
    msgbox({'UWAGA!','',...
        'Jeœli chcesz do¿yæ staroœci i nie denerwowaæ otoczenia - wybierz ni¿sz¹ oktawê.'},...
        'Ostrze¿enie!','warn');
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_octave_selector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1_octave_selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global selectedOctave;
set(hObject,'Value',5);
selectedOctave = get(hObject,'Value');


% --- Executes on button press in checkbox1_fullsound.
function checkbox1_fullsound_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1_fullsound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1_fullsound
global isSoundRegistered;
isSoundRegistered = get(hObject,'Value');
if ~isSoundRegistered
    set(handles.pushbutton10_play_fullsound,'Enable','off');
else
    set(handles.pushbutton10_play_fullsound,'Enable','on');
    set(handles.pushbutton11_clear_fullsound,'Enable','on');
end

% --- Executes on button press in pushbutton10_play_fullsound.
function pushbutton10_play_fullsound_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10_play_fullsound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fullSound Fs;
if ~isempty(fullSound)
    sound(fullSound,Fs);
    spectrogram(fullSound,1024,512,1024,Fs);
else
    msgbox({'Brak zarejestrowanego dŸwiêku.','Nie ma czego odtwarzaæ.'},'B³¹d','warn');
end

% --- Executes during object creation, after setting all properties.
function pushbutton10_play_fullsound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton10_play_fullsound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global isSoundRegistered;
if ~isSoundRegistered
    set(hObject,'Enable','off');
end


% --- Executes on button press in pushbutton11_clear_fullsound.
function pushbutton11_clear_fullsound_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11_clear_fullsound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fullSound;
if ~isempty(fullSound)
    fullSound = [];
    cla(handles.axes1_spectre,'reset');
else
    msgbox({'Brak zarejestrowanego dŸwiêku.','Nie ma czego usuwaæ.'},'B³¹d','warn');
end

% --- Executes during object creation, after setting all properties.
function pushbutton11_clear_fullsound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton11_clear_fullsound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global isSoundRegistered;
if ~isSoundRegistered
    set(hObject,'Enable','off');
end
