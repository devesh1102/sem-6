* HD

File{
   Grid      = "nmos_msh.tdr"
   Plot      = "nmos_HD_simulation.tdr"
*   Parameter = "@parameter@"
   Current   = "nmos_HD_simulation.plt"
   Output    = "nmos_HD"
}

Electrode{
   { Name="source"    Voltage=0.0 }
   { Name="drain"     Voltage=0.0 }
   { Name="gate"      Voltage=0.0 }
   { Name="substrate" Voltage=0.0 }
}


Physics{
   Hydrodynamic(eTemperature)  
   eQCvanDort 
   EffectiveIntrinsicDensity( OldSlotboom )     
   Mobility(
      DopingDep
      eHighFieldsaturation( CarrierTempDrive )
      hHighFieldsaturation( GradQuasiFermi )
      Enormal
   )
   Recombination(
      SRH( DopingDep TempDependence )
   )           
}

Plot{
*--Density and Currents, etc
   eDensity hDensity
   TotalCurrent/Vector eCurrent/Vector hCurrent/Vector
   eMobility hMobility
   eVelocity hVelocity
   eQuasiFermi hQuasiFermi

*--Temperature 
   eTemperature Temperature * hTemperature

*--Fields and charges
   ElectricField/Vector Potential SpaceCharge

*--Doping Profiles
   Doping DonorConcentration AcceptorConcentration

*--Generation/Recombination
   SRH Band2Band * Auger
   AvalancheGeneration eAvalancheGeneration hAvalancheGeneration

*--Driving forces
   eGradQuasiFermi/Vector hGradQuasiFermi/Vector
   eEparallel hEparallel eENormal hENormal

*--Band structure/Composition
   BandGap 
   BandGapNarrowing
   Affinity
   ConductionBand ValenceBand
   eQuantumPotential

}

Math {
   Extrapolate
   Iterations=40
   Notdamped =100
   RelErrControl
   ErRef(Electron)=1.e10
   ErRef(Hole)=1.e10
}

Solve {
   *- Build-up of initial solution:
   NewCurrentPrefix="init"
   Coupled(Iterations=100){ Poisson }
   Coupled{ Poisson Electron Hole eTemperature }
   
   *- Bias gate to target bias
     NewCurrentPrefix=""
   Quasistationary(
      InitialStep=0.01 Increment=1.35 
      MinStep=1e-5 MaxStep=0.2
      Goal{ Name="gate" Voltage= 3 }
   ){ Coupled{ Poisson Electron Hole eTemperature } 

   }
}
