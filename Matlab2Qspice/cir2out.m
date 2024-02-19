function [Qpath]=cir2out(Qpathname)
%cir2out    Qspice from netlist (.cir) to post processor (.out)
%   [Qpath]=cir2out(Qpathname,Qswitch)
%       Qpathname : full path and filename of .cir
%
%**Important Note
%   If Qspice is not installed into C:\Program Files\QSPICE\
%   Search variable QspicePath and change to your Qspice install path
%
%Github : https://github.com/KSKelvin-Github/Qspice
%last update : 20-Feb-2024 12:30pm

% Input arguments assignment
Qpath.cir = Qpathname;

% Qspice Path and Windows Command Separator
QspicePath = 'C:\Program Files\QSPICE\';    % Depends on Installation Path
% verify Qspice path contains QUX.exe, QSPICE64.exe and QSPICE80.exe
if ~isfile([QspicePath,'QUX.exe']) | ~isfile([QspicePath,'QSPICE64.exe']) | ~isfile([QspicePath,'QSPICE80.exe'])
    display(['qsch2qraw() error : QUX.exe or QSPICE64.exe or QSPICE80.exe does not exist in ',QspicePath]);
    display(['  Location variable QspicePath in qsch2qraw() to confirm Qspice Installation Path'])
    return;
end
% Windows command separator
if ~exist('cmdsep')     % before Matlab 2023b
    cmdsep = '&&';      % windows command separator
end

% system command : QPOST : .out file for console output
cmd_str = [
    'path ',QspicePath,...                                  % path C:\Program Files\QSPICE\
    cmdsep,...                                              % command seqparator '&&'
    'QPOST "',Qpath.cir,'" -o "',Qpath.cir(1:end-4),'.out"' % QPOST "C:\...\*.cir" -o "C:\...\*.out"
    ];
display('cir2out() : QPOST Post Processing is Running...')
display(['  system command : ',char(cmd_str)])
[status,cmdout] = system(cmd_str);                          % execute operating system command
Qpath.out = [Qpathname(1:end-4),'.out'];

% system command : QPOST : Console output only
if false
    cmd_str = [
        'path ',QspicePath,...          % path C:\Program Files\QSPICE\
        cmdsep,...                      % command seqparator '&&'
        'QPOST "',Qpath.cir,'"'         % QPOST "C:\...\*.cir"
        ];
    [status,cmdout] = system(cmd_str);  % execute operating system command
    display(' ');
    display('## QPOST Console Output')
    display(char(cmdout));              % print console output in command window
end

end