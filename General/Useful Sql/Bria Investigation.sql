select * from uext_case_members where decum_CASE_MBR_KEY=667261;

select * from case_members where CASE_MBR_KEY in (588934,667261);

select * from uext.user_acc where nameid=84506;

select * from uext.user_acc_session where  --user_acc_id=23444 
case_mbr_key in (588934,667261); 

select * from UEXT.V_PARTY_ADDROTHER where nameid=84506



select * from UEXT.PROFILE_MILESTONE ;
select * from UEXT.PROFILE_STAGE
select * from UEXT.PROFILE_STAGE_MILESTONE ;

select * from UEXT.PROFILE_MILESTONE_PERSON t1
inner join UEXT.PROFILE_STAGE_MILESTONE t2 on t2.PROFILE_STAGE_MILESTONE_ID=t1.PROFILE_STAGE_MILESTONE_ID
inner join UEXT.PROFILE_MILESTONE t3 on t3.PROFILE_MILESTONE_ID=t2.PROFILE_STAGE_MILESTONE_ID
inner join UEXT.PROFILE_STAGE t4 on t4.profile_stage_id=t2.profile_stage_id
where nameid=84506 order by 1 desc;

select * from UEXT.PROFILE_MILESTONE_ACCOUNT t1 where t1.CASE_MBR_KEY in (588934,667261) 
inner join UEXT.PROFILE_STAGE_MILESTONE t2 on t2.PROFILE_STAGE_MILESTONE_ID=t1.PROFILE_STAGE_MILESTONE_ID
inner join UEXT.PROFILE_MILESTONE t3 on t3.PROFILE_MILESTONE_ID=t2.PROFILE_STAGE_MILESTONE_ID
inner join UEXT.PROFILE_STAGE t4 on t4.profile_stage_id=t2.profile_stage_id
where t1.CASE_MBR_KEY in (588934,667261) order by 1 desc;

select * from UEXT.PROFILE_MILESTONE_Account where nameid=84506;

select * from UEXT.DECUM_JOINING_DETAIL where case_mbr_key in (588934,667261);

select * from contact_history where case_mbr_key in (588934,667261);

select * from uext.v_scheme where  case_key in (2236,2190)

select * from action


with  t as (
select ua.user_acc_id, ua.action_dt, sr.description, a.code 
from UEXT.action a
left join UEXT.user_action ua on Ua.Action_Id = a.action_id
left join UEXT.Screen_Resource sr on Sr.Screen_Resource_Id = Ua.Screenresource_Id
left join UEXT.user_acc u on U.User_Acc_Id = Ua.User_Acc_Id
where 1=1
--and U.User_Type in (0,5)
and UA.USER_ACC_ID = 23444
) select * from t order by action_dt desc; 

Acum Account : 588934
 Decum Account : 665785
 
 
 
 
 
SELECT DISTINCT 
	VA.CASE_MBR_KEY AS ID, 
	ACCUM.CASE_MBR_KEY AS ACCUM_CASE_MBR_KEY, 
 
	VS.PROD_TYP_CD AS PRODUCT_TYPE_CD, 
	VS.PLAN_TYP_CD AS PLAN_TYPE_CD, 
	VA.CASE_KEY AS SCHEME_ID, 
	VS.MBR_CT AS MEMBER_GRP_ID, 
	VS.CO_CD AS PROVIDER_CD, 
	--uext.PDI.MBGP_Key(VA.CASE_MBR_KEY, 12, sysdate) AS BENEFIT_MEMBER_GRP_ID, 
	0 AS SWITCH_MEMBER_GRP_ID, 
	0 AS TEMPLATE_ID, 
 
	M.MBR_STAT_CD, 
	rc1.descript as MBR_STAT_Descript	 
 
