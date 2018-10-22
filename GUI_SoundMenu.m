function varargout = GUI_SoundMenu(varargin)
% GUI_SOUNDMENU MATLAB code for GUI_SoundMenu.fig
%      GUI_SOUNDMENU, by itself, creates a new GUI_SOUNDMENU or raises the existing
%      singleton*.
%
%      H = GUI_SOUNDMENU returns the handle to a new GUI_SOUNDMENU or the handle to
%      the existing singleton*.
%
%      GUI_SOUNDMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SOUNDMENU.M with the given input arguments.
%
%      GUI_SOUNDMENU('Property','Value',...) creates a new GUI_SOUNDMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_SoundMenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SoundMenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SoundMenu

% Last Modified by GUIDE v2.5 22-Oct-2018 18:43:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SoundMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SoundMenu_OutputFcn, ...
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


% --- Executes just before GUI_SoundMenu is made visible.
function GUI_SoundMenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_SoundMenu (see VARARGIN)

% Choose default command line output for GUI_SoundMenu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_SoundMenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);
evalin('base','clear; clc');


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SoundMenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1_record.
function pushbutton1_record_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_SoundRecorder;

% --- Executes on button press in pushbutton2_live.
function pushbutton2_live_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_live (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_Live;

% --- Executes on button press in pushbutton3_mod.
function pushbutton3_mod_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3_mod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_Modulation;

% --- Executes on button press in pushbutton4_about.
function pushbutton4_about_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({ 'GUI do analizy dŸwiêków.',...
    '',...
    'Funkcje: ',...
    '- rejestracja dŸwiêku i jego analiza,',...
    '- analiza widma i spektrogramu dŸwiêku w czasie rzeczywistym,',...
    '- modulacja zarejestrowanego dŸwiêku,',...
    '- odgrywanie dŸwiêków z klawiatury.'...
    '',},'Informacje','help');

% --- Executes on button press in pushbutton5_exit.
function pushbutton5_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);


% --- Executes on button press in pushbutton6_playback.
function pushbutton6_playback_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6_playback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_Playback;
