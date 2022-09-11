//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_init
// Database: 4D Report
// ID[88A2D0B42B214AD2B75BC53A01922DE3]
// Created #24-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Initialisation of the 'nqr' module
// ----------------------------------------------------
// Declarations
var $fontFamily; $t; $template : Text
var $backgroundColor; $foregroundColor : Integer

// ----------------------------------------------------
// Mark:Initialisations

Form:C1466.areaObject:="nqr"
Form:C1466.debug:=Not:C34(Is compiled mode:C492)
Form:C1466.headerHeight:=30
Form:C1466.headerButtonOffset:=8  // Margin for the shortcut button in the header
Form:C1466.headerButtonWidth:=23  // Width of the shortcut button in the header
Form:C1466.addSensitive:=15  // 1/2 width of the sensitive area to display the Add button
Form:C1466.defaultColumWidth:=128  // Width for automatic size
Form:C1466.defaultRowHeight:=30
Form:C1466.selectedBackgroundColor:=Highlight menu background color:K23:7
Form:C1466.selectedForegroundColor:=Highlight text color:K23:6

OBJECT GET RGB COLORS:C1074(*; "headerBackgroundFiller"; $foregroundColor; $backgroundColor)
Form:C1466.headerBackgroundColor:=$backgroundColor

Form:C1466.timerEvent:=0

// ----------------------------------------------------
// Mark:Load structure definition and virtual structure
db_INIT_STRUCTURE

// Mark:Labels for automatic calculations
$template:="<span style=\"font-family:'"
$template+=Choose:C955(Is Windows:C1573; "Segoe UI"; "Lucida Grande")
$template+="';font-size:{size};font-weight:{weight};font-style:normal;text-decoration:none;color:{color}\">{value} </span>"

Form:C1466.dataStyled:=New collection:C1472

//------------------------- SUM -------------------------
$t:=Replace string:C233($template; "{size}"; Choose:C955(Is Windows:C1573; "16"; "18"))
$t:=Replace string:C233($t; "{weight}"; "normal")
$t:=Replace string:C233($t; "{color}"; "red")
$t:=Replace string:C233($t; "{value}"; Char:C90(0x2211))

Form:C1466.dataStyled.push($t)

//---------------------- AVERAGE ----------------------
$t:=Replace string:C233($template; "{size}"; "18")
$t:=Replace string:C233($t; "{weight}"; "normal")
$t:=Replace string:C233($t; "{color}"; "blue")
$t:=Replace string:C233($t; "{value}"; "n"+Char:C90(0x0305))

Form:C1466.dataStyled.push($t)

//------------------------ MIN ------------------------
$t:=Replace string:C233($template; "{size}"; "18")
$t:=Replace string:C233($t; "{weight}"; "bold")
$t:=Replace string:C233($t; "{color}"; "orange")
$t:=Replace string:C233($t; "{value}"; "&lt;")

Form:C1466.dataStyled.push($t)

//------------------------ MAX ------------------------
$t:=Replace string:C233($template; "{size}"; "18")
$t:=Replace string:C233($t; "{weight}"; "bold")
$t:=Replace string:C233($t; "{color}"; "orange")
$t:=Replace string:C233($t; "{value}"; "&gt;")

Form:C1466.dataStyled.push($t)

//------------------------ COUNT ------------------------
$t:=Replace string:C233($template; "{size}"; Choose:C955(Is Windows:C1573; "16"; "18"))
$t:=Replace string:C233($t; "{weight}"; "bold")
$t:=Replace string:C233($t; "{color}"; "blue")
$t:=Replace string:C233($t; "{value}"; "N")

Form:C1466.dataStyled.push($t)

//----------------- STANDARD DEVIATION ------------------
$t:=Replace string:C233($template; "{size}"; "18")
$t:=Replace string:C233($t; "{weight}"; "normal")
$t:=Replace string:C233($t; "{color}"; "red")
$t:=Replace string:C233($t; "{value}"; Char:C90(0x03C3))

Form:C1466.dataStyled.push($t)

// Mark:Tags for automatic calculations
Form:C1466.dataTags:=New collection:C1472

Form:C1466.dataTags.push("##S")
Form:C1466.dataTags.push("##A")
Form:C1466.dataTags.push("##N")
Form:C1466.dataTags.push("##X")
Form:C1466.dataTags.push("##C")
Form:C1466.dataTags.push("##D")


// Mark:Labels for automatic calculations
Form:C1466.dataLabels:=New collection:C1472

$template:="<span style='font-weight: normal;text-decoration:none'> </span>"

Form:C1466.dataLabels.push($template+Get localized string:C991("nqr_sum")+"\r")
Form:C1466.dataLabels.push($template+Get localized string:C991("nqr_average")+"\r")
Form:C1466.dataLabels.push($template+Get localized string:C991("nqr_min")+"\r")
Form:C1466.dataLabels.push($template+Get localized string:C991("nqr_max")+"\r")
Form:C1466.dataLabels.push($template+Get localized string:C991("nqr_count")+"\r")
Form:C1466.dataLabels.push($template+Get localized string:C991("nqr_standard_deviation")+"\r")