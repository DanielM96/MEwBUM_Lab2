function varargout = GUI_Live(varargin)
% GUI_LIVE MATLAB code for GUI_Live.fig
%      GUI_LIVE, by itself, creates a new GUI_LIVE or raises the existing
%      singleton*.
%
%      H = GUI_LIVE returns the handle to a new GUI_LIVE or the handle to
%      the existing singleton*.
%
%      GUI_LIVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_LIVE.M with the given input arguments.
%
%      GUI_LIVE('Property','Value',...) creates a new GUI_LIVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Live_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Live_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Live

% Last Modified by GUIDE v2.5 22-Oct-2018 19:41:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Live_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Live_OutputFcn, ...
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


% --- Executes just before GUI_Live is made visible.
function GUI_Live_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Live (see VARARGIN)

% Choose default command line output for GUI_Live
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Live wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.pushbutton2_stop,'Enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Live_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1_start.
function pushbutton1_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isAudioCaptured;
isAudioCaptured = true;
set(hObject,'Enable','off');
set(handles.pushbutton2_stop,'Enable','on');
Fs = 44100;
recObj = audiorecorder(Fs,16,1);
T = 0.1;
record(recObj);
pause(T*2);
while isAudioCaptured
    record(recObj);
    recordedSound = getaudiodata(recObj);
    
    if (length(recordedSound)) > (Fs*T)
        recordedSound = recordedSound(end-(Fs*T)-1:end);
    end
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
    drawnow;

    n = 256*4;
    axes(handles.axes2_spectre);
    spectrogram(recordedSound,n,n/2,n,Fs);
    zoom on;
    drawnow;
end
stop(recObj);

% --- Executes on button press in pushbutton2_stop.
function pushbutton2_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isAudioCaptured;
set(hObject,'Enable','off');
set(handles.pushbutton1_start,'Enable','on');
isAudioCaptured = false;
cla(handles.axes1_fft,'reset');
cla(handles.axes2_spectre,'reset');


% --- Rejestracja i rysowanie w czasie rzeczywistym.
% function myRecorder = nonBlockingAudioRecorder
% 
% global isAudioCaptured Fs;
% 
% hPlot = plot(NaN,NaN);
% Fs = 44100;
% myRecorder = audiorecorder(sampleRate,16,1);
% set(myRecorder, 'TimerFcn', @myRecorderCallback, 'TimerPeriod', 1);
% atSecond = 1;
% record(myRecorder);
% 
%     function myRecorderCallback(~, ~)
%         allSamples = getaudiodata(myRecorder);
%         newSamples = allSamples((atSecond - 1) * sampleRate + 1:atSecond * sampleRate);
%         
%         xdata = get(hPlot, 'XData');
%         ydata = get(hPlot, 'YData');
%         if isnan(xdata)
%             xdata = linspace(0, atSecond - 1/sampleRate,sampleRate);
%             ydata = [];
%         else
%             xdata = [xdata linspace(atSecond, atSecond + 1 - 1/sampleRate, sampleRate)];
%         end
%         ydata = [ydata newSamples'];
%         set(hPlot, 'XData', xdata, 'YData', ydata);
%         
%         atSecond = atSecond + 1;
%         
%         if ~isAudioCaptured
%             stop(myRecorder);
%         end
%     end
% end


% --- Executes on button press in pushbutton3_exit.
function pushbutton3_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);