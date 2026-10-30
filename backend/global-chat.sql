create table public.tth_global_messages (
 id bigint generated always as identity primary key,
 user_id uuid not null references auth.users(id) on delete cascade,
 username text not null check(username ~ '^[a-z0-9_]{3,20}$'),
 kind text not null default 'text' check(kind in ('text','gif')),
 message text not null check(char_length(btrim(message)) between 1 and 2000),
 created_at timestamptz not null default now(),
 check(kind <> 'gif' or (message like 'https://%' and char_length(message) <= 2000))
);
create index tth_global_messages_user_time on public.tth_global_messages(user_id,created_at desc);
create index tth_global_messages_time on public.tth_global_messages(created_at desc);
alter table public.tth_global_messages enable row level security;
revoke all on public.tth_global_messages from anon, authenticated;
grant select on public.tth_global_messages to anon, authenticated;
grant insert(user_id,username,kind,message), delete on public.tth_global_messages to authenticated;
grant usage on sequence public.tth_global_messages_id_seq to authenticated;
create policy tth_public_recent on public.tth_global_messages for select to anon, authenticated using(created_at > now()-interval '24 hours');
create policy tth_post_self on public.tth_global_messages for insert to authenticated with check(
 user_id=(select auth.uid()) and
 username=split_part((select auth.jwt())->>'email','@',1) and
 (select auth.jwt())->>'email' like '%@players.star-square.invalid'
);
create policy tth_delete_self on public.tth_global_messages for delete to authenticated using(user_id=(select auth.uid()));
create function public.tth_check_post() returns trigger language plpgsql security invoker set search_path='' as $$
begin
 if auth.uid() is null or new.user_id <> auth.uid() then raise exception 'Sign in to post.'; end if;
 perform pg_advisory_xact_lock(hashtextextended(auth.uid()::text,73812));
 if exists(select 1 from public.tth_global_messages where user_id=auth.uid() and created_at > now()-interval '3 seconds') then
 raise exception 'Wait 3 seconds between messages.';
 end if;
 if (select count(*) from public.tth_global_messages where user_id=auth.uid() and created_at>now()-interval '24 hours') >= 1000 then raise exception 'Daily posting limit reached.'; end if;
 new.created_at=now();
 return new;
end $$;
revoke all on function public.tth_check_post() from public, anon;
grant execute on function public.tth_check_post() to authenticated;
create trigger tth_post_guard before insert on public.tth_global_messages for each row execute function public.tth_check_post();
