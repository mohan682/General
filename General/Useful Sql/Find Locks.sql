select
(select username || ' - ' || osuser from v$session where sid=a.sid) blocker,
a.sid || ', ' ||
(select serial# from v$session where sid=a.sid) sid_serial,
' is blocking ',
(select username || ' - ' || osuser from v$session where sid=b.sid) blockee,
b.sid || ', ' ||
(select serial# from v$session where sid=b.sid) sid_serial
from v$lock a, v$lock b
where a.block = 1
and b.request > 0
and a.id1 = b.id1
and a.id2 = b.id2;

-- This one shows SQL that is currently "ACTIVE"

select S.USERNAME, s.sid, s.osuser, t.sql_id, sql_text
from v$sqltext_with_newlines t,V$SESSION s
where t.address =s.sql_address
and t.hash_value = s.sql_hash_value
and s.status = 'ACTIVE'
and s.username <> 'SYSTEM'
order by s.sid,t.piece

--This shows locks. Sometimes things are going slow, but it's because it is blocked waiting for a lock:
select
  object_name, 
  object_type, 
  session_id, 
  type,         -- Type or system/user lock
  lmode,        -- lock mode in which session holds lock
  request, 
  block, 
  ctime         -- Time since current mode was granted
from
  v$locked_object, all_objects, v$lock
where
  v$locked_object.object_id = all_objects.object_id AND
  v$lock.id1 = all_objects.object_id AND
  v$lock.sid = v$locked_object.session_id
order by
  session_id, ctime desc, object_name;
  
  --  it will give you queries currently running for more than 60 seconds. Note that it prints multiple lines per running query if the SQL has multiple lines. Look at the sid,serial# to see what belongs together.
select s.username,s.sid,s.serial#,s.last_call_et/60 mins_running,q.sql_text from v$session s 
join v$sqltext_with_newlines q
on s.sql_address = q.address
 where status='ACTIVE'
and type <>'BACKGROUND'
and last_call_et> 60
order by sid,serial#,q.piece
