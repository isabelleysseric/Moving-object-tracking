# Isabelle EYSSERIC
# Version Matlab : R2019a
# Systeme d'exploitation : Windows 10



## Nettoyage de l'espace de travail
close_('all')
clear('all')
## Declaration des variables
video = 'wdesk.avi'
nbParticules = 500
# Début du programme
print('*********************************************************')
print('***************** DÉBUT DU PROGRAMME ********************')
print('************ Suivi d'objets en mouvement ***************')
print('*********************************************************')
print(' ')
# Appel de fonction
print('Suivi... ')
suiviFP(video,nbParticules)
print('Fin... ')
print(' ')
# Fin du programme
print('*********************************************************')
print('********************* FIN DU SUIVI **********************')
print('*********************************************************')
print(' ')
## Nombres de particules : 50
print('Suivi... ')
nbParticules = 50
suiviFP(video,nbParticules)
print('Fin... ')
print(' ')
## Nombres de particules : 100
print('Suivi... ')
nbParticules = 100
suiviFP(video,nbParticules)
print('Fin... ')
print(' ')
## Nombres de particules : 200
print('Suivi... ')
nbParticules = 200
suiviFP(video,nbParticules)
print('Fin... ')
print(' ')
## Nombres de particules : 300
print('Suivi... ')
nbParticules = 300
suiviFP(video,nbParticules)
print('Fin... ')
print(' ')
# Fin du programme
print('*********************************************************')
print('********************* FIN DU SUIVI **********************')
print('*********************************************************')
print(' ')