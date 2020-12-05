Device NMOS {
  Electrode {
    { name="source"    Voltage=0.0 }
    { name="drain"     Voltage=0.0 }
    { name="gate"      Voltage=0.0 }
    { name="substrate" Voltage=0.0 }
  }

  File {
     Grid    = "nmos_msh.tdr"
     Plot    = "ac_simulation.tdr"
     Current = "ac_simulation.plt"
*     Param   = "@parameter@"
  }

  Physics {
    Mobility( DopingDep HighFieldSaturation Enormal )
    EffectiveIntrinsicDensity( oldSlotboom )
  }

}

Math {
  Extrapolate
  RelErrControl
  Notdamped=100
  Iterations=40
}

Plot {
  eDensity hDensity
  eCurrent hCurrent
  ElectricField eEnormal hEnormal
  eQuasiFermi hQuasiFermi
  Potential Doping SpaceCharge
  SRH Auger 
  AvalancheGeneration
  eMobility hMobility
  DonorConcentration AcceptorConcentration
  Doping
  eVelocity hVelocity
}

File {
   Output  = "nmos_ac"
   ACExtract = "nmos_simulation"
}

System {
  NMOS nmos(drain=d source=s gate=g substrate=b)
  Vsource_pset vd ( d 0 ){ dc = 0 }
  Vsource_pset vs ( s 0 ){ dc = 0 }
  Vsource_pset vg ( g 0 ){ dc = 0 }
  Vsource_pset vb ( b 0 ){ dc = 0 }
}

Solve {
  NewCurrentPrefix="init"
  Coupled(Iterations=100){ Poisson }
  Coupled{ Poisson Electron Hole }

  Quasistationary ( 
     InitialStep=0.1 Increment=1.3
     MaxStep=0.5 Minstep=1.e-5  
     Goal { Parameter=vg.dc Voltage=-3}
  ){ Coupled { Poisson Electron Hole } }

  #-ramp gate
  NewCurrentPrefix=""
  Quasistationary (
     InitialStep=0.01 Increment=1.3
     MaxStep=0.05 Minstep=1.e-5 
     Goal { Parameter=vg.dc Voltage=3}
  ){ ACCoupled (
       StartFrequency=1e6 EndFrequency=1e6 NumberOfPoints=1 Decade
       Node(g b) Exclude(vg vb) 
       ACCompute (Time = (Range = (0 1)  Intervals = 20))
     ){ Poisson Electron Hole }
  }
}
