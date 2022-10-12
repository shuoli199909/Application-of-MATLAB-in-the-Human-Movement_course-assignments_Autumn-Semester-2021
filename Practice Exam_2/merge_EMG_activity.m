function [on_off] = merge_EMG_activity(on_off,n_data_pts)
%
% MERGE_EMG_ACTIVITY löscht zu kurze Phasen der Aktivität
%
% Input
%   ON_OFF     Vektor der Aktivität
%   N_DATA_PTS Anzahl Datenpunkte für zu kurze Aktivität
%
% Output
%   ON_OFF     bereinigter Vektor der Aktivität
%
% Written:  30.10.09
% Revised:  16.11.12 (Wolf): Example added.
%

%% Bereinigen OnOff
% Einzelne Abschnitte der Aktivität identifizieren
activity_labeled = bwlabel(on_off);
% Je Abschnitt Anzahl Datenpunkte prüfen
for i_label = 1:max(activity_labeled)
    if sum(activity_labeled == i_label)<n_data_pts
        on_off(activity_labeled == i_label) = 0;
    end
end

return

%% Beispiel für zweifachen Funktionsaufruf, um OnOff zu bereinigen:
% Laden der LT_tapping.mat Datei aus Lektion 8
[fname, pname] = uigetfile;
cd(pname)
load(fname)

% OnOff bestimmen
thres_SD_factor = 5;
for i_trial = 1:length(LT_tapping)
    [LT_tapping(i_trial).tibant_R_data_OnOff] = EMG_onoff(LT_tapping(i_trial).tibant_R_abs,thres_SD_factor);
end

% Festlegen der Mindestdauer der Aktivität bei zeitnormierten Daten:
msd_on = 100;    % entspricht 100%%
% Festlegen der Mindestdauer für Inaktivität bei zeitnormierten Daten:
msd_off = 20;

% Bereinigen
for i_trial = 1:length(LT_tapping)
            % Zu kurze Inaktivitäten auffüllen
            LT_tapping(i_trial).tibant_R_data_OnOff = ~merge_EMG_activity(~LT_tapping(i_trial).tibant_R_data_OnOff,msd_off);
            % Zu kurze Aktivitäten entfernen
            LT_tapping(i_trial).tibant_R_data_OnOff = merge_EMG_activity(LT_tapping(i_trial).tibant_R_data_OnOff,msd_on);
end

% Darstellen
i_trial = 1;
figure();
plot(LT_tapping(i_trial).tibant_R_abs,'b-')
hold on
plot(LT_tapping(i_trial).tibant_R_data_OnOff*max(LT_tapping(i_trial).tibant_R_abs)*0.5,'k-'); shg
xlabel('Datenpunkt'); ylabel('EMG Aktivität')
legend('Tib anterior','OnOFF')