% Isabelle EYSSERIC
% Version Matlab : R2019a
% Systeme d'exploitation : Windows 10


function suiviFP ( video, nbParticules )
% Suivre un objet en mouvement avec le filtre de particules
% function suiviFP( video, nbParticules )
% ****************************************************************            
% Auteur: Isabelle EYSSERIC        
% Paramètres: 
%   video: nom de la vidéo sous format string 
%   nbParticules: nombre de particules à utiliser pour le suivi
% ****************************************************************

    %% CHARGEMENT DU FICHIER
    videoFile   = vision.VideoFileReader(video);
    videoPlayer = vision.VideoPlayer();      % Initialise le lecteur
    resolution  = videoFile.info.VideoSize;  % Récupère hauteur et largeur

    % Nombre de trames
    count = 0;
    while ~isDone(videoFile)
          videoFrame = videoFile(); % Lit chaque trame
          count = count+1;          % Compte le nombre de trame
    end
    nbFrame = count;
    release(videoFile);             % Libère

    
    %% MODELE D'APPARENCE BASÉ SUR LA COULEUR
    % Modèle d'apparence par noyau sans connaissance à priori utilisant 
    % l'histogramme de couleurs 

    % Première trame et fenêtre
    videoFile = vision.VideoFileReader('wdesk.avi');
    objectFrame  = step(videoFile);         % Première trame
    objectHSV    = rgb2hsv(objectFrame);    % Convertit en HSV
    objectRegion = [80,20,75,100];
    
    % Détermine la région de la fenêtre
    region = insertShape( objectFrame, ...
                          'rectangle',objectRegion,...
                          'LineWidth',4,'Color','red');
    figure; imshow(region);title('Cadre de la région cible');
    
    % Suivi avec Histogramme de couleur 
    HBtracker = vision.HistogramBasedTracker;                       
    initializeObject(HBtracker,objectHSV(:,:,1),objectRegion, 64); 

    
    %% MODÈLE DE MOUVEMENT PROBABILISTE
    % Modèle en mouvement probabiliste utilisant le filtre à particules

    % Parameters des particules
    F_update = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
    
    % En fonction nombre de bin par couleur, de la position entre elles 
    % et du regroupement:
    Xrgb = 50; Xpos = 10; Xvec = 5;
    Xreg = [255;0;0];   % Couleur de peau à détecter

    % Générer des nombres aléatoires
    X1 = randi(resolution(2), 1, nbParticules);
    X2 = randi(resolution(1), 1, nbParticules);
    X3 = zeros(2, nbParticules);
    X = [X1; X2; X3];

    videoFile = VideoReader('wdesk.avi'); 

    for k = 1:nbFrame

        % L'image courante 
        frame = read(videoFile, k);         % Lit une trame à la fois
        hsv = rgb2hsv(frame);               % Convertit en HSV
        bbox = HBtracker(objectHSV(:,:,1)); % Suivi par histogramme couleur

        % Variables communes
        N = size(X, 2); X = F_update * X;
        
        % Générer un nombre aléatoire
        X(1:2,:) = X(1:2,:) + Xpos * randn(2, N);
        X(3:4,:) = X(3:4,:) + Xvec * randn(2, N);
        
        % Trouver la particule avec la plus petite valeurs sur la trame
        % Calcul du log de vraissemblance
        L = zeros(1,size(X,2));
        framePerm = permute(frame, [3 1 2]);
        XX = round(X(1:2, :));
        
        for i = 1:N
            if (XX(1,i) >= 1 & XX(1,i) <= size(frame, 1)) && ...
               (XX(2,i) >= 1 & XX(2,i) <= size(frame, 2))
                D =  double( framePerm( : , XX(1,i) , XX(2,i)) ) - Xreg;       
                L(i) =  -log(sqrt(2 * pi) * Xrgb) + ...
                        - 0.5 / (Xrgb.^2) * D' * D;
            else        
                L(i) = -Inf;
            end
        end   
        
        % Calcul de la distribution cumulative
        R = cumsum(exp(L - max(L)) / sum(exp(L - max(L)), 2), 2);
        
        % Générer une nouvelle particule pour celle sélectionée
        T = rand(1, size(X, 2));
        
        % Déterminer le poids de cette nouvelle particule
        [~, I] = histc(T, R); X = X(:, I + 1);

        % Affiche latrame
        figure(2); imshow(frame); title( 'Suivi d''objets en mouvement');
        hold on; plot(X(2,:), X(1,:), '.', 'Color', 'w'); hold off;
        drawnow

    end
    
    close all;  
    
end

