function p=rayleigh_statistics(n,r)
%calculates Rayleigh statistics based on the number of jumps(n)
%and the sample mean vector length found by circstat
c5_5                 = 0.76;
c5_1                 = 0.89;
c5_01  					= 0.99;
c6_5                 = 0.69;
c6_1                 = 0.82;
c6_01		   			= 0.99;   
c7_5                 = 0.645;
c7_1                 = 0.78;
c7_01			   		= 0.88;
c8_5                 = 0.605;
c8_1                 = 0.73;
c8_01				   	= 0.84;
c9_5                 = 0.575;
c9_1                 = 0.69;
c9_01					   = 0.80;    
c10_5                 = 0.54;
c10_1                 = 0.66;
c10_01				    = 0.76;
c11_5                 = 0.52;
c11_1                 = 0.63;
c11_01			   	 = 0.74;    
c12_5                 = 0.50;
c12_1                 = 0.60;
c12_01				  	 = 0.70;    
c13_5                 = 0.48;
c13_1                 = 0.58;
c13_01				  	 = 0.68;    
c14_5                 = 0.46;
c14_1                 = 0.56;
c14_01				  	 = 0.66;    
c15_5                 = 0.445;
c15_1                 = 0.54;
c15_01				  	 = 0.64;    
c16_5                 = 0.43;
c16_1                 = 0.53;
c16_01				  	 = 0.62;  
c17_5                 = 0.42;
c17_1                 = 0.51;
c17_01				  	 = 0.60;    
c18_5                 = 0.405;
c18_1                 = 0.50;
c18_01				  	 = 0.60;   
c19_5                 = 0.40;
c19_1                 = 0.49;
c19_01				  	 = 0.58;    
c20_5                = 0.385;
c21_5                = 0.376;
c22_5                = 0.366;
c23_5                = 0.36;
c24_5                = 0.352;
c25_5                = 0.345;
c20_1                = 0.47;
c21_1                = 0.46;
c22_1                = 0.45;
c23_1                = 0.44;
c24_1                = 0.43;
c25_1                = 0.425;
c20_01               = 0.56;
c21_01               = 0.56;
c22_01               = 0.54;
c23_01               = 0.52;
c24_01               = 0.52;
c25_01               = 0.50;

C30_5                = 2.97;
C50_5                = 2.98;
C100_5               = 2.99;
C200_5					= 2.99;
C500_5               = 2.99;
Cuen_5               = 3.00;
C30_1                = 4.50;
C50_1                = 4.54;
C100_1               = 4.57;
C200_1               = 4.59;
C500_1               = 4.60;
Cuen_1               = 4.61;
C30_01               = 6.62;
C50_01               = 6.74;
C100_01              = 6.82;
C200_01              = 6.87;
C500_01              = 6.89;
Cuen_01              = 6.91;
    
 if n>0   
    switch n
        case 5
             Radius5 = c5_5;
             Radius1 = c5_1;
             Radius01 = c5_01;
        case 6
             Radius5 = c6_5;
             Radius1 = c6_1;
             Radius01 = c6_01;
        case 7
             Radius5 = c7_5;
             Radius1 = c7_1;
             Radius01 = c7_01;
        case 8
             Radius5 = c8_5;
             Radius1 = c8_1;
             Radius01 = c8_01;
        case 9
             Radius5 = c9_5;
             Radius1 = c9_1;
             Radius01 = c9_01;
        case 10
             Radius5 = c10_5;
             Radius1 = c10_1;
             Radius01 = c10_01;
        case 11
             Radius5 = c11_5;
             Radius1 = c11_1;
             Radius01 = c11_01;
        case 12
             Radius5 = c12_5;
             Radius1 = c12_1;
             Radius01 = c12_01;
        case 13
             Radius5 = c13_5;
             Radius1 = c13_1;
             Radius01 = c13_01;
        case 14
             Radius5 = c14_5;
             Radius1 = c14_1;
             Radius01 = c14_01;
        case 15
             Radius5 = c15_5;
             Radius1 = c15_1;
             Radius01 = c15_01;
        case 16
             Radius5 = c16_5;
             Radius1 = c16_1;
             Radius01 = c16_01;
        case 17
             Radius5 = c17_5;
             Radius1 = c17_1;
             Radius01 = c17_01;
        case 18
             Radius5 = c18_5;
             Radius1 = c18_1;
             Radius01 = c18_01;
        case 19
             Radius5 = c19_5;
             Radius1 = c19_1;
             Radius01 = c19_01;
        case 20
             Radius5 = c20_5;
             Radius1 = c20_1;
             Radius01 = c20_01;
        case 21
             Radius5 = c21_5;
             Radius1 = c21_1;
             Radius01 = c21_01;
        case 22
             Radius5 = c22_5;
             Radius1 = c22_1;
             Radius01 = c22_01;
        case 23
             Radius5 = c23_5;
             Radius1 = c23_1;
             Radius01 = c23_01;
        case 24
             Radius5 = c24_5;
             Radius1 = c24_1;
             Radius01 = c24_01;
        case 25
             Radius5 = c25_5;
             Radius1 = c25_1;
             Radius01 = c25_01;
        case {26,27,28,29,30}
             Radius5 = sqrt(C30_5/n);
             Radius1 = sqrt(C30_1/n);
             Radius01 = sqrt (C30_01/n);
        otherwise 
             if n>30 & n<=50
                Radius5 = sqrt(C50_5/n);
                Radius1 = sqrt(C50_1/n);
                Radius01 = sqrt (C50_01/n);
             else   
                if n>50 & n<=100
                   Radius5 = sqrt(C100_5/n);
                   Radius1 = sqrt(C100_1/n);
                   Radius01 = sqrt (C100_01/n);
                else
                   if n>100 & n<=200
                      Radius5 = sqrt(C200_5/n);
                      Radius1 = sqrt(C200_1/n);
                      Radius01 = sqrt (C200_01/n);
                   else
                      if n>200 & n<=500
                         Radius5 = sqrt(C500_5/n);
                         Radius1 = sqrt(C500_1/n);
                         Radius01 = sqrt (C500_01/n);
                      else
                         if n>500
                            Radius5 = sqrt(Cuen_5/n);
                            Radius1 = sqrt(Cuen_1/n);
                            Radius01 = sqrt (Cuen_01/n);
                         else
                            Radius5 = NaN;
                            Radius1 = NaN;
                            Radius01 = NaN;
                         end;
                      end;
                   end;
                end;
             end;
    end;
    if r>Radius01   
       p=0.001;
    else
       if r>Radius1
          p=0.01;
       else
          if r>Radius5
             p=0.05;
          else
             p=NaN;
          end;
       end;
    end;
 else
    p=NaN;
 end;