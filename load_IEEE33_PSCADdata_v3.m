function data =  load_IEEE33_PSCADdata_v3(filename)
% filename:  main file name. ej:  Feeder24_70p_v2_mv1_01.out --> Feeder24_70p_v2_mv1
% n: total number of files saved. ej: 5 ---> Feeder24_70p_v2_mv1_01.out --
% to --  Feeder24_70p_v2_mv1_05.out
% Load PSCAD files
% %01
%     <channel index="0" id="1522524287:0" name="v_0" label="" dim="1" unit="V" min="-1.5" max="1.5" />
%     <channel index="1" id="481798296:0" name="v_1" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="2" id="1119032394:0" name="v_2" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="3" id="1618022779:0" name="v_3" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="4" id="1669931116:0" name="v_4" label="" dim="1" unit="V" min="-1.5" max="1.5" />
%     <channel index="5" id="754419465:0" name="v_5" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="6" id="1707003462:0" name="v_6" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="7" id="348120387:0" name="v_7" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="8" id="1164228441:0" name="v_8" label="" dim="1" unit="V" min="-1.5" max="1.5" />
%     <channel index="9" id="1939325356:0" name="v_9" label="" dim="1" unit="V" min="0" max="5" />
% 02
%     <channel index="10" id="1433463951:0" name="v_10" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="11" id="187308846:0" name="v_11" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="12" id="1398448119:0" name="v_12" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="13" id="1007331054:0" name="v_13" label="" dim="1" unit="V" min="-1.5" max="1.5" />
%     <channel index="14" id="473167954:0" name="v_14" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="15" id="1369434284:0" name="v_15" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="16" id="82339826:0" name="v_16" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="17" id="1179679329:0" name="v_17" label="" dim="1" unit="V" min="-1.5" max="1.5" />
%     <channel index="18" id="1129556967:0" name="v_18" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="19" id="1424453017:0" name="v_19" label="" dim="1" unit="V" min="0" max="5" />
% 03
%     <channel index="20" id="991297305:0" name="v_20" label="" dim="1" unit="V" min="-1.5" max="1.5" />
%     <channel index="21" id="91262511:0" name="v_21" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="22" id="371563301:0" name="v_22" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="23" id="123896796:0" name="v_23" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="24" id="996923629:0" name="v_24" label="" dim="1" unit="V" min="-1.5" max="1.5" />
%     <channel index="25" id="557446550:0" name="v_25" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="26" id="110730328:0" name="v_26" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="27" id="2026119207:0" name="v_27" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="28" id="142875897:0" name="v_28" label="" dim="1" unit="V" min="-1.5" max="1.5" />
%     <channel index="29" id="896623911:0" name="v_29" label="" dim="1" unit="V" min="0" max="5" />
% 04
%     <channel index="30" id="986301948:0" name="v_30" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="31" id="1140973518:0" name="v_31" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="32" id="1912983909:0" name="v_32" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="33" id="1958124294:0" name="P_dg1" label="" dim="1" unit="V" min="-1.5" max="1.5" />
%     <channel index="34" id="1386994465:0" name="Q_dg1" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="35" id="1330434700:0" name="v_dg1" label="" dim="1" unit="V" min="0" max="5" />   
%     <channel index="36" id="1704584987:0" name="P_dg2" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="37" id="684433007:0" name="Q_dg2" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="38" id="143361511:0" name="v_dg2" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="39" id="1725723912:0" name="P_dg3" label="" dim="1" unit="V" min="0" max="5" />
% 05
%     <channel index="40" id="1601571505:0" name="Q_dg3" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="41" id="1832660702:0" name="v_dg3" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="42" id="1382125258:0" name="P_dg4" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="43" id="537753504:0" name="Q_dg4" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="44" id="1359511600:0" name="v_dg4" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="45" id="736461817:0" name="P_dg5" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="46" id="554524325:0" name="Q_dg5" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="47" id="1982380567:0" name="v_dg5" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="48" id="939818387:0" name="P_dg6" label="" dim="1" unit="V" min="0" max="5" />
%     <channel index="49" id="1328930149:0" name="Q_dg6" label="" dim="1" unit="V" min="0" max="5" />
% 06
%     <channel index="50" id="1257814684:0" name="v_dg6" label="" dim="1" unit="V" min="0" max="5" />

