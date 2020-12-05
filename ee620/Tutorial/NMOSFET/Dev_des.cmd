
* By default, this command files activates the  drift diffusion transport model. 
* To activate other transport models like hydrodynamic or density gradient models,
* uncomment the corresponding lines from the above code block and comment the 
* corresponding lines from the following code block. 


Electrode{
   { Name="source"    Voltage= 0.0 }
   { Name="drain"     Voltage= 0.0 }
   { Name="gate"      Voltage= 0.0 }
   { Name="substrate"      Voltage= 0.0 }
}

File{
   Grid      = "nmos_msh.tdr"
   Plot      = "nmos_Dev_simulation.tdr"
*   Parameter = "@parameter@"
   Current   = "nmos_Dev_simulation.plt"
   Output    = "nmos_Dev"
}

Physics{
    
   EffectiveIntrinsicDensity(BandGapNarrowing ( OldSlotboom ))  
   Recombination(SRH(DopingDependence))
   Mobility( 
      PhuMob  
	  HighFieldSaturation
      Enormal
    )
}

Physics(Material= Silicon) {   }

Plot{
*--Density and Currents, etc
   eDensity hDensity
   TotalCurrent/Vector eCurrent/Vector hCurrent/Vector
   eMobility hMobility
   eVelocity hVelocity
   eQuasiFermi hQuasiFermi

*--Temperature 
   eTemperature Temperature hTemperature

*--Fields and charges
   ElectricField/Vector Potential SpaceCharge

*--Doping Profiles
   Doping DonorConcentration AcceptorConcentration

*--Generation/Recombination
   SRH Band2Band * Auger
   * AvalancheGeneration eAvalancheGeneration hAvalancheGeneration

*--Driving forces
   eGradQuasiFermi/Vector hGradQuasiFermi/Vector
   eEparallel hEparallel eENormal hENormal

*--Band structure/Composition
   BandGap 
   BandGapNarrowing
   Affinity
   ConductionBand ValenceBand
   eQuantumPotential hQuantumPotential
   
*--Stress related data
   StressXX StressYY StressZZ
   StressXY StressXZ StressYZ

}


Math {
  Extrapolate
  Derivatives
  Avalderivatives
  RelErrControl
  Digits= 5
  ErRef(electron)= 1.e10
  ErRef(hole)= 1.e10
  Notdamped= 50
  Iterations= 20
  Directcurrent
  Method= ILS
  ILSrc= "
  set(1){
	  iterative( gmres(100), tolrel=1e-8, maxit=200);
	  preconditioning(ilut(0.0005,-1),left);
	  ordering ( symmetric=nd, nonsymmetric=mpsilst );
	  options(compact=yes,verbose=0);
  };
  "  
   eMobilityAveraging= ElementEdge
   * uses edge mobility instead of element one for electron mobility	
   hMobilityAveraging= ElementEdge   
   * uses edge mobility instead of element one for hole mobility
   GeometricDistances 		         
   * when needed, compute distance to the interface instead of closest point on the interface
   ParameterInheritance= Flatten 	  
   * regions inherit parameters from materials  
}   

Solve{
  NewCurrentFile="init" 
  Coupled(Iterations= 100 LineSearchDamping= 1e-4){ Poisson   }
  Quasistationary(
     InitialStep= 0.01
     MaxStep= 0.5 Minstep= 1.e-5
     Increment= 1.3
     Goal { Name="gate" Voltage=1 }
  ){ Coupled{ Poisson Electron   } }

  NewCurrentFile="" 
  Quasistationary(
     DoZero
     InitialStep= 1.e-3
     MaxStep= 0.05 Minstep= 1.e-5
     Increment= 1.3
     Goal{ Name="drain" Voltage=1 }
  ){ Coupled{ Poisson Electron     } }
}
