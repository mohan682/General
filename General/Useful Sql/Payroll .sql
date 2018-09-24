 select * from PAYROLL_MEMBER_DATA where case_mbr_key=633716;
 
 select * from PAYROLL_PAYMENT_DATA where case_mbr_key=633716;
 
 select * from CONTACT_HISTORY where CASE_MBR_KEY=633716 order by 1 desc -- description like '%Payment ref:%'
 
 select * from ref_codes where domain_name='PYIT IF CD' and upper(descript)=upper('Interfaced') and disable_cd='0'
    -- For Decume accounts
      select  Cm.Case_Mbr_Key,max(pii.Tr_Ref_No) Tr_Ref_No,sum(abs(td.amt)) Pymt_Amt, pii.pymt_dt, td.Tr_Cd, 
        cu.Mny_Typ_Key AS Mny_Typ_Key            
        from Pymt_Instruct_Ii pii  
        Inner Join Payer_Ref Pr On Pr.Pyrf_Key=Pii.Pyrf_Key And Pr.Pyin_Stat_Cd='1' And 
        Pr.Eff_dt<Sysdate And (Trunc(Pr.Xpir_dt) >= Trunc(Sysdate) Or Pr.Xpir_dt Is Null)    
        inner join Transact_Details td on pii.Tr_Ref_No=td.Tr_Ref_No and td.Stat_Cd='0' AND TD.EFF_DT <= sysdate
        inner join Contrib_Usage cu on CU.MNY_TYP_NO=td.Mny_Typ_No
        inner join Case_Members Cm on CM.CASE_MBR_KEY=TD.CASE_MBR_KEY and CM.CASE_KEy=cu.case_key
        where  abs(td.amt)>0 and pii.IF_CD='00' and cu.Mny_Typ_Key in (65,66) and cm.Case_Mbr_Key=633716 
        group by Cm.Case_Mbr_Key, pii.pymt_dt, pii.Tr_Cd, td.Tr_Cd, cu.Mny_Typ_Key
    union
    -- For Accum accounts        
         select  Cm.Case_Mbr_Key,max(pii.Tr_Ref_No) Tr_Ref_No,sum(abs(td.amt)) Pymt_Amt, pii.pymt_dt, td.Tr_Cd, 
        -1 AS Mny_Typ_Key            
        from Pymt_Instruct_Ii pii 
        Inner Join Payer_Ref Pr On Pr.Pyrf_Key=Pii.Pyrf_Key And Pr.Pyin_Stat_Cd='1' And 
        Pr.Eff_dt<Sysdate And (Trunc(Pr.Xpir_dt) >= Trunc(Sysdate) Or Pr.Xpir_dt Is Null)  
        inner join  case_data cd   on  cd.case_key=   pii.CASE_KEY         
        inner join Transact_Details td on pii.Tr_Ref_No=td.Tr_Ref_No and td.Stat_Cd='0' 
      --  AND TD.EFF_DT < (SELECT calendar_dt from  t_workingDates WHERE 
      --  (i_IsFirstCycle=1 and (CD.OVRD_CO_CD= 'M' or CD.OVRD_CO_CD= 'A' or CD.OVRD_CO_CD= 'Z') and rownumber = 4) or
       -- (i_IsFirstCycle <> 1 and (CD.OVRD_CO_CD= 'M' or CD.OVRD_CO_CD= 'A' or CD.OVRD_CO_CD= 'Z') and rownumber = 5) or
      --  (i_IsFirstCycle= 1 and CD.OVRD_CO_CD= 'L' and rownumber = 5) or 
      --  (i_IsFirstCycle<> 1 and CD.OVRD_CO_CD= 'L' and rownumber = 6)
      --  )
        inner join Contrib_Usage cu on CU.MNY_TYP_NO=td.Mny_Typ_No
        inner join Case_Members Cm on CM.CASE_MBR_KEY=TD.CASE_MBR_KEY and CM.CASE_KEy=cu.case_key
        where  abs(td.amt)>0 and pii.IF_CD='00' and  cu.Mny_Typ_Key not in (65,66) and cm.Case_Mbr_Key=633716  
        group by Cm.Case_Mbr_Key, pii.pymt_dt, pii.Tr_Cd, td.Tr_Cd    
          
          where Va.Case_Mbr_Key=633716
          
          select * from Pymt_Instruct_Ii pii
           Inner Join Payer_Ref Pr On Pr.Pyrf_Key=Pii.Pyrf_Key And --Pr.Pyin_Stat_Cd='1' And 
                                Pr.Eff_dt<Sysdate And (Trunc(Pr.Xpir_dt) >= Trunc(Sysdate) Or Pr.Xpir_dt Is Null) 
          where Tr_Ref_No in ('100779280226')