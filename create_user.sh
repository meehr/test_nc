#!/bin/bash

# Liste der Benutzernamen
users=("Martin" "Brian" "Simon" "Oskar" "Markus")

# Verzeichnis für SSH-Schlüssel
ssh_dir="/root/.ssh"

# Datei für öffentliche Schlüssel
authorized_keys="/root/authorized_keys"

# Funktion zum Erstellen eines Benutzers und eines SSH-Schlüssels
create_user_and_key() {
  user="$1"
  # Benutzer erstellen (passwortlos, bitte anpassen!)
  useradd -m -p "" "$user"
  # SSH-Verzeichnis für den Benutzer erstellen
  mkdir -p "/home/$user/.ssh"
  # SSH-Schlüssel generieren (ohne Passwort)
  ssh-keygen -t rsa -N "" -f "/home/$user/.ssh/id_rsa"
  # Öffentlichen Schlüssel in die authorized_keys Datei schreiben
  cat "/home/$user/.ssh/id_rsa.pub" >> "$authorized_keys"
  # Berechtigungen setzen
  chmod 700 "/home/$user/.ssh"
  chmod 600 "/home/$user/.ssh/id_rsa"
  chmod 644 "/home/$user/.ssh/id_rsa.pub"
}

# Schleife über alle Benutzer
for user in "${users[@]}"; do
  create_user_and_key "$user"
done

# Berechtigungen für authorized_keys setzen
chmod 600 "$authorized_keys"

echo "Benutzer und SSH-Schlüssel erfolgreich erstellt!"
