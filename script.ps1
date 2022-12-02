function ServiceStatus{

$servers ='localhost','192.168.234.137'
$services = 'WinRM','BFE','WinDefend','WLMS','Kdc'
foreach($server in $servers){

Write-Host "----------------Serveur",$server,"-----------------------"
foreach($service in $services){
$dateStop = get-date
  
  if(get-service -Name $service -ComputerName $server -ErrorAction Ignore ){
   $Servicestatus = (get-service -Name $service -ComputerName $server).Status 
   $ServiceName = (get-service -Name $service -ComputerName $server).Name
      if($Servicestatus -eq "Stopped"){
        Write-Host "$ServiceName is $Servicestatus at $dateStop"
        #Send-MailMessage -To "mamourou" -from "@1" -SmtpServer local.host -Subject "$server : the service $ServiceName is $Servicestatus at $dateStop" -Body($ServiceName,$Servicestatus)
        get-service -Name $service -ComputerName $server | Restart-Service
        Start-Sleep -Seconds 10
        $dateStart = get-date
        Write-Host "$ServiceName has been restarted at $dateStart"
       # Send-MailMessage -To "mamourou" -from "@1" -SmtpServer local.host -Subject "$server : the service $ServiceName has been started $Servicestatus at $dateStart" -Body($ServiceName,$Servicestatus)
  
      }
      else 
      { 
         write-host $service,"is Running"
      }
    }
    else{ Write-Host $service,"introuvable in ",$server} 

}
}
}
ServiceStatusLa première version de mon script
