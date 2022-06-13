OS=$(		uname -srvmo)

CPU=$(		cat /proc/cpuinfo | grep -w 'physical id' | wc -l)

VCPU=$(		cat /proc/cpuinfo | grep -w processor | wc -l)

RAM=$(		free -h --mega | awk 'NR==2{print$3"B/"$2"B ("$3/$2*100"%)"}')

DISK=$(		df -h --total | awk 'END{print$3"B/"$2"B ("$5")"}')

CPU_LOAD=$(	top -bn1 | grep '%Cpu(s):' | awk '{
		if ($8!="id,")
			print100-$8"%";
		if ($8=="id,")
			print"0%"; }')

BOOT=$(		who -b | awk '{print$3" at "$4}')

LVM=$(		if [[ $(lsblk | grep -w lvm) ]];
		then		
			echo yes;
		else	
			echo no;
		fi)

CONNECTIONS=$(	netstat -nat | grep -w ESTABLISHED | wc -l)

USERS=$(	who | wc -l)

IP=$(		ifconfig | awk 'NR==2{print$2}')
MAC=$(		ifconfig | awk 'NR==4{print$2}')

SUDO=$(		grep -w COMMAND /var/log/sudo/sudo.log | wc -l)

wall "	____________________________________________________________________________________________
   B
   O	OS:		$OS
   R	Physical CPUs:	$CPU
   N	Virtual CPUs:	$VCPU
	RAM Usage:	$RAM
   2	Disk usage:	$DISK
	CPU usage:	$CPU_LOAD
   B	Last reboot:	$BOOT
   E	LVM status:	$LVM
	Connections:	$CONNECTIONS
   R	Logged user(s):	$USERS
   O	Network info:	$IP ($MAC)
   O	Sudo commands:	$SUDO
   T	____________________________________________________________________________________________
"
