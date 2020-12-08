Start kann folgendes Script verwendet werden:
#!/bin/bash
#IP or If ? 
#sudo ip addr add dev eth1 $ipAdress
# Terminal-Inhalt löschen, für bessere Übersicht
clear -x

#Network-Configuration
echo "IpAdress is 192.168.33.100+Seatnumber for i.: 192.168.33.103"
read -p "Enter IpAdress: " ipAdress
read -p "Enter netmask: " netmask
echo "Setting IpAdress and Netmask to eth0"
ifconfig eth0 $ipAdress netmask $netmask

#Check Config
echo "Check Config"
echo 
read -p "Enter IpAdress of neighbour: " ipAdressNeighbour


if ["`ping -c 1 $ipAdressNeighbour`"]
then 

# Kommentar: Ursprüngliche Konfig ausgeben, falls sie nochmals benötigt wird.
echo "--> Old Config"
sudo iptables -L
echo "---------------------------"

# Alten Zustand löschen, damit keine unvorgesehenen Effekt auftreten
echo "--> Delete Iptables"
sudo iptables -F
sudo iptables -L
echo "---------------------------"

# Ab hier werden die neuen Regeln definiert
# Alle eingehenden UPD-Pakete verwerfen
sudo iptables -A INPUT -p udp -j REJECT

# Alle eingehenden TCP-Pakete verwerfen
sudo iptables -A INPUT -p tcp -j REJECT

# ... weitere Regeln
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!"
# Endzustand nochmal ausgeben
echo "--> NEUE Konfiguration"
sudo iptables -L

else 
echo "IP not reachable! Check Configuration.."
fi