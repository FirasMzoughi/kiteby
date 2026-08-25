-- Kiteby Supabase schema
-- Run this in the Supabase SQL editor (Project > SQL Editor > New query).
-- Safe to re-run: uses "create table if not exists" and drops policies before recreating.

-- ============================================================
-- EXTENSIONS
-- ============================================================
create extension if not exists "uuid-ossp";

-- ============================================================
-- PROFILES (extends auth.users)
-- ============================================================
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null,
  full_name text,
  role text not null default 'reader' check (role in ('reader', 'author')),
  age int,
  country text,
  bio text,
  avatar_url text,
  is_verified boolean not null default false,
  followers_count int not null default 0,
  following_count int not null default 0,
  likes_count int not null default 0,
  daily_reports boolean not null default false,
  weekly_summary boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.genres (
  id uuid primary key default uuid_generate_v4(),
  name text unique not null
);

create table if not exists public.profile_genres (
  profile_id uuid not null references public.profiles(id) on delete cascade,
  genre_id uuid not null references public.genres(id) on delete cascade,
  primary key (profile_id, genre_id)
);

-- ============================================================
-- BOOKS
-- ============================================================
create table if not exists public.books (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  author_name text not null,
  author_id uuid references public.profiles(id) on delete set null,
  description text,
  cover_url text,
  cover_color text,
  rating numeric(2,1) not null default 0,
  reviews_count int not null default 0,
  genre_id uuid references public.genres(id) on delete set null,
  is_book_of_week boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.book_reviews (
  id uuid primary key default uuid_generate_v4(),
  book_id uuid not null references public.books(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  score int not null check (score between 1 and 5),
  comment text,
  created_at timestamptz not null default now(),
  unique (book_id, profile_id)
);

create table if not exists public.reading_progress (
  id uuid primary key default uuid_generate_v4(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  book_id uuid not null references public.books(id) on delete cascade,
  status text not null default 'in_progress' check (status in ('in_progress', 'read', 'wished')),
  progress_percent int not null default 0 check (progress_percent between 0 and 100),
  updated_at timestamptz not null default now(),
  unique (profile_id, book_id)
);

-- ============================================================
-- POSTS (feed posts, e.g. "Street portrait")
-- ============================================================
create table if not exists public.posts (
  id uuid primary key default uuid_generate_v4(),
  author_id uuid not null references public.profiles(id) on delete cascade,
  title text,
  body text,
  image_url text,
  views_count int not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.post_likes (
  post_id uuid not null references public.posts(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (post_id, profile_id)
);

create table if not exists public.post_comments (
  id uuid primary key default uuid_generate_v4(),
  post_id uuid not null references public.posts(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  body text not null,
  likes_count int not null default 0,
  created_at timestamptz not null default now()
);

-- ============================================================
-- BOOK THESES (the "Books Thesis" cards)
-- ============================================================
create table if not exists public.theses (
  id uuid primary key default uuid_generate_v4(),
  book_id uuid not null references public.books(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  score numeric(2,1) not null default 5.0,
  statement text not null,
  summary text not null,
  likes_count int not null default 0,
  comments_count int not null default 0,
  shares_count int not null default 0,
  created_at timestamptz not null default now()
);

-- ============================================================
-- SOCIAL GRAPH
-- ============================================================
create table if not exists public.follows (
  follower_id uuid not null references public.profiles(id) on delete cascade,
  followee_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (follower_id, followee_id),
  check (follower_id <> followee_id)
);

-- ============================================================
-- ROOMS / CALLS / MESSAGES
-- ============================================================
create table if not exists public.rooms (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  book_id uuid references public.books(id) on delete set null,
  cover_url text,
  created_by uuid references public.profiles(id) on delete set null,
  is_live boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.room_participants (
  room_id uuid not null references public.rooms(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  is_muted boolean not null default true,
  joined_at timestamptz not null default now(),
  primary key (room_id, profile_id)
);

create table if not exists public.conversations (
  id uuid primary key default uuid_generate_v4(),
  created_at timestamptz not null default now()
);

create table if not exists public.conversation_participants (
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  primary key (conversation_id, profile_id)
);

create table if not exists public.messages (
  id uuid primary key default uuid_generate_v4(),
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  sender_id uuid not null references public.profiles(id) on delete cascade,
  body text,
  image_url text,
  created_at timestamptz not null default now()
);

-- ============================================================
-- NOTIFICATIONS
-- ============================================================
create table if not exists public.notifications (
  id uuid primary key default uuid_generate_v4(),
  recipient_id uuid not null references public.profiles(id) on delete cascade,
  actor_id uuid not null references public.profiles(id) on delete cascade,
  type text not null check (type in ('like', 'comment', 'follow', 'comment_like')),
  target_type text check (target_type in ('post', 'thesis', 'book', 'profile')),
  target_id uuid,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.notification_settings (
  profile_id uuid primary key references public.profiles(id) on delete cascade,
  collections boolean not null default true,
  comment_likes boolean not null default false,
  followers boolean not null default false,
  likes boolean not null default true
);

-- ============================================================
-- INDEXES
-- ============================================================
create index if not exists idx_posts_author on public.posts(author_id);
create index if not exists idx_post_comments_post on public.post_comments(post_id);
create index if not exists idx_theses_book on public.theses(book_id);
create index if not exists idx_reading_progress_profile on public.reading_progress(profile_id);
create index if not exists idx_follows_follower on public.follows(follower_id);
create index if not exists idx_follows_followee on public.follows(followee_id);
create index if not exists idx_messages_conversation on public.messages(conversation_id);
create index if not exists idx_notifications_recipient on public.notifications(recipient_id);

-- ============================================================
-- FUNCTION: auto-create profile row when a new auth user signs up
-- ============================================================
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
declare
  base_username text;
  final_username text;
  suffix int := 0;
begin
  base_username := coalesce(
    nullif(new.raw_user_meta_data->>'username', ''),
    split_part(new.email, '@', 1)
  );
  final_username := base_username;

  -- username is UNIQUE; a collision here would abort the auth.users insert and
  -- surface as "Database error saving new user", so de-duplicate instead.
  while exists (select 1 from public.profiles p where p.username = final_username) loop
    suffix := suffix + 1;
    final_username := base_username || suffix::text;
  end loop;

  insert into public.profiles (id, username, full_name, role)
  values (
    new.id,
    final_username,
    new.raw_user_meta_data->>'full_name',
    coalesce(nullif(new.raw_user_meta_data->>'role', ''), 'reader')
  )
  on conflict (id) do nothing;

  insert into public.notification_settings (profile_id)
  values (new.id)
  on conflict (profile_id) do nothing;

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ============================================================
-- FUNCTION + TRIGGERS: keep counters in sync
-- ============================================================
create or replace function public.increment_followers()
returns trigger language plpgsql as $$
begin
  update public.profiles set following_count = following_count + 1 where id = new.follower_id;
  update public.profiles set followers_count = followers_count + 1 where id = new.followee_id;
  return new;
end;
$$;

create or replace function public.decrement_followers()
returns trigger language plpgsql as $$
begin
  update public.profiles set following_count = greatest(following_count - 1, 0) where id = old.follower_id;
  update public.profiles set followers_count = greatest(followers_count - 1, 0) where id = old.followee_id;
  return old;
end;
$$;

drop trigger if exists on_follow_insert on public.follows;
create trigger on_follow_insert after insert on public.follows
  for each row execute function public.increment_followers();

drop trigger if exists on_follow_delete on public.follows;
create trigger on_follow_delete after delete on public.follows
  for each row execute function public.decrement_followers();

-- ============================================================
-- FUNCTION + TRIGGERS: keep updated_at current
-- ============================================================
create or replace function public.touch_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists on_profiles_updated on public.profiles;
create trigger on_profiles_updated before update on public.profiles
  for each row execute function public.touch_updated_at();

drop trigger if exists on_reading_progress_updated on public.reading_progress;
create trigger on_reading_progress_updated before update on public.reading_progress
  for each row execute function public.touch_updated_at();

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================
alter table public.profiles enable row level security;
alter table public.genres enable row level security;
alter table public.profile_genres enable row level security;
alter table public.books enable row level security;
alter table public.book_reviews enable row level security;
alter table public.reading_progress enable row level security;
alter table public.posts enable row level security;
alter table public.post_likes enable row level security;
alter table public.post_comments enable row level security;
alter table public.theses enable row level security;
alter table public.follows enable row level security;
alter table public.rooms enable row level security;
alter table public.room_participants enable row level security;
alter table public.conversations enable row level security;
alter table public.conversation_participants enable row level security;
alter table public.messages enable row level security;
alter table public.notifications enable row level security;
alter table public.notification_settings enable row level security;

-- PROFILES: publicly readable, only owner can update their own row
drop policy if exists "Profiles are viewable by everyone" on public.profiles;
create policy "Profiles are viewable by everyone" on public.profiles for select using (true);

drop policy if exists "Users can update own profile" on public.profiles;
create policy "Users can update own profile" on public.profiles for update
  using (auth.uid() = id) with check (auth.uid() = id);

-- The signup trigger inserts profiles as SECURITY DEFINER (bypassing RLS), but
-- this lets a client self-heal a missing profile row via upsert.
drop policy if exists "Users can insert own profile" on public.profiles;
create policy "Users can insert own profile" on public.profiles for insert
  with check (auth.uid() = id);

-- GENRES: publicly readable
drop policy if exists "Genres are viewable by everyone" on public.genres;
create policy "Genres are viewable by everyone" on public.genres for select using (true);

-- PROFILE_GENRES: owner manages their own selections, everyone can read
drop policy if exists "Profile genres are viewable by everyone" on public.profile_genres;
create policy "Profile genres are viewable by everyone" on public.profile_genres for select using (true);

drop policy if exists "Users manage own genres" on public.profile_genres;
create policy "Users manage own genres" on public.profile_genres for all
  using (auth.uid() = profile_id) with check (auth.uid() = profile_id);

-- BOOKS: publicly readable, authors manage their own books
drop policy if exists "Books are viewable by everyone" on public.books;
create policy "Books are viewable by everyone" on public.books for select using (true);

drop policy if exists "Authors manage own books" on public.books;
create policy "Authors manage own books" on public.books for all
  using (auth.uid() = author_id) with check (auth.uid() = author_id);

-- BOOK_REVIEWS: publicly readable, owner manages own review
drop policy if exists "Reviews are viewable by everyone" on public.book_reviews;
create policy "Reviews are viewable by everyone" on public.book_reviews for select using (true);

drop policy if exists "Users manage own reviews" on public.book_reviews;
create policy "Users manage own reviews" on public.book_reviews for all
  using (auth.uid() = profile_id) with check (auth.uid() = profile_id);

-- READING_PROGRESS: only the owner can see/manage their own progress
drop policy if exists "Users manage own reading progress" on public.reading_progress;
create policy "Users manage own reading progress" on public.reading_progress for all
  using (auth.uid() = profile_id) with check (auth.uid() = profile_id);

-- POSTS: publicly readable, owner manages own posts
drop policy if exists "Posts are viewable by everyone" on public.posts;
create policy "Posts are viewable by everyone" on public.posts for select using (true);

drop policy if exists "Users manage own posts" on public.posts;
create policy "Users manage own posts" on public.posts for all
  using (auth.uid() = author_id) with check (auth.uid() = author_id);

-- POST_LIKES: publicly readable, owner manages own like
drop policy if exists "Post likes are viewable by everyone" on public.post_likes;
create policy "Post likes are viewable by everyone" on public.post_likes for select using (true);

drop policy if exists "Users manage own post likes" on public.post_likes;
create policy "Users manage own post likes" on public.post_likes for all
  using (auth.uid() = profile_id) with check (auth.uid() = profile_id);

-- POST_COMMENTS: publicly readable, owner manages own comments
drop policy if exists "Post comments are viewable by everyone" on public.post_comments;
create policy "Post comments are viewable by everyone" on public.post_comments for select using (true);

drop policy if exists "Users manage own comments" on public.post_comments;
create policy "Users manage own comments" on public.post_comments for all
  using (auth.uid() = profile_id) with check (auth.uid() = profile_id);

-- THESES: publicly readable, owner manages own theses
drop policy if exists "Theses are viewable by everyone" on public.theses;
create policy "Theses are viewable by everyone" on public.theses for select using (true);

drop policy if exists "Users manage own theses" on public.theses;
create policy "Users manage own theses" on public.theses for all
  using (auth.uid() = profile_id) with check (auth.uid() = profile_id);

-- FOLLOWS: publicly readable, follower manages their own follow rows
drop policy if exists "Follows are viewable by everyone" on public.follows;
create policy "Follows are viewable by everyone" on public.follows for select using (true);

drop policy if exists "Users manage own follows" on public.follows;
create policy "Users manage own follows" on public.follows for all
  using (auth.uid() = follower_id) with check (auth.uid() = follower_id);

-- ROOMS: publicly readable, creator manages own rooms
drop policy if exists "Rooms are viewable by everyone" on public.rooms;
create policy "Rooms are viewable by everyone" on public.rooms for select using (true);

drop policy if exists "Creators manage own rooms" on public.rooms;
create policy "Creators manage own rooms" on public.rooms for all
  using (auth.uid() = created_by) with check (auth.uid() = created_by);

-- ROOM_PARTICIPANTS: publicly readable, users manage their own participation row
drop policy if exists "Room participants are viewable by everyone" on public.room_participants;
create policy "Room participants are viewable by everyone" on public.room_participants for select using (true);

drop policy if exists "Users manage own room participation" on public.room_participants;
create policy "Users manage own room participation" on public.room_participants for all
  using (auth.uid() = profile_id) with check (auth.uid() = profile_id);

-- CONVERSATIONS + PARTICIPANTS + MESSAGES: only visible to participants
--
-- NOTE: a policy on conversation_participants cannot itself query
-- conversation_participants -- Postgres raises "infinite recursion detected in
-- policy for relation". This SECURITY DEFINER helper bypasses RLS for the
-- membership lookup, which breaks the recursion.
create or replace function public.is_conversation_participant(target_conversation_id uuid)
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select exists (
    select 1 from public.conversation_participants cp
    where cp.conversation_id = target_conversation_id
      and cp.profile_id = auth.uid()
  );
$$;

drop policy if exists "Participants can view their conversations" on public.conversations;
create policy "Participants can view their conversations" on public.conversations for select
  using (public.is_conversation_participant(id));

drop policy if exists "Anyone authenticated can create a conversation" on public.conversations;
create policy "Anyone authenticated can create a conversation" on public.conversations for insert
  with check (auth.uid() is not null);

-- Users see their own membership rows, plus the rows of anyone in a
-- conversation they belong to.
drop policy if exists "Participants can view participant rows" on public.conversation_participants;
create policy "Participants can view participant rows" on public.conversation_participants for select
  using (
    profile_id = auth.uid()
    or public.is_conversation_participant(conversation_id)
  );

drop policy if exists "Users can add themselves to a conversation" on public.conversation_participants;
create policy "Users can add themselves to a conversation" on public.conversation_participants for insert
  with check (auth.uid() = profile_id);

drop policy if exists "Participants can view messages" on public.messages;
create policy "Participants can view messages" on public.messages for select
  using (public.is_conversation_participant(conversation_id));

drop policy if exists "Participants can send messages" on public.messages;
create policy "Participants can send messages" on public.messages for insert with check (
  auth.uid() = sender_id
  and public.is_conversation_participant(conversation_id)
);

-- NOTIFICATIONS: only the recipient can see their own notifications
drop policy if exists "Users can view own notifications" on public.notifications;
create policy "Users can view own notifications" on public.notifications for select using (auth.uid() = recipient_id);

drop policy if exists "Users can update own notifications" on public.notifications;
create policy "Users can update own notifications" on public.notifications for update using (auth.uid() = recipient_id);

drop policy if exists "Authenticated users can create notifications" on public.notifications;
create policy "Authenticated users can create notifications" on public.notifications for insert
  with check (auth.uid() = actor_id);

-- NOTIFICATION_SETTINGS: owner only
drop policy if exists "Users manage own notification settings" on public.notification_settings;
create policy "Users manage own notification settings" on public.notification_settings for all
  using (auth.uid() = profile_id) with check (auth.uid() = profile_id);

-- ============================================================
-- SEED DATA: genres used on the "Select your fiction" screen
-- ============================================================
insert into public.genres (name) values
  ('Literary Fiction'),
  ('Historical Fiction'),
  ('Romance'),
  ('Fantasy'),
  ('Science Fiction (Sci-Fi)'),
  ('Children''s Fiction'),
  ('Horror'),
  ('Adventure')
on conflict (name) do nothing;
