%ident
motor = iddata; motor.Tstart = 0;
motor.Ts = Ts;
motor.InputData = Va;
motor.OutputData = Omega;

%tfest para fazer a estimacao da funcao de transferencia
tfmotor1pole = tfest(motor ,1,0);
tfmotor2pole = tfest(motor ,2,0);
figure
step(Vstep*tfmotor1pole); hold
plot(time,Omega); figure
step(Vstep*tfmotor2poles); hold
plot(time,Omega);