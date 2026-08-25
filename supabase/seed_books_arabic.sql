-- Kiteby -- Arabic book seed data
-- Run AFTER schema.sql (and alongside seed_books.sql, in any order).
--
-- Every row is a real, published Arabic-language book with its actual author.
-- `title` holds the Arabic title so it renders natively in the app; the
-- description opens with the English/transliterated title for search and for
-- users reading the app in English.
--
-- Ratings are plausible placeholder values, not real aggregate scores.
--
-- Safe to re-run: matched on (title, author_name), so repeats update in place.

-- ============================================================
-- Genres used below.
-- schema.sql seeds the fiction genres; seed_books.sql adds the non-fiction
-- ones. This file re-asserts the ones it needs so it can run standalone.
-- ============================================================
insert into public.genres (name) values
  ('Classics'),
  ('Literary Fiction'),
  ('Historical Fiction'),
  ('Biography & Memoir'),
  ('Philosophy'),
  ('History'),
  ('Poetry'),
  ('Self-Help'),
  ('Mystery & Thriller'),
  ('Science Fiction (Sci-Fi)'),
  ('Children''s Fiction'),
  ('Horror'),
  ('Adventure')
on conflict (name) do nothing;

-- Needed for the idempotent upsert below (also created by seed_books.sql).
create unique index if not exists idx_books_title_author
  on public.books (title, author_name);

