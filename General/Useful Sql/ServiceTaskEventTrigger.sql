select * from uext.Service_Task   
--where 
--DESCRIPTION like '%OCP%' 
order by 1 desc;

select * from uext.Service_Task_Queue where 
SERVICE_TASK_ID in (290,291) --and status_cd='PE'
--SERVICE_TASK_QUEUE_ID in (5816869)
order by 1 desc;

SELECT * FROM uext.Service_Task_Queue_Log 
WHERE Service_Task_Queue_Id in (5828473) -- AND Created_Dt >= sysdate
ORDER BY NVL(seq, 0), Service_Task_Queue_Log_Id;


SELECT * FROM Service_Task_Queue_Param 
WHERE 
--Service_Task_Queue_Id in (5806438) -- AND Created_Dt >= sysdate
PARAM_VALUE in ('12823','12822','12821') and param_name='REPORT_INSTANCE_ID'
ORDER BY Service_Task_Queue_Id;

-- select 1 from dual where '1' ^='1'

/*
DELETE FROM Service_Task_Queue WHERE Service_Task_Queue_Id in (5704698,5704697,5704696,5704695,5704694);

DELETE FROM Service_Task_Queue_log WHERE Service_Task_Queue_Id in (5810590);

*/

select * from Event_Trigger_Suppression;

select * from event_trigger_selection where sql like '%supress%';
													
select * from service_task_queue where status_cd='ER' SERVICE_TASK_ID in (326,325);

/*
update SERVICE_TASK_QUEUE set PROCESS_DATE=null,STATUS_CD='PE',Locked=0 where SERVICE_TASK_QUEUE_ID in
(5827497);

-- 5806436,5806437,5806438

 insert into SERVICE_TASK_QUEUE (SERVICE_TASK_QUEUE_ID,SERVICE_TASK_ID,SCHEDULE_DATE,LOCKED,ACTIVE,STATUS_CD)
values(SERVICE_TASK_QUEUE_ID_SEQ.nextval,228,sysdate,'0','1','PE');

DELETE FROM SERVICE_TASK_QUEUE WHERE  service_task_queue_id=5806439;

update service_task_queue set  service_task_id=606 where service_task_queue_id=113;

select * from Event_Trigger_Param where event_trigger_id in ( 149)    5796358

update Event_Trigger_Param set Param_Value='AWS-TestingTeam@aegon.co.uk' where Event_Trigger_Param_Id=302

update Event_Trigger_Param set Param_Value='murali.besta@aegon.co.uk' where Event_Trigger_Param_Id=302

*/

select * from service_task t1
inner join service_task_queue t2 on t1.SERVICE_TASK_ID=t2.SERVICE_TASK_ID
inner join event_trigger t3 on t3.SERVICE_TASK_ID=t1.SERVICE_TASK_ID
inner join event_trigger_selection t4 on t4.EVENT_TRIGGER_SELECTION_ID=t3.EVENT_TRIGGER_SELECTION_ID
left join event_trigger_param t5 on t5.EVENT_TRIGGER_ID=t3.EVENT_TRIGGER_ID
where t1.SERVICE_TASK_ID in (302)   and trunc(t2.SCHEDULE_DATE) = trunc(sysdate)
order by t2.SERVICE_TASK_QUEUE_ID desc;

select * from EVENT_TRIGGER_CREATED_ITEMS t1
INNER join EVENT_TRIGGER t2 on t2.EVENT_TRIGGER_ID=t1.EVENT_TRIGGER_ID
inner join v_account t4 on t4.case_mbr_key= t1.PERSON_ID
inner join v_scheme t5 on t5.case_key= t4.case_key
where t1.PERSON_ID=678387 and
t1.EVENT_TRIGGER_ID IN ('163','164','165','166','167','168','169','170','171','172','173','174','175','178') 
and t5.PROVIDER='X';

select * from  uext.event_trigger et
left join uext.EVENT_TRIGGER_SELECTION ets on ets.EVENT_TRIGGER_SELECTION_ID=et.EVENT_TRIGGER_SELECTION_ID
left join uext.EVENT_TRIGGER_SELECTION_ADDSQL etsa on etsa.EVENT_TRIGGER_SELECTION_ID=ets.EVENT_TRIGGER_SELECTION_ID
where et.EVENT_TRIGGER_ID in (160)

select * from uext.event_trigger_param where EVENT_TRIGGER_ID=302;

delete from event_trigger_param where EVENT_TRIGGER_ID=585;

INSERT INTO UEXT.Event_Trigger_Param 	
(Event_Trigger_Param_Id,            Event_Trigger_Id,   Param_Order,    Param_Name,         Param_Value,                    Param_Type)    
VALUES 	(Event_Trigger_Param_Seq.NextVal,   302,    20,              'HEADER_ROW_REQUIRED',         'True', 'STRING');            


-- DELETE from EVENT_TRIGGER_CREATED_ITEMS  where template_id=1005457 and PERSON_ID=678387