% load -ascii _mv1_01.out
sim_data_01 =  load(strcat(filename,'_01.out'),'-ascii');

% load -ascii _mv1_02.out
sim_data_02 =  load(strcat(filename,'_02.out'),'-ascii');

% load -ascii _v2_mv1_03.out
sim_data_03 =  load(strcat(filename,'_03.out'),'-ascii');

% load -ascii _v2_mv1_04.out
sim_data_04 =  load(strcat(filename,'_04.out'),'-ascii');

% load -ascii _v2_mv1_05.out
sim_data_05 =  load(strcat(filename,'_05.out'),'-ascii');

% load -ascii _v2_mv1_06.out
sim_data_06 =  load(strcat(filename,'_06.out'),'-ascii');

%Define variables
data.t = sim_data_01(:,1);       
                          
data.v_0 = sim_data_01(:,2);   
data.v_1 = sim_data_01(:,3);   
data.v_2 = sim_data_01(:,4);   
data.v_3 = sim_data_01(:,5);   
data.v_4 = sim_data_01(:,6);   
data.v_5 = sim_data_01(:,7);   
data.v_6 = sim_data_01(:,8);   
data.v_7 = sim_data_01(:,9);   
data.v_8 = sim_data_01(:,10);  
data.v_9 = sim_data_01(:,11);  
                          
data.v_10 = sim_data_02(:,2);   
data.v_11 = sim_data_02(:,3);   
data.v_12 = sim_data_02(:,4);   
data.v_13 = sim_data_02(:,5);   
data.v_14 = sim_data_02(:,6);   
data.v_15 = sim_data_02(:,7);   
data.v_16 = sim_data_02(:,8);   
data.v_17 = sim_data_02(:,9);   
data.v_18 = sim_data_02(:,10);  
data.v_19 = sim_data_02(:,11);   
                          
data.v_20 = sim_data_03(:,2);   
data.v_21 = sim_data_03(:,3);   
data.v_22 = sim_data_03(:,4);   
data.v_23 = sim_data_03(:,5);   
data.v_24 = sim_data_03(:,6);   
data.v_25 = sim_data_03(:,7);   
data.v_26 = sim_data_03(:,8);   
data.v_27 = sim_data_03(:,9);   
data.v_28 = sim_data_03(:,10);  
data.v_29 = sim_data_03(:,11);  
                          
data.v_30 = sim_data_04(:,2);   
data.v_31 = sim_data_04(:,3);   
data.v_32 = sim_data_04(:,4);   
data.P_dg1 = sim_data_04(:,5);
data.Q_dg1 = sim_data_04(:,6);
data.v_dg1 = sim_data_04(:,7);
data.P_dg2 = sim_data_04(:,8);
data.Q_dg2 = sim_data_04(:,9);
data.v_dg2 = sim_data_04(:,10);
data.P_dg3 = sim_data_04(:,11);

data.Q_dg3 = sim_data_05(:,2);
data.v_dg3 = sim_data_05(:,3);
data.P_dg4 = sim_data_05(:,4);
data.Q_dg4 = sim_data_05(:,5);
data.v_dg4 = sim_data_05(:,6);
data.P_dg5 = sim_data_05(:,7);
data.Q_dg5 = sim_data_05(:,8);
data.v_dg5 = sim_data_05(:,9);
data.P_dg6 = sim_data_05(:,10);
data.Q_dg6 = sim_data_05(:,11);

data.v_dg6 = sim_data_06(:,2);