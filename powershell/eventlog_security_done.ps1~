$date = Get-Date
$date.AddDays(-30)
$date = $date.ToShortDateString()
#$date_tmp = $date.AddDays(-30)
#$date = $date_tmp -f "mm/dd/yyyy"
Write-Host "Система: 1-СМА, 2-ИСУР, 3-ЦХЭД, 4 - ИСУР ВП"
$system = Read-Host
Switch($system){
1 {$connections = Get-Content D:\Scripts\sma.txt 
   $system = "СМА"}
2 {$connections = Get-Content D:\Scripts\isur.txt 
   $system = "ИСУР"}
3 {$connections = Get-Content D:\Scripts\ched.txt 
   $system = "ЦХЭД"}
4 {$connections = Get-Content D:\Scripts\isurvp.txt 
   $system = "ИСУР_ВП"}
}
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $true
$workbook = $excel.Workbooks.Add()
foreach($con in $connections){
    Write-Host "Введите пароль для сервера "$con
    $log = Invoke-Command -ComputerName $con -ScriptBlock{Get-EventLog -LogName Security | Where-Object {($_.EventID -eq 4624) -and (($_.ReplacementStrings[8] -eq 2) -or ($_.ReplacementStrings[8] -eq 10)) -and ($_.TimeGenerated -ge "02/20/2016")}} -Credential pasport.local\Administrator   
    $sheet = $workbook.Worksheets.Add()
    $sheet.Name = $con
    $counter = 0
    $log | ForEach-Object{$counter++
        $sheet.cells.Item($counter,1) = $_.replacementstrings[11]
        $sheet.cells.Item($counter,2) = $_.replacementstrings[5]
        $sheet.cells.Item($counter,3) = $_.replacementstrings[18]
        $sheet.cells.Item($counter,4) = $_.timegenerated
    }
}
$filename = "D:\Security_"+$system+"_"+$date+".xlsx"
$excel.ActiveWorkbook.SaveAs($filename)
$excel.Quit()