FROM uext.V_SCHEME VS 
	INNER JOIN uext.V_ACCOUNT VA ON VS.CASE_KEY = VA.CASE_KEY 
	INNER JOIN uext.V_PERSON VP ON VA.NAMEID = VP.NAMEID 
	--INNER JOIN uext.V_PARTY_ADDRDATA VPA ON VPA.NAMEID = VA.NAMEID 
	--INNER JOIN REF_CODES R ON VP.NAMEPREFIX = R.REF_CD and R.DOMAIN_NAME = 'PERS NAMEPREFIX' 
	INNER JOIN CASE_DATA CD ON CD.CASE_KEY = VA.CASE_KEY 
	INNER JOIN MEMBER_STATUSES M ON VA.CASE_MBR_KEY = M.CASE_MBR_KEY AND NVL(M.XPIR_DT,SYSDATE+1) > SYSDATE 
	INNER JOIN uext.UEXT_CASE_DATA UCD ON UCD.CASE_KEY = VA.CASE_KEY AND UCD.LETTERS_TO_MEMBERS = 1 AND UCD.ASSOCIATED_DECUM_SCHEME IS NULL 
	-- LEFT JOIN  users U ON VA.account_no = U.user_name 
    
	LEFT JOIN REF_CODES rc1 on 
		rc1.ref_cd = M.mbr_stat_cd and rc1.domain_name = 'MBR PART STAT CD'  
  
	LEFT JOIN uext.Uext_Case_Members    ACCUM    ON   ACCUM.Decum_Case_Mbr_Key = VA.CASE_MBR_KEY --useful for welcome pack. 
 
	LEFT JOIN uext.Event_Trigger_Created_Items CI ON  
		VA.Case_Mbr_Key = CI.Person_Id AND CI.Event_Trigger_Id = 160 
	 
    --Now restrict to members who have: 
    --a milestone for 'Confirmation' 
    --AND an account status of 'Pending App form' 
 
    left JOIN  uext.Profile_Milestone_Person    MP on MP.NAMEID = VP.NAMEID 
 
    inner join    uext.Profile_Stage_Milestone        SM ON SM.Profile_Stage_Milestone_Id = MP.Profile_Stage_Milestone_Id 
    inner JOIN    uext.Profile_Stage                PS    ON    PS.Profile_Stage_Id                = SM.Profile_Stage_Id 
    inner JOIN    uext.Profile_Type                PT    ON    PT.Profile_Type_Id                = PS.Profile_Type_Id            AND    PT.Name    = 'DecumulationJoining' 
    INNER JOIN    uext.MileStone                    MS    ON    MS.Milestone_Id                    = SM.Milestone_Id 
 
Where  
	1=1 
	and CI.Person_Id    IS NULL 
	 
    and rc1.REF_CD = '92' --Pending App Form 
    and MS.CODE ='CONFM' --confirm status 
    AND MP.DATE_COMPLETED is not null 
 
 
order by  
	VA.CASE_MBR_KEY ;











SELECT ALL UEXT.MILESTONE.MILESTONE_ID, UEXT.PROFILE_TYPE.NAME, 
UEXT.PROFILE_MILESTONE_PERSON.DATE_COMPLETED, UEXT.PROFILE_STAGE.DISPLAY_SEQUENCE, 
UEXT.PROFILE_STAGE.CODE, UEXT.PROFILE_STAGE.NAME, UEXT.MILESTONE.CODE, 
UEXT.MILESTONE.NAME, UEXT.PROFILE_STAGE_MILESTONE.DISPLAY_SEQUENCE
FROM UEXT.MILESTONE, UEXT.PROFILE_MILESTONE_PERSON, 
UEXT.PROFILE_STAGE, UEXT.PROFILE_STAGE_MILESTONE, UEXT.PROFILE_TYPE
WHERE UEXT.PROFILE_MILESTONE_PERSON.NAMEID=616655
AND  ((UEXT.PROFILE_STAGE.PROFILE_TYPE_ID=UEXT.PROFILE_TYPE.PROFILE_TYPE_ID)
AND (UEXT.PROFILE_STAGE_MILESTONE.MILESTONE_ID=UEXT.MILESTONE.MILESTONE_ID)
AND (UEXT.PROFILE_STAGE.PROFILE_STAGE_ID=UEXT.PROFILE_STAGE_MILESTONE.PROFILE_STAGE_ID)
AND (UEXT.PROFILE_STAGE_MILESTONE.PROFILE_STAGE_MILESTONE_ID=UEXT.PROFILE_MILESTONE_PERSON.PROFILE_STAGE_MILESTONE_ID))
ORDER BY UEXT.PROFILE_MILESTONE_PERSON.DATE_COMPLETED ASC, 
UEXT.MILESTONE.MILESTONE_ID ASC

