select TYPE, TERM, ASSET_CODE, PCT from LIFEPATH_FUND_MIX;

select * from LIFEPATH_TYPE_CONFIG;

select * from UNDERLYING_FUND_MIX where MKEY_FD_NUM in (1002,364,369)

select * from LIFEPATH_NOTIONAL_FD_GLIDE;

 -- Growth Fund / Assets
 
select distinct rc.ref_cd, rc.descript,rc2.*
from ref_codes rc
inner join fund_desc fd on rc.ref_cd = fd.mkey_fd_num
inner join uext_fund_desc ufd on fd.fd_desc_id = ufd.fd_desc_id
inner join ref_codes rc2 on ufd.lifepath_type = rc2.ref_cd
where rc.domain_name = 'TMAP MKEY FD NUM'
and rc2.domain_name = 'LP_NOTIONAL_FUND_TYPE';


with t_growthFunds as (
 select lnfg.*,case when rc.ref_cd='LP_NTNL_GWTH_FD' then 1 else 0 end Is_Growth_Fund from  LIFEPATH_NOTIONAL_FD_GLIDE lnfg 
 inner join fund_desc fd on  fd.mkey_fd_num=lnfg.mkey_fd_num
inner join uext_fund_desc ufd on fd.fd_desc_id = ufd.fd_desc_id
inner join ref_codes rc on ufd.lifepath_type = rc.ref_cd and rc.domain_name = 'LP_NOTIONAL_FUND_TYPE' ; 
)
 
 select ltc.LIFEPATH_TYPE,ltc.GROWTH_FUND,temp_lnfg.MKEY_FD_NUM, temp_lnfg.TERM,ufm.ASSET_CODE, ufm.pct,temp_lnfg.pct,
 
 0 as Percentage 
 
 from LIFEPATH_TYPE_CONFIG ltc
 inner join UNDERLYING_FUND_MIX ufm on ufm.MKEY_FD_NUM=ltc.GROWTH_FUND
 inner join t_growthFunds temp_lnfg on temp_lnfg.NOTIONAL_FUND_GLIDE=ltc.NOTIONAL_FUND_GLIDE 
  
 where ltc.GROWTH_FUND=1002 and lnfg.TERM=24
 
 --group by ltc.LIFEPATH_TYPE,ufm.ASSET_CODE,lnfg.TERM
 
 order by ltc.LIFEPATH_TYPE,temp_lnfg.TERM,to_number(ufm.ASSET_CODE)
