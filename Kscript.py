import os
import requests
import moviepy
from moviepy import *

script_dir = os.path.dirname(os.path.abspath(__file__))
print(script_dir)

# Créer dossier (s'il n'existe pas) pour sauvegarder les images
dossier_images = os.path.join(script_dir, "images_picsum")
if os.path.exists(dossier_images) == False :
    os.makedirs(dossier_images)

# Créer dossier (s'il n'existe pas) pour sauvegarder les images
dossier_audio = os.path.join(script_dir, "Audio_proj")
if os.path.exists(dossier_audio) == False :
    os.makedirs(dossier_audio)

# Créer dossier (s'il n'existe pas) pour sauvegarder les images
dossier_diapo = os.path.join(script_dir, "Diapo_proj")
if os.path.exists(dossier_diapo) == False :
    os.makedirs(dossier_diapo)

# Demander à l'utilisateur le nombre d'images souhaité
nbImages = input("Combien voulez-vous d'images ? ")


# Télécharger le nombre d'images aléatoires souhaité
for i in range(1, int(nbImages) + 1):
    # créer l'URL
    url = "https://picsum.photos/800/600?random=" + str(i)
    try:
        response = requests.get(url, stream=True)
        if response.status_code == 200:
            # créer le path d'accès à chaque image
            path_image = os.path.join(dossier_images, "image_" + str(i) + ".jpg")
            # ouvrir le fichier en binaire
            fichier = open(path_image, 'wb')
            # écrire la contenu du retour de la requête
            fichier.write(response.content)
            # fermer le fichier
            fichier.close()
            # témoin de sauvegarde dans la console
            print("Image", str(i), "sauvegardée avec succès !")
    except Exception as e:
        print("Erreur pour l'image", str(i), ":", str(e))


# path_fdiapo = os.path.join(dossier_images)
# path_fdiapo = os.path.join(dossier_audio)
# path_fdiapo = os.path.join(dossier_audio)

# --- À COLLER À PARTIR DE LA LIGNE 53 ---
nbSeconde = input("Combien voulez-vous que l'image dure ? ")
clips = []

# On récupère les images présentes
liste_fichiers_images = [f for f in os.listdir(dossier_images) if f.endswith(".jpg")]

if not liste_fichiers_images:
    print("ERREUR : Aucune image trouvée dans le dossier images_picsum !")
else:
    for nom_img in liste_fichiers_images:
        chemin_image = os.path.join(dossier_images, nom_img)
        # Attention à l'indentation ici (décalage vers la droite)
        clip = ImageClip(chemin_image).with_duration(int(nbSeconde))
        clips.append(clip)

    if clips:
        diaporama = concatenate_videoclips(clips)

        # Recherche de l'audio (tous formats)
        fichiers_audio = [f for f in os.listdir(dossier_audio) if f.lower().endswith((".mp3", ".wav", ".m4a", ".aac"))]
        
        if fichiers_audio:
            chemin_musique = os.path.join(dossier_audio, fichiers_audio[0])
            print(f"Musique détectée et ajoutée : {fichiers_audio[0]}")
            musique = AudioFileClip(chemin_musique)
            musique = musique.with_duration(diaporama.duration)
            diaporama = diaporama.with_audio(musique)
        else:
            print("AVERTISSEMENT : Pas de musique trouvée dans Audio_proj.")

        # Exportation
        print("Création de la vidéo en cours...")
        diaporama.write_videofile(os.path.join(script_dir, "mon_diaporama.mp4"), fps=24)
        print("TERMINÉ ! Le fichier 'mon_diaporama.mp4' est dans votre dossier.")