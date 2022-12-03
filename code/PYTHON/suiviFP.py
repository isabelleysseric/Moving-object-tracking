# Isabelle EYSSERIC
# Version Matlab : R2019a
# Systeme d'exploitation : Windows 10


import numpy as np
import matplotlib.pyplot as plt
    
def suiviFP(video = None,nbParticules = None): 
    # Suivre un objet en mouvement avec le filtre de particules
# function suiviFP( video, nbParticules )
# ****************************************************************
# Auteur: Isabelle EYSSERIC
# Paramètres:
#   video: nom de la vidéo sous format string
#   nbParticules: nombre de particules à utiliser pour le suivi
# ****************************************************************
    
    ## CHARGEMENT DU FICHIER
    videoFile = vision.VideoFileReader(video)
    videoPlayer = vision.VideoPlayer()
    
    resolution = videoFile.info.VideoSize
    
    # Nombre de trames
    count = 0
    while not isDone(videoFile) :

        videoFrame = videoFile()
        count = count + 1

    
    nbFrame = count
    release(videoFile)
    
    ## MODELE D'APPARENCE BASÉ SUR LA COULEUR
# Modèle d'apparence par noyau sans connaissance à priori utilisant
# l'histogramme de couleurs
    
    # Première trame et fenêtre
    videoFile = vision.VideoFileReader('wdesk.avi')
    objectFrame = step(videoFile)
    
    objectHSV = rgb2hsv(objectFrame)
    
    objectRegion = np.array([80,20,75,100])
    # Détermine la région de la fenêtre
    region = insertShape(objectFrame,'rectangle',objectRegion,'LineWidth',4,'Color','red')
    figure
    imshow(region)
    plt.title('Cadre de la région cible')
    # Suivi avec Histogramme de couleur
    HBtracker = vision.HistogramBasedTracker
    initializeObject(HBtracker,objectHSV(:,:,1),objectRegion,64)
    ## MODÈLE DE MOUVEMENT PROBABILISTE
# Modèle en mouvement probabiliste utilisant le filtre à particules
    
    # Parameters des particules
    F_update = np.array([[1,0,1,0],[0,1,0,1],[0,0,1,0],[0,0,0,1]])
    # En fonction nombre de bin par couleur, de la position entre elles
# et du regroupement:
    Xrgb = 50
    Xpos = 10
    Xvec = 5
    Xreg = np.array([[255],[0],[0]])
    
    # Générer des nombres aléatoires
    X1 = randi(resolution(2),1,nbParticules)
    X2 = randi(resolution(1),1,nbParticules)
    X3 = np.zeros((2,nbParticules))
    X = np.array([[X1],[X2],[X3]])
    videoFile = VideoReader('wdesk.avi')
    for k in np.arange(1,nbFrame+1).reshape(-1):
        # L'image courante
        frame = read(videoFile,k)
        hsv = rgb2hsv(frame)
        bbox = HBtracker(objectHSV(:,:,1))
        # Variables communes
        N = X.shape[2-1]
        X = F_update * X
        # Générer un nombre aléatoire
        X[np.arange[1,2+1],:] = X(np.arange(1,2+1),:) + Xpos * np.random.randn(2,N)
        X[np.arange[3,4+1],:] = X(np.arange(3,4+1),:) + Xvec * np.random.randn(2,N)
        # Trouver la particule avec la plus petite valeurs sur la trame
# Calcul du log de vraissemblance
        L = np.zeros((1,X.shape[2-1]))
        framePerm = permute(frame,np.array([3,1,2]))
        XX = np.round(X(np.arange(1,2+1),:))
        for i in np.arange(1,N+1).reshape(-1):
            if (XX(1,i) >= np.logical_and(1,XX(1,i)) <= frame.shape[1-1]) and (XX(2,i) >= np.logical_and(1,XX(2,i)) <= frame.shape[2-1]):
                D = double(framePerm(:,XX(1,i),XX(2,i))) - Xreg
                L[i] = - np.log(np.sqrt(2 * np.pi) * Xrgb) + - 0.5 / (Xrgb ** 2) * np.transpose(D) * D
            else:
                L[i] = - Inf
        # Calcul de la distribution cumulative
        R = cumsum(np.exp(L - np.amax(L)) / np.sum(np.exp(L - np.amax(L)), 2-1),2)
        # Générer une nouvelle particule pour celle sélectionée
        T = np.random.rand(1,X.shape[2-1])
        # Déterminer le poids de cette nouvelle particule
        __,I = histc(T,R)
        X = X(:,I + 1)
        # Affiche latrame
        plt.figure(2)
        imshow(frame)
        plt.title('Suivi d'objets en mouvement')
        hold('on')
        plt.plot(X(2,:),X(1,:),'.','Color','w')
        hold('off')
        drawnow
    
    close_('all')
    return
    