-- ============================================================
-- ARABIC BOOKS
-- ============================================================
with seed(title, author_name, genre_name, rating, reviews_count, cover_color, description) as (
  values
  -- ---------- Naguib Mahfouz (Nobel laureate, 1988) ----------
  ('أولاد حارتنا', 'نجيب محفوظ', 'Literary Fiction', 4.4, 18600, '#8D6A4F', 'Children of the Alley (Awlad Haratina) — an allegory of faith and power told through one Cairo alley.'),
  ('بين القصرين', 'نجيب محفوظ', 'Literary Fiction', 4.7, 24300, '#7F5539', 'Palace Walk (Bayn al-Qasrayn) — first volume of the Cairo Trilogy.'),
  ('قصر الشوق', 'نجيب محفوظ', 'Literary Fiction', 4.6, 17800, '#9C6644', 'Palace of Desire (Qasr al-Shawq) — second volume of the Cairo Trilogy.'),
  ('السكرية', 'نجيب محفوظ', 'Literary Fiction', 4.6, 15900, '#B08968', 'Sugar Street (Al-Sukkariyya) — final volume of the Cairo Trilogy.'),
  ('زقاق المدق', 'نجيب محفوظ', 'Literary Fiction', 4.5, 19400, '#BC6C25', 'Midaq Alley (Zuqaq al-Midaqq) — life in a crowded Cairo alley during WWII.'),
  ('اللص والكلاب', 'نجيب محفوظ', 'Literary Fiction', 4.4, 14700, '#3A3A3A', 'The Thief and the Dogs (Al-Liss wa al-Kilab) — an ex-convict seeks revenge.'),
  ('الحرافيش', 'نجيب محفوظ', 'Literary Fiction', 4.6, 13200, '#5C4033', 'The Harafish — generations of a futuwwa clan across time.'),
  ('ثرثرة فوق النيل', 'نجيب محفوظ', 'Literary Fiction', 4.3, 11800, '#457B9D', 'Adrift on the Nile (Tharthara fawq al-Nil) — drifting intellectuals on a houseboat.'),
  ('ميرامار', 'نجيب محفوظ', 'Literary Fiction', 4.2, 9600, '#0077B6', 'Miramar — one Alexandria pension seen through four narrators.'),
  ('رحلة ابن فطومة', 'نجيب محفوظ', 'Literary Fiction', 4.3, 8900, '#E9C46A', 'The Journey of Ibn Fattouma — an allegorical voyage through imagined lands.'),

  -- ---------- Modern Arabic literary fiction ----------
  ('موسم الهجرة إلى الشمال', 'الطيب صالح', 'Literary Fiction', 4.5, 21700, '#14213D', 'Season of Migration to the North — a Sudanese man returns from Europe.'),
  ('عرس الزين', 'الطيب صالح', 'Literary Fiction', 4.2, 7400, '#F4A261', 'The Wedding of Zein — village life in northern Sudan.'),
  ('عمارة يعقوبيان', 'علاء الأسواني', 'Literary Fiction', 4.3, 24800, '#8B4513', 'The Yacoubian Building — a downtown Cairo building as a portrait of Egypt.'),
  ('شيكاغو', 'علاء الأسواني', 'Literary Fiction', 4.0, 12300, '#3D5A80', 'Chicago — Egyptian students and expatriates in the United States.'),
  ('ذاكرة الجسد', 'أحلام مستغانمي', 'Literary Fiction', 4.5, 28600, '#9E2A2B', 'The Bridges of Constantine (Dhakirat al-Jasad) — memory, exile, and Algeria.'),
  ('فوضى الحواس', 'أحلام مستغانمي', 'Literary Fiction', 4.4, 19200, '#C1121F', 'Chaos of the Senses — the sequel to The Bridges of Constantine.'),
  ('عابر سرير', 'أحلام مستغانمي', 'Literary Fiction', 4.3, 14100, '#780000', 'Bed Hopper — the closing volume of Mosteghanemi''s trilogy.'),
  ('رجال في الشمس', 'غسان كنفاني', 'Literary Fiction', 4.6, 16400, '#BB3E03', 'Men in the Sun — three Palestinians smuggled across the desert.'),
  ('عائد إلى حيفا', 'غسان كنفاني', 'Literary Fiction', 4.6, 13800, '#606C38', 'Returning to Haifa — a couple revisits the home they fled in 1948.'),
  ('ساق البامبو', 'سعود السنعوسي', 'Literary Fiction', 4.5, 22900, '#2D6A4F', 'The Bamboo Stalk — a Kuwaiti-Filipino son between two countries.'),
  ('فرانكشتاين في بغداد', 'أحمد سعداوي', 'Horror', 4.1, 15600, '#3C1518', 'Frankenstein in Baghdad — a body stitched from bombing victims.'),
  ('واحة الغروب', 'بهاء طاهر', 'Historical Fiction', 4.2, 9800, '#E76F51', 'Sunset Oasis — an Egyptian officer posted to Siwa.'),
  ('عزازيل', 'يوسف زيدان', 'Historical Fiction', 4.3, 18700, '#5F0F40', 'Azazeel — a fifth-century monk''s confessions.'),
  ('الفيل الأزرق', 'أحمد مراد', 'Mystery & Thriller', 4.3, 26400, '#1D3557', 'The Blue Elephant — a psychiatrist confronts an old friend.'),
  ('تراب الماس', 'أحمد مراد', 'Mystery & Thriller', 4.2, 17300, '#212529', 'Diamond Dust — a pharmacist uncovers his father''s secret.'),
  ('يوتوبيا', 'أحمد خالد توفيق', 'Science Fiction (Sci-Fi)', 4.1, 21800, '#495057', 'Utopia — a walled-off Egyptian elite in 2023.'),
  ('في قلبي أنثى عبرية', 'خولة حمدي', 'Literary Fiction', 4.4, 16200, '#B5838D', 'A Hebrew Woman in My Heart — a Tunisian novel of faith and identity.'),
  ('الخبز الحافي', 'محمد شكري', 'Biography & Memoir', 4.3, 14900, '#22333B', 'For Bread Alone (Al-Khubz al-Hafi) — a raw memoir of Moroccan street childhood.'),
  ('اللجنة', 'صنع الله إبراهيم', 'Literary Fiction', 4.1, 6700, '#4A4A4A', 'The Committee — a man interrogated by an inscrutable body.'),
  ('تلك الرائحة', 'صنع الله إبراهيم', 'Literary Fiction', 4.0, 5400, '#6C757D', 'That Smell — a released prisoner drifts through Cairo.'),
  ('الحب في المنفى', 'بهاء طاهر', 'Literary Fiction', 4.1, 6900, '#2F3E46', 'Love in Exile — an Egyptian journalist abroad.'),
  ('باب الشمس', 'إلياس خوري', 'Historical Fiction', 4.4, 11700, '#344E41', 'Gate of the Sun — Palestinian memory told at a hospital bedside.'),
  ('حكاية زهرة', 'حنان الشيخ', 'Literary Fiction', 4.0, 7800, '#B56576', 'The Story of Zahra — a woman inside the Lebanese civil war.'),
  ('طوق الحمام', 'رجاء عالم', 'Literary Fiction', 4.0, 6300, '#7B2CBF', 'The Dove''s Necklace — a death in an old Mecca alley.'),
  ('بنات الرياض', 'رجاء الصانع', 'Literary Fiction', 3.8, 14600, '#F72585', 'Girls of Riyadh — four young Saudi women, told in emails.'),
  ('مدن الملح', 'عبد الرحمن منيف', 'Literary Fiction', 4.5, 12400, '#C77D3A', 'Cities of Salt — oil transforms a Gulf desert community.'),
  ('شرق المتوسط', 'عبد الرحمن منيف', 'Literary Fiction', 4.4, 10800, '#8B2500', 'East of the Mediterranean — political imprisonment and its aftermath.'),
  ('رأيت رام الله', 'مريد البرغوثي', 'Biography & Memoir', 4.4, 8200, '#588157', 'I Saw Ramallah — a poet''s return after thirty years of exile.'),
  ('الطنطورية', 'رضوى عاشور', 'Historical Fiction', 4.5, 11300, '#9D0208', 'The Woman from Tantoura — a Palestinian village and the decades after.'),
  ('ثلاثية غرناطة', 'رضوى عاشور', 'Historical Fiction', 4.6, 13700, '#D4AF37', 'Granada Trilogy — Muslim families after the fall of Granada.'),
  ('الطريق إلى الجنة', 'إبراهيم الكوني', 'Literary Fiction', 4.1, 5900, '#E9B44C', 'A novel of the Tuareg and the Libyan desert.'),
  ('نزيف الحجر', 'إبراهيم الكوني', 'Literary Fiction', 4.2, 6800, '#A0522D', 'The Bleeding of the Stone — a herdsman and the Saharan wild.'),

  -- ---------- Classical Arabic literature ----------
  ('ألف ليلة وليلة', 'مؤلف مجهول', 'Classics', 4.6, 42800, '#7209B7', 'One Thousand and One Nights — the frame tales of Scheherazade.'),
  ('كليلة ودمنة', 'عبد الله بن المقفع', 'Classics', 4.5, 21600, '#2D6A4F', 'Kalila wa-Dimna — animal fables on statecraft and wisdom.'),
  ('مقدمة ابن خلدون', 'ابن خلدون', 'History', 4.7, 31400, '#5C677D', 'The Muqaddimah — the foundational work of social history.'),
  ('رحلة ابن بطوطة', 'ابن بطوطة', 'History', 4.5, 18900, '#BC6C25', 'The Travels of Ibn Battuta (Al-Rihla) — three decades across the known world.'),
  ('رسالة الغفران', 'أبو العلاء المعري', 'Classics', 4.3, 8700, '#463F3A', 'The Epistle of Forgiveness — a satirical journey through the afterlife.'),
  ('لزوم ما لا يلزم', 'أبو العلاء المعري', 'Poetry', 4.4, 6900, '#22223B', 'Luzumiyyat — austere philosophical verse.'),
  ('ديوان المتنبي', 'أبو الطيب المتنبي', 'Poetry', 4.8, 27300, '#780000', 'The Diwan of Al-Mutanabbi — the towering classical Arabic poet.'),
  ('البخلاء', 'الجاحظ', 'Classics', 4.3, 9400, '#8A6D1E', 'The Book of Misers — comic sketches of stinginess.'),
  ('كتاب الحيوان', 'الجاحظ', 'Classics', 4.2, 5600, '#606C38', 'The Book of Animals — a sprawling work of natural history and adab.'),
  ('طوق الحمامة', 'ابن حزم الأندلسي', 'Classics', 4.5, 12800, '#B5E48C', 'The Ring of the Dove — a treatise on love from al-Andalus.'),
  ('حي بن يقظان', 'ابن طفيل', 'Philosophy', 4.4, 10200, '#40916C', 'Hayy ibn Yaqzan — a boy reasons his way to truth alone on an island.'),
  ('إحياء علوم الدين', 'أبو حامد الغزالي', 'Philosophy', 4.7, 19700, '#264653', 'The Revival of the Religious Sciences — al-Ghazali''s major work.'),
  ('المنقذ من الضلال', 'أبو حامد الغزالي', 'Philosophy', 4.6, 11400, '#023047', 'Deliverance from Error — a spiritual and intellectual autobiography.'),
  ('مثنوي', 'جلال الدين الرومي', 'Poetry', 4.8, 34600, '#E9A94F', 'The Masnavi — Rumi''s great poem of Sufi teaching.'),
  ('الأيام', 'طه حسين', 'Biography & Memoir', 4.6, 22400, '#F2E8D5', 'The Days (Al-Ayyam) — the blind scholar''s celebrated autobiography.'),
  ('دعاء الكروان', 'طه حسين', 'Literary Fiction', 4.3, 9800, '#DDA15E', 'The Call of the Curlew — a young woman seeks justice for her sister.'),
  ('النبي', 'جبران خليل جبران', 'Philosophy', 4.7, 46200, '#F4F1EA', 'The Prophet — Gibran''s prose-poem on love, work, and loss.'),
  ('الأجنحة المتكسرة', 'جبران خليل جبران', 'Literary Fiction', 4.4, 18300, '#DDBEA9', 'The Broken Wings — a love thwarted by convention in Beirut.'),
  ('الأرواح المتمردة', 'جبران خليل جبران', 'Literary Fiction', 4.3, 12700, '#B08968', 'Spirits Rebellious — four stories against injustice.'),
  ('حديث المساء', 'ميخائيل نعيمة', 'Literary Fiction', 4.2, 5800, '#457B9D', 'Evening Talk — essays and reflections from the Mahjar school.'),

  -- ---------- Poetry (modern) ----------
  ('ديوان محمود درويش', 'محمود درويش', 'Poetry', 4.8, 38700, '#606C38', 'Collected poems of Palestine''s national poet.'),
  ('جدارية', 'محمود درويش', 'Poetry', 4.7, 16400, '#A8DADC', 'Mural — a long poem written after a near-death experience.'),
  ('في حضرة الغياب', 'محمود درويش', 'Poetry', 4.7, 14900, '#8ECAE6', 'In the Presence of Absence — a self-elegy in prose poetry.'),
  ('قصائد نزار قباني', 'نزار قباني', 'Poetry', 4.6, 41200, '#EF476F', 'Collected poems of the Syrian poet of love and politics.'),
  ('قالت لي السمراء', 'نزار قباني', 'Poetry', 4.4, 17800, '#F4ACB7', 'The Brunette Told Me — Qabbani''s debut collection.'),
  ('أشعار أحمد شوقي', 'أحمد شوقي', 'Poetry', 4.6, 19300, '#D4AF37', 'The collected verse of the "Prince of Poets".'),
  ('أشعار بدر شاكر السياب', 'بدر شاكر السياب', 'Poetry', 4.5, 12600, '#0077B6', 'Poems by a founder of Arabic free verse, incl. "Rain Song".'),
  ('أشعار أدونيس', 'أدونيس', 'Poetry', 4.3, 11800, '#3A0CA3', 'Selected poems of the Syrian modernist Adonis.'),
  ('أعمال أبو القاسم الشابي', 'أبو القاسم الشابي', 'Poetry', 4.7, 15400, '#2A9D8F', 'The works of Tunisia''s national poet, incl. "The Will to Live".'),

  -- ---------- Thought, history and essays ----------
  ('لا تحزن', 'عائض القرني', 'Self-Help', 4.4, 38900, '#8ECAE6', 'Don''t Be Sad — a widely read book of consolation and advice.'),
  ('الرحيق المختوم', 'صفي الرحمن المباركفوري', 'History', 4.8, 29400, '#2D6A4F', 'The Sealed Nectar — an award-winning biography of the Prophet.'),
  ('فقه السيرة', 'محمد الغزالي', 'History', 4.6, 14700, '#1B4332', 'Understanding the Life of the Prophet.'),
  ('تاريخ الطبري', 'محمد بن جرير الطبري', 'History', 4.6, 12300, '#7F5539', 'The History of al-Tabari — a foundational universal chronicle.'),
  ('البداية والنهاية', 'ابن كثير', 'History', 4.6, 15800, '#5C4033', 'The Beginning and the End — history from creation onward.'),
  ('نقد العقل العربي', 'محمد عابد الجابري', 'Philosophy', 4.3, 8600, '#3D405B', 'Critique of Arab Reason — a landmark study of Arab thought.'),
  ('الاستشراق', 'إدوارد سعيد', 'Philosophy', 4.5, 24700, '#14213D', 'Orientalism — how the West constructed "the Orient".'),
  ('الثقافة والإمبريالية', 'إدوارد سعيد', 'Philosophy', 4.3, 12900, '#22333B', 'Culture and Imperialism — empire and the novel.'),
  ('شروط النهضة', 'مالك بن نبي', 'Philosophy', 4.5, 9700, '#264653', 'The Conditions of Renaissance — on civilizational revival.'),
  ('مشكلة الأفكار في العالم الإسلامي', 'مالك بن نبي', 'Philosophy', 4.4, 6800, '#0B132B', 'The Problem of Ideas in the Muslim World.'),
  ('المرأة واللغة', 'عبد الله الغذامي', 'Philosophy', 4.1, 4900, '#B5838D', 'Women and Language — gender in Arabic cultural discourse.'),
  ('الإسلام بين الشرق والغرب', 'علي عزت بيغوفيتش', 'Philosophy', 4.6, 11200, '#588157', 'Islam Between East and West.'),
  ('قصة الحضارة', 'ول ديورانت', 'History', 4.7, 18400, '#E9C46A', 'The Story of Civilization — the classic survey, in its Arabic edition.'),

  -- ---------- Children''s / young readers ----------
  ('كتاب الأمير الصغير', 'أنطوان دو سانت إكزوبيري', 'Children''s Fiction', 4.7, 26800, '#FFD166', 'The Little Prince, Arabic edition.'),
  ('سلسلة المغامرون الخمسة', 'محمود سالم', 'Children''s Fiction', 4.5, 14300, '#F77F00', 'The Five Adventurers — a beloved Arabic youth mystery series.'),
  ('سلسلة ما وراء الطبيعة', 'أحمد خالد توفيق', 'Horror', 4.7, 34200, '#0B0B0B', 'Paranormal (Ma Wara al-Tabiaa) — Dr. Refaat Ismail''s casebook.'),
  ('سلسلة سفاري', 'أحمد خالد توفيق', 'Adventure', 4.4, 12700, '#40916C', 'Safari — a doctor''s adventures with an African medical mission.')
)
insert into public.books (title, author_name, description, cover_color, rating, reviews_count, genre_id)
select
  s.title,
  s.author_name,
  s.description,
  s.cover_color,
  s.rating,
  s.reviews_count,
  g.id
from seed s
left join public.genres g on g.name = s.genre_name
on conflict (title, author_name) do update set
  description   = excluded.description,
  cover_color   = excluded.cover_color,
  rating        = excluded.rating,
  reviews_count = excluded.reviews_count,
  genre_id      = excluded.genre_id;

-- ============================================================
-- Sanity checks
-- ============================================================
-- Total books after seeding:
--   select count(*) from public.books;
-- Any book that failed to match a genre (should return 0 rows):
--   select title, author_name from public.books where genre_id is null;
-- Just the Arabic titles:
--   select title, author_name from public.books where title ~ '[؀-ۿ]' order by author_name;
