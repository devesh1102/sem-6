; Creating p-type bulk
(sdegeo:create-rectangle (position -0.010 0.0 0.0) (position 0.040 -0.100 0.0) "Silicon" "SubsSilicon")

; Creating insulating gateoxide region
(sdegeo:create-rectangle (position 0.0 -0.100 0.0) (position 0.030 -0.102 0.0) "SiO2" "GateOxide")

;Creating polysilicon gate
(sdegeo:create-rectangle (position 0.002 -0.102 0.0) (position 0.028 -0.114 0.0) "PolySi" "PolyGate")

;----------------------------------------------------------------------

;Poly reoxidation

(sdegeo:set-default-boolean "BAB")
(sdegeo:create-rectangle (position 0 -0.102 0) (position 0.030 -0.114 0) "SiO2" "PolyReOxide1")

;----------------------------------------------------------------------

;Creating nitride spacers
;(sdegeo:create-rectangle (position -0.003 -0.100 0.0) (position 0.0 -0.114 0.0) "Si3N4" "NiSpacer")

;(sdegeo:create-rectangle (position 0.030 -0.100 0.0) (position 0.033 -0.114 0.0) "Si3N4" "NiSpacer")

;----------------------------------------------------------------------
; Contact declarations

(sdegeo:define-contact-set "gate" 
  4.0  (color:rgb 0.0 1.0 1.0 ) "##")

(sdegeo:define-contact-set "substrate" 
  4.0  (color:rgb 1.0 0.0 0.0 ) "##")

(sdegeo:define-contact-set "source" 
  4.0  (color:rgb 0.0 0.0 1.0 ) "||")

(sdegeo:define-contact-set "drain" 
  4.0  (color:rgb 0.0 1.0 0.0 ) "||")
;----------------------------------------------------------------------
; Contact settings

(sdegeo:set-current-contact-set "gate")
(sdegeo:set-contact-edges (list (car (find-edge-id (position 0.015 -0.114 0)))) "gate")

(sdegeo:set-current-contact-set "substrate")
(sdegeo:set-contact-edges (list (car (find-edge-id (position 0.015 0 0)))) "substrate")

(sdegeo:set-current-contact-set "drain")
(sdegeo:set-contact-edges (list (car (find-edge-id (position -0.0065 -0.1 0)))) "drain")

(sdegeo:set-current-contact-set "source")
(sdegeo:set-contact-edges (list (car (find-edge-id (position 0.0365 -0.1 0)))) "source")

;----------------------------------------------------------------------
; Profiles:

;bulk
(sdedr:define-constant-profile "Const.Bulk" "BoronActiveConcentration" 1e18)
(sdedr:define-constant-profile-region "PlaceCD.Bulk" "Const.Bulk" "SubsSilicon")

;poly_gate
(sdedr:define-constant-profile "Const.Poly" "ArsenicActiveConcentration" 1e+22)
(sdedr:define-constant-profile-region "PlaceCD.Poly" "Const.Poly" "PolyGate")

;----------------------------------------------------------------------
;Defining Analytic Doping Profiles

(sdedr:define-refinement-window "BaseLine.Drain" "Rectangle" (position  0.001 -0.095 0.0)  (position -0.010 -0.100 0.0) )

(sdedr:define-refinement-window "BaseLine.Source" "Rectangle" (position  0.029 -0.095 0.0)  (position 0.040 -0.100 0.0) )


(sdedr:define-analytical-profile-placement "PlaceAP.Source" "Gauss.SourceDrain" "BaseLine.Source" "Both" "NoReplace" "Eval")

(sdedr:define-gaussian-profile "Gauss.SourceDrain" "ArsenicActiveConcentration" "PeakPos" 0  "PeakVal" 1e19 "ValueAtDepth" 1e17 "Depth" 0.005 "Gauss"  "Factor" 0.8)


(sdedr:define-analytical-profile-placement "PlaceAP.Drain" "Gauss.SourceDrain" "BaseLine.Drain" "Both" "NoReplace" "Eval")

(sdedr:define-gaussian-profile "Gauss.SourceDrain" "ArsenicActiveConcentration" "PeakPos" 0  "PeakVal" 1e19 "ValueAtDepth" 1e17 "Depth" 0.005 "Gauss"  "Factor" 0.8)


;----------------------------------------------------------------------
; Meshing Strategy:

; total

(sdedr:define-refeval-window "RefWin.Global" "Rectangle" (position -0.010 0.0 0.0) (position 0.040 -0.114 0))

(sdedr:define-refinement-size "RefDef.Global" 0.010 0.010 0.005 0.005  1 1)

(sdedr:define-refinement-placement "Place.Global" "RefDef.Global" "RefWin.Global" )



(sdedr:define-refeval-window "RefWin.Active" "Rectangle" (position -0.010 -0.070 0.0) (position 0.040 -0.100 0))

(sdedr:define-refinement-size "RefDef.Active" 0.002 0.002 0.001 0.001 1 1)

(sdedr:define-refinement-placement "Place.Active" "RefDef.Active" "RefWin.Active" )


(sdedr:define-refinement-window "RefWin.Channel" "Rectangle" (position -0.010 -0.090 0) (position 0.040 -0.114 0))

(sdedr:define-multibox-size "RefDefMB.Channel" 0.001 0.001 0.0005 0.0005 1 1)

(sdedr:define-multibox-placement "PlaceBM.Channel" "RefDefMB.Channel" "RefWin.Channel" )


;----------------------------------------------------------------------
;Saving msh.tdr file

(sde:build-mesh "snmesh" "" "nmos_msh")
