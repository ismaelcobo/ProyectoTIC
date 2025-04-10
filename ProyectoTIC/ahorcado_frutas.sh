#!/bin/bash

# -----------------------------
# 🍌 Juego del Ahorcado: Frutas
# -----------------------------

# Mostrar "Hola" en arte ASCII usando figlet
clear
figlet Hola
sleep 1

# Mensaje de bienvenida
echo "🍓 ¡Bienvenido al juego del ahorcado de frutas!"
sleep 2
echo "Adivina la fruta secreta, letra por letra 🍍"
sleep 3

# Lista de frutas posibles
frutas=("banana" "manzana" "kiwi" "mango" "limon" "pera" "melon")

# Selección aleatoria de fruta
fruta_secreta=${frutas[$RANDOM % ${#frutas[@]}]}

# Convertir palabra en guiones bajos
palabra_oculta=$(echo "$fruta_secreta" | sed 's/./_/g')

# Variables para controlar fallos y letras usadas
fallos=0
max_fallos=6
letras_usadas=""

# Bucle principal
while [[ "$palabra_oculta" != "$fruta_secreta" && $fallos -lt $max_fallos ]]; do
  clear
  echo "-----------------------------"
  echo "Palabra: $palabra_oculta"
  echo "Fallos: $fallos de $max_fallos"
  echo "Letras usadas: $letras_usadas"
  echo "-----------------------------"
  read -p "Escribe una letra: " letra

  # Validar letra usada
  if [[ "$letras_usadas" == *"$letra"* ]]; then
    echo "⚠️ Ya usaste esa letra. Prueba otra."
    sleep 2
    continue
  fi

  letras_usadas+="$letra "

  # Comprobar si la letra está en la palabra
  if [[ "$fruta_secreta" == *"$letra"* ]]; then
    nueva_palabra=""
    for ((i=0; i<${#fruta_secreta}; i++)); do
      if [[ "${fruta_secreta:$i:1}" == "$letra" ]]; then
        nueva_palabra+="$letra"
      else
        nueva_palabra+="${palabra_oculta:$i:1}"
      fi
    done
    palabra_oculta=$nueva_palabra
  else
    echo "❌ Letra incorrecta."
    ((fallos++))
    sleep 1
  fi
done

# Final del juego
clear
if [[ "$palabra_oculta" == "$fruta_secreta" ]]; then
  echo "🎉 ¡Ganaste! La fruta era '$fruta_secreta'."
else
  echo "💀 Has perdido. La fruta era '$fruta_secreta'."
fi

echo "🍇 ¡Gracias por jugar!"

# Dar permisos de ejecución: chmod +x ahorcado_frutas.sh
# Ejecutar el script: ./ahorcado_frutas.sh o bash ahorcado_frutas.sh

# Instalar fliget: sudo apt update + sudo apt install figlet