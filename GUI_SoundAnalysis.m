function varargout = GUI_SoundAnalysis(varargin)
% GUI_SOUNDANALYSIS MATLAB code for GUI_SoundAnalysis.fig
%      GUI_SOUNDANALYSIS, by itself, creates a new GUI_SOUNDANALYSIS or raises the existing
%      singleton*.
%
%      H = GUI_SOUNDANALYSIS returns the handle to a new GUI_SOUNDANALYSIS or the handle to
%      the existing singleton*.
%
%      GUI_SOUNDANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SOUNDANALYSIS.M with the given input arguments.
%
%      GUI_SOUNDANALYSIS('Property','Value',...) creates a new GUI_SOUNDANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_SoundAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SoundAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SoundAnalysis

% Last Modified by GUIDE v2.5 17-Oct-2018 20:27:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SoundAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SoundAnalysis_OutputFcn, ...
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


% --- Executes just before GUI_SoundAnalysis is made visible.
function GUI_SoundAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_SoundAnalysis (see VARARGIN)

% Choose default command line output for GUI_SoundAnalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_SoundAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global recordedSound Fs;
isRec = evalin('base','exist(''rec'',''var'') == 1');
isFs = evalin('base','exist(''Fs'',''var'') == 1');
if ~isRec || ~isFs
    msgbox('To GUI mo¿na uruchomiæ tylko z poziomu GUI_SoundRecorder.','B³¹d','error');
    delete(handles.figure1);
else
    recordedSound = evalin('base','rec');
    Fs = evalin('base','Fs');
    N = length(recordedSound);
    df = Fs/N;
    f = 0:df:Fs/2;
    amp_raw = fft(recordedSound);
    amp_raw = abs(amp_raw);
    amp_raw = amp_raw(1:N/2+1);
    amp_raw = amp_raw/(N/2);
    axes(handles.axes1_fft);
    plot(f,amp_raw);
    zoom on;
    title('Widmo zarejestrowanego dŸwiêku');
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    set(gca,'FontSize',8);
    
    n = 256*4;
    axes(handles.axes2_spectre);
    spectrogram(recordedSound,n,n/2,n,Fs);
    zoom on;
end


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SoundAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
