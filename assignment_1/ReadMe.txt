This folder contains templates for the assignment 2 "Kinematic and rotations".

- The code "MainKinematic.m" is the file that you will run.
  You need to complete it for a successful simulation.

- The code "Kinematics.m" is a Matlab function that receives
  the state of the kinematic orientation and returns its time derivative.
  This is supported by the code in "SymbolicEuler.m", and functions created therein (first hint). 
  (In part (e) there should be no need for the functions created in "SymbolicEuler.m"). 
  The time derivative is used by ode45 to produce the simulation.
  You will need to complete "Kinematics.m" with the kinematic equations, and also complete "SymbolicEuler.m".
  Functionality is explained further in the files. 

- The code "Template3D.m" produces a 3D visualization of a cube,
  with vectors and reference frames. In the main code "MainKinematic.m",
  there is a for-loop at the end of the code that produces a 3D visualization
  that you can use to visualize your simulation. You will need to modify that
  part of the code to build the orientation of your single body as a result
  of the different SO(3) representation selected.

- All other codes are there to support the 3D visualizations.
