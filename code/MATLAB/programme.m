% Isabelle EYSSERIC
% Version Matlab : R2019a
% Systeme d'exploitation : Windows 10



%% Nettoyage de l'espace de travail
close all;
clear all;
clc;

%% Declaration des variables
video = 'wdesk.avi';
nbParticules = 500;


% Début du programme
disp('*********************************************************');
disp('***************** DÉBUT DU PROGRAMME ********************');
disp('************ Suivi d''objets en mouvement ***************');
disp('*********************************************************');
disp(' ');

% Appel de fonction
disp('Suivi... ');
suiviFP ( video, nbParticules);
disp('Fin... ');
disp(' ');

% Fin du programme
disp('*********************************************************');
disp('********************* FIN DU SUIVI **********************');
disp('*********************************************************');
disp(' ');

%% Nombres de particules : 50
disp('Suivi... ');
nbParticules = 50;
suiviFP ( video, nbParticules);
disp('Fin... ');
disp(' ');

%% Nombres de particules : 100
disp('Suivi... ');
nbParticules = 100;
suiviFP ( video, nbParticules);
disp('Fin... ');
disp(' ');

%% Nombres de particules : 200
disp('Suivi... ');
nbParticules = 200;
suiviFP ( video, nbParticules);
disp('Fin... ');
disp(' ');

%% Nombres de particules : 300
disp('Suivi... ');
nbParticules = 300;
suiviFP ( video, nbParticules);
disp('Fin... ');
disp(' ');


% Fin du programme
disp('*********************************************************');
disp('********************* FIN DU SUIVI **********************');
disp('*********************************************************');
disp(' ');