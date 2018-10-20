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

% Last Modified by GUIDE v2.5 20-Oct-2018 14:29:28

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