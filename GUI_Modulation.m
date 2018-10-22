function varargout = GUI_Modulation(varargin)
% GUI_MODULATION MATLAB code for GUI_Modulation.fig
%      GUI_MODULATION, by itself, creates a new GUI_MODULATION or raises the existing
%      singleton*.
%
%      H = GUI_MODULATION returns the handle to a new GUI_MODULATION or the handle to
%      the existing singleton*.
%
%      GUI_MODULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MODULATION.M with the given input arguments.
%
%      GUI_MODULATION('Property','Value',...) creates a new GUI_MODULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Modulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Modulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Modulation

% Last Modified by GUIDE v2.5 22-Oct-2018 19:42:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Modulation_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Modulation_OutputFcn, ...
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


% --- Executes just before GUI_Modulation is made visible.
function GUI_Modulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Modulation (see VARARGIN)

% Choose default command line output for GUI_Modulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Modulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global recordedSound;
recordedSound = [];


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Modulation_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1_register.
function pushbutton1_register_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_register (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs recordedSound;
regTime = str2double(get(handles.edit1_time,'String'));
if ~isnan(regTime)
    Fs = 44100;
    recObj = audiorecorder(Fs,16,1);
    recordblocking(recObj,regTime);
    recordedSound = getaudiodata(recObj);
    
    N = length(recordedSound);
    df = Fs/N;
    f = 0:df:Fs/2;
    amp_raw = fft(recordedSound);
    amp_raw = abs(amp_raw);
    amp_raw = amp_raw(1:N/2+1);
    amp_raw = amp_raw/(N/2);
    
    axes(handles.axes1_sound);
    plot(f,amp_raw);
    set(gca,'FontSize',8);
    title('Zarejestrowany dŸwiêk');
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    zoom on;
else
    msgbox('Podaj czas rejestracji dŸwiêku.','B³¹d','warn');
end


function edit2_mod_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_mod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_mod as text
%        str2double(get(hObject,'String')) returns contents of edit2_mod as a double


% --- Executes during object creation, after setting all properties.
function edit2_mod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_mod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2_mod.
function pushbutton2_mod_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_mod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs recordedSound;
carrier = str2double(get(handles.edit2_mod,'String'));
isSoundRecorded = ~isempty(recordedSound);
isCarrierNumber = ~isnan(carrier);
isModulationPossible = isSoundRecorded && isCarrierNumber;

if isModulationPossible
    freqDev = 50;
    phaseDev = pi/2;
    N = length(recordedSound);
    df = Fs/N;
    f = 0:df:Fs/2;
    
    soundAM = ammod(recordedSound,carrier,Fs);
    amp_raw_AM = fft(soundAM);
    amp_raw_AM = abs(amp_raw_AM);
    amp_raw_AM = amp_raw_AM(1:N/2+1);
    amp_raw_AM = amp_raw_AM/(N/2);
    
    soundFM = fmmod(recordedSound,carrier,Fs,freqDev);
    amp_raw_FM = fft(soundFM);
    amp_raw_FM = abs(amp_raw_FM);
    amp_raw_FM = amp_raw_FM(1:N/2+1);
    amp_raw_FM = amp_raw_FM/(N/2);
    
    soundPM = pmmod(recordedSound,carrier,Fs,phaseDev);
    amp_raw_PM = fft(soundPM);
    amp_raw_PM = abs(amp_raw_PM);
    amp_raw_PM = amp_raw_PM(1:N/2+1);
    amp_raw_PM = amp_raw_PM/(N/2);
    
    axes(handles.axes2_am);
    plot(f,amp_raw_AM);
    title('Modulacja AM');
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    set(gca,'FontSize',8);
    zoom on;
    
    axes(handles.axes3_fm);
    plot(f,amp_raw_FM);
    title('Modulacja FM');
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    set(gca,'FontSize',8);
    zoom on;
    
    axes(handles.axes4_pm);
    plot(f,amp_raw_PM);
    title('Modulacja PM');
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    set(gca,'FontSize',8);
    zoom on;
else
    msgbox('Nie zarejestrowano dŸwiêku lub nie podano czêstotliwoœci fali noœnej.','B³¹d','warn');
end


% --- Executes on button press in pushbutton3_exit.
function pushbutton3_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);
