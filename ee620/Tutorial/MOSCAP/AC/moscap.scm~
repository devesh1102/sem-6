(sde:clear)
(sdegeo:set-default-boolean "ABA")

; List of independent variables...............

(define   Gate_Length   0.5 )
(define   Silicon_thickness   0.25 )
(define   GateOxide_thickness   0.005 )
(define   start_x   0.000 )
(define   start_y   0.000 )

;================================================================================================================
; Creating Silicon region coordinates.......
(define   Si_x1  (-  start_x  (*  0.5  Gate_Length ) ) )
(define   Si_y1  (-  start_y  (*  0.5  Silicon_thickness ) ) )
(define   Si_x2  (+  start_x  (*  0.5  Gate_Length ) ) )
(define   Si_y2  (+  start_y  (*  0.5  Silicon_thickness ) ) )

;================================================================================================================
; Creating SiO2 region coordinates.......
(define   Oxide_x1  Si_x1 )
(define   Oxide_y1  Si_y1 )
(define   Oxide_x2  Si_x2 )
(define   Oxide_y2  (-  Oxide_y1  GateOxide_thickness ) )

;================================================================================================================
; Creating the bulk
(sdegeo:create-rectangle (position Si_x1 Si_y1 0.0 )  (position Si_x2 Si_y2 0.0 ) "Silicon" "Substrate" )

; Creating the SiO2 region
(sdegeo:create-rectangle (position Oxide_x1 Oxide_y1 0.0 )  (position Oxide_x2 Oxide_y2 0.0 ) "SiO2" "Oxide_region" )

;================================================================================================================
; Contact declarations
(sdegeo:define-contact-set "gate" 4 (color:rgb 1 0 1) "##")
(sdegeo:define-contact-set "bulk" 4 (color:rgb 1 0 0) "##")

;================================================================================================================
; Contact settings
(sdegeo:set-current-contact-set "gate")
(sdegeo:set-contact-edges (list (car (find-edge-id (position  (+  0.005  Oxide_x1 )  Oxide_y2  0.0 )))) "gate")

(sdegeo:set-current-contact-set "bulk")
(sdegeo:set-contact-edges (list (car (find-edge-id (position  (+  0.005  Oxide_x1 )  Si_y2  0.0 )))) "bulk")

;================================================================================================================
; Profiles:
; bulk
(sdedr:define-constant-profile "Const.Substrate" "BoronActiveConcentration" 1e16)
(sdedr:define-constant-profile-region "PlaceCD.Substrate" "Const.Substrate" "Substrate")

;================================================================================================================
; Meshing Strategy
; Global Meshing..........

(sdedr:define-refeval-window "RefWin.Global" "Rectangle" (position  (-  0.01  Oxide_x1)  (-  0.01  Oxide_y2)  0.0) (position  (+  0.005  Si_x2)  (+  0.01  Si_y2)  0.0))
(sdedr:define-refinement-size "RefDef.Global" 0.050 0.050 0.040 0.040  1 1)
(sdedr:define-refinement-placement "Place.Global" "RefDef.Global" "RefWin.Global" )

;Meshing of Active region.........
(sdedr:define-refinement-window "RefWin.Active1" "Rectangle" (position (-  Si_x1  0.005 )  (-  Oxide_y2  0.001 )  0.0) (position (+  Si_x2  0.005 )  (+  Si_y1  0.050 )  0.0))
(sdedr:define-multibox-size "RefDefMB.Active1" 0.015 0.015 0.008 0.008 1 1)
(sdedr:define-multibox-placement "PlaceBM.Active1" "RefDefMB.Active1" "RefWin.Active1" )

;Meshing of Active region.........
(sdedr:define-refinement-window "RefWin.Active2" "Rectangle" (position (-  Si_x1  0.005 )  (-  Oxide_y2  0.005 )  0.0) (position (+  Si_x2  0.005 )  (+  Si_y1  0.010 )  0.0))
(sdedr:define-multibox-size "RefDefMB.Active2" 0.003 0.003 0.002 0.002 1 1)
(sdedr:define-multibox-placement "PlaceBM.Active2" "RefDefMB.Active2" "RefWin.Active2" )

;================================================================================================================
;Saving msh.tdr file
(sde:build-mesh "snmesh" "" "moscap_msh")
