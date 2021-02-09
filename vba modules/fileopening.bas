Attribute VB_Name = "Module1"
Dim time As String
Dim year As String
Dim InScenario As String
Dim OutScenario As String
Sub import()

    Application.DisplayAlerts = False
    Application.ScreenUpdating = False
    Application.Calculation = xlManual

' setting up arrays

    tps = Array("AM", "IP", "PM")
    scens = Array("base", "DM", "DS")
    modyears = Array("2028", "2043", "2058")
    
    Dim endRow() As Integer
    ReDim endRow((UBound(scens)) * (UBound(modyears) + 1))
    
    strRow = 13
    
' clearing data in sheets
    
    For i = LBound(scens) To UBound(scens)
        If scens(i) = "base" Then
            For k = LBound(tps) To UBound(tps)
                Call Clear_data(scens(i), "NA", tps(k))
            Next k
        Else
            For j = LBound(modyears) To UBound(modyears)
                For k = LBound(tps) To UBound(tps)
                    Call Clear_data(scens(i), modyears(j), tps(k))
                Next k
            Next j
        End If
    Next i
    
    Application.StatusBar = "Data Cleared"

' Importing data from Saturn output

    For i = LBound(scens) To UBound(scens)
        If scens(i) = "base" Then
            For k = LBound(tps) To UBound(tps)
                Application.StatusBar = scens(i) & ": " & tps(k)
                endRowInd = 0
                Call Import_cobalt_data(scens(i), "NA", tps(k), strRow, endRow(endRowInd))
            Next k
        
        Else
            For j = LBound(modyears) To UBound(modyears)
                For k = LBound(tps) To UBound(tps)
                    Application.StatusBar = scens(i) & ": " & modyears(j) & ": " & tps(k)
                    endRowInd = 3 * (i - 1) + j + 1
                    Call Import_cobalt_data(scens(i), modyears(j), tps(k), strRow, endRow(endRowInd))
                Next k
            Next j
        End If
    Next i
    
' clearing AADT nodes

    Application.StatusBar = "Updating AADT nodes"

    For i = LBound(scens) To UBound(scens)
        If scens(i) = "base" Then
            AADTName = scens(i) + "_AADT"
            Worksheets(AADTName).Activate
            Columns("C:E").Select
            Selection.ClearContents
        Else
            For j = LBound(modyears) To UBound(modyears)
                AADTName = Right(modyears(j), 2) & "_" & scens(i) + "_AADT"
                Worksheets(AADTName).Activate
                Columns("C:E").Select
                Selection.ClearContents
            Next j
        End If
    Next i
    
' copying and pasting AM nodes to AADT
    pasteCell = "C4"
    endRowInd = 0
    For i = LBound(scens) To UBound(scens)
        If scens(i) = "base" Then
            AMName = scens(i) + "_AM"
            AADTName = scens(i) + "_AADT"
            Worksheets(AMName).Activate
            Range(Cells(strRow, 3), Cells(endRow(endRowInd), 5)).Copy
            Worksheets(AADTName).Activate
            Range(pasteCell).Select
            ActiveSheet.Paste
        Else
            For j = LBound(modyears) To UBound(modyears)
                AMName = Right(modyears(j), 2) & "_" & scens(i) + "_AM"
                AADTName = Right(modyears(j), 2) & "_" & scens(i) + "_AADT"
                Worksheets(AMName).Activate
                Range(Cells(strRow, 3), Cells(endRow(endRowInd), 5)).Copy
                Worksheets(AADTName).Activate
                Range(pasteCell).Select
                ActiveSheet.Paste
            Next j
        End If
        endRowInd = endRowInd + 1
    Next i
    
    Application.DisplayAlerts = True
    Application.ScreenUpdating = True
    Application.Calculation = xlAutomatic

End Sub

Sub Import_cobalt_data(scen, modyear, tp, strRow, endRow)

' setting directory and filename

    Dim DataLine As String
    
' opening file
    
    fname = tp & "_" & scen & "_PMB.TXT"
    fname = "AM_DM_PMB.TXT"
    baseDir = ActiveWorkbook.Path
    If scen = "base" Then
        scenDir = baseDir & "\" & scen & "\" & tp & "\"
    Else
        scenDir = baseDir & "\" & scen & "\" & modyear & "\" & tp & "\"
    End If
    fullfname = scenDir & fname
    
    FileNum = FreeFile()
    Open fullfname For Input As #FileNum
    
' selecting sheet

    If scen = "base" Then
        shtName = scen + "_" + tp
    Else
        shtName = Right(modyear, 2) + "_" + scen + "_" + tp
    End If
    Worksheets(shtName).Activate
    
' inserting data

' column numbers
    colNode1 = 3
    colNode2 = 5
    colDist = 8
    colCapInd = 9
    colCap = 10
    colActF = 11
    colFFS = 12
    colLanes = 13
    colTWAF = 14
    colCobaL = 15
    
    endRow = strRow
    While Not EOF(FileNum)
        Line Input #FileNum, DataLine
        If Left(DataLine, 1) <> "*" Then
            lineArr = MySplitFunction(DataLine)
            Cells(endRow, colNode1).Value = lineArr(0)
            Cells(endRow, colNode2).Value = lineArr(1)
            Cells(endRow, colDist).Value = lineArr(2)
            Cells(endRow, colCapInd).Value = lineArr(3)
            Cells(endRow, colCap).Value = lineArr(4)
            Cells(endRow, colActF).Value = lineArr(5)
            Cells(endRow, colFFS).Value = lineArr(6)
            Cells(endRow, colLanes).Value = lineArr(7)
            Cells(endRow, colTWAF).Value = lineArr(8)
            Cells(endRow, colCobaL).Value = lineArr(9)
            endRow = endRow + 1
        End If
    Wend
    
End Sub
Public Function MySplitFunction(sMark As String) As Variant
' regex to remove multiple spaces and replace with one space
    Dim objRegExp As Object
    Set objRegExp = CreateObject("vbscript.regexp")

    Dim tmpTXT As String
    Dim tmpArr As Variant
    With objRegExp
        .Global = True
        .Pattern = "\s+"
        tmpTXT = .Replace(sMark, " ")
    End With
    MySplitFunction = Split(Trim(tmpTXT), " ")
End Function
Sub Clear_data(scen, modyear, tp)
    If scen = "base" Then
        shtName = scen + "_" + tp
    Else
        shtName = Right(modyear, 2) + "_" + scen + "_" + tp
    End If
    Worksheets(shtName).Activate
    Columns("C:O").Select
    Selection.ClearContents
End Sub
