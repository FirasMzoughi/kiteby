-- Kiteby book seed data
-- Run AFTER schema.sql, in the Supabase SQL editor.
--
-- Every row below is a real, published book with its actual author. Ratings are
-- plausible placeholder values, not real aggregate scores.
--
-- Safe to re-run: books are matched on (title, author_name), so repeated runs
-- update the existing rows instead of creating duplicates.

-- ============================================================
-- Extra genres referenced by this seed
-- schema.sql seeds the fiction genres shown on the signup screen; these cover
-- the non-fiction titles below.
-- ============================================================
insert into public.genres (name) values
  ('Mystery & Thriller'),
  ('Classics'),
  ('Biography & Memoir'),
  ('Business & Finance'),
  ('Self-Help'),
  ('History'),
  ('Science'),
  ('Philosophy'),
  ('Poetry')
on conflict (name) do nothing;

-- ============================================================
-- A unique index on (title, author_name) makes the upsert below idempotent.
-- ============================================================
create unique index if not exists idx_books_title_author
  on public.books (title, author_name);

-- ============================================================
-- BOOKS
-- ============================================================
with seed(title, author_name, genre_name, rating, reviews_count, cover_color, description) as (
  values
  -- ---------- Business & Finance ----------
  ('The Psychology of Money', 'Morgan Housel', 'Business & Finance', 4.7, 28400, '#F4F1EA', 'Timeless lessons on wealth, greed, and happiness.'),
  ('Rich Dad Poor Dad', 'Robert T. Kiyosaki', 'Business & Finance', 4.6, 51200, '#3B2E86', 'What the rich teach their kids about money.'),
  ('The Intelligent Investor', 'Benjamin Graham', 'Business & Finance', 4.6, 19800, '#1F3A5F', 'The definitive book on value investing.'),
  ('Think and Grow Rich', 'Napoleon Hill', 'Business & Finance', 4.5, 33100, '#8A6D1E', 'The classic on the mindset behind personal achievement.'),
  ('The Millionaire Next Door', 'Thomas J. Stanley', 'Business & Finance', 4.3, 9400, '#2D6A4F', 'The surprising secrets of America''s wealthy.'),
  ('Zero to One', 'Peter Thiel', 'Business & Finance', 4.5, 21700, '#111111', 'Notes on startups, or how to build the future.'),
  ('The Lean Startup', 'Eric Ries', 'Business & Finance', 4.4, 18300, '#1B6B93', 'How constant innovation creates radically successful businesses.'),
  ('Good to Great', 'Jim Collins', 'Business & Finance', 4.4, 14900, '#4A4A4A', 'Why some companies make the leap and others don''t.'),
  ('The $100 Startup', 'Chris Guillebeau', 'Business & Finance', 4.2, 8700, '#F2E8D5', 'Reinvent the way you make a living and create a new future.'),
  ('Shoe Dog', 'Phil Knight', 'Biography & Memoir', 4.8, 24600, '#D64933', 'A memoir by the creator of Nike.'),
  ('Built to Last', 'Jim Collins', 'Business & Finance', 4.3, 7600, '#5C4033', 'Successful habits of visionary companies.'),
  ('Blue Ocean Strategy', 'W. Chan Kim', 'Business & Finance', 4.2, 6900, '#0077B6', 'How to create uncontested market space.'),
  ('The Hard Thing About Hard Things', 'Ben Horowitz', 'Business & Finance', 4.6, 12800, '#1A1A1A', 'Building a business when there are no easy answers.'),
  ('Principles', 'Ray Dalio', 'Business & Finance', 4.5, 16200, '#2B2D42', 'Life and work principles from the founder of Bridgewater.'),
  ('The Barefoot Investor', 'Scott Pape', 'Business & Finance', 4.7, 11400, '#F4A261', 'The only money guide you''ll ever need.'),
  ('Your Money or Your Life', 'Vicki Robin', 'Business & Finance', 4.4, 6300, '#588157', 'Transforming your relationship with money.'),
  ('The Little Book of Common Sense Investing', 'John C. Bogle', 'Business & Finance', 4.6, 9800, '#E9C46A', 'The only way to guarantee your fair share of stock market returns.'),
  ('Never Split the Difference', 'Chris Voss', 'Business & Finance', 4.7, 27300, '#14213D', 'Negotiating as if your life depended on it.'),
  ('Start with Why', 'Simon Sinek', 'Business & Finance', 4.5, 22100, '#E63946', 'How great leaders inspire everyone to take action.'),
  ('Deep Work', 'Cal Newport', 'Business & Finance', 4.6, 19500, '#2A9D8F', 'Rules for focused success in a distracted world.'),

  -- ---------- Self-Help ----------
  ('Atomic Habits', 'James Clear', 'Self-Help', 4.8, 62800, '#F2F2F2', 'An easy and proven way to build good habits and break bad ones.'),
  ('The 7 Habits of Highly Effective People', 'Stephen R. Covey', 'Self-Help', 4.6, 38900, '#1F3A5F', 'Powerful lessons in personal change.'),
  ('The Subtle Art of Not Giving a F*ck', 'Mark Manson', 'Self-Help', 4.4, 47200, '#F26419', 'A counterintuitive approach to living a good life.'),
  ('How to Win Friends and Influence People', 'Dale Carnegie', 'Self-Help', 4.7, 41300, '#FFB703', 'The classic guide to better relationships.'),
  ('The Power of Now', 'Eckhart Tolle', 'Self-Help', 4.6, 29400, '#457B9D', 'A guide to spiritual enlightenment.'),
  ('Ikigai', 'Héctor García', 'Self-Help', 4.4, 25100, '#DCEEF2', 'The Japanese secret to a long and happy life.'),
  ('Mindset', 'Carol S. Dweck', 'Self-Help', 4.5, 18700, '#6A4C93', 'The new psychology of success.'),
  ('The Four Agreements', 'Don Miguel Ruiz', 'Self-Help', 4.7, 22800, '#8ECAE6', 'A practical guide to personal freedom.'),
  ('Man''s Search for Meaning', 'Viktor E. Frankl', 'Self-Help', 4.8, 34600, '#463F3A', 'A psychiatrist''s account of survival and purpose.'),
  ('Can''t Hurt Me', 'David Goggins', 'Biography & Memoir', 4.8, 31200, '#0B0B0B', 'Master your mind and defy the odds.'),
  ('The Alchemist', 'Paulo Coelho', 'Literary Fiction', 4.7, 45800, '#E0782D', 'A fable about following your dream.'),
  ('Steal Like an Artist', 'Austin Kleon', 'Self-Help', 4.5, 14200, '#161616', 'Ten things nobody told you about being creative.'),
  ('Show Your Work!', 'Austin Kleon', 'Self-Help', 4.5, 9600, '#F7B801', 'Ten ways to share your creativity and get discovered.'),
  ('Essentialism', 'Greg McKeown', 'Self-Help', 4.5, 15300, '#FFFFFF', 'The disciplined pursuit of less.'),
  ('The 5 AM Club', 'Robin Sharma', 'Self-Help', 4.2, 12700, '#023047', 'Own your morning, elevate your life.'),
  ('The Monk Who Sold His Ferrari', 'Robin Sharma', 'Self-Help', 4.3, 16800, '#D62828', 'A fable about fulfilling your dreams.'),
  ('Grit', 'Angela Duckworth', 'Self-Help', 4.4, 13900, '#6D6875', 'The power of passion and perseverance.'),
  ('Daring Greatly', 'Brené Brown', 'Self-Help', 4.6, 17400, '#B5838D', 'How the courage to be vulnerable transforms us.'),
  ('The Gifts of Imperfection', 'Brené Brown', 'Self-Help', 4.5, 12100, '#E5989B', 'Let go of who you think you''re supposed to be.'),
  ('Make Your Bed', 'William H. McRaven', 'Self-Help', 4.7, 14600, '#264653', 'Little things that can change your life.'),

  -- ---------- Literary Fiction ----------
  ('To Kill a Mockingbird', 'Harper Lee', 'Classics', 4.8, 58200, '#8D6A4F', 'A story of racial injustice in the American South.'),
  ('The Great Gatsby', 'F. Scott Fitzgerald', 'Classics', 4.4, 49700, '#0A2463', 'A portrait of the Jazz Age.'),
  ('Beloved', 'Toni Morrison', 'Literary Fiction', 4.4, 18300, '#7A0C0C', 'A haunting novel of slavery and memory.'),
  ('Song of Solomon', 'Toni Morrison', 'Literary Fiction', 4.5, 9200, '#B08968', 'A young man''s search for identity.'),
  ('The Bluest Eye', 'Toni Morrison', 'Literary Fiction', 4.3, 11400, '#5F0F40', 'A young Black girl longs for blue eyes.'),
  ('Never Let Me Go', 'Kazuo Ishiguro', 'Literary Fiction', 4.3, 21600, '#A8DADC', 'A quietly devastating story of friendship and fate.'),
  ('The Remains of the Day', 'Kazuo Ishiguro', 'Literary Fiction', 4.4, 14800, '#DDBEA9', 'An English butler reflects on a life of service.'),
  ('Klara and the Sun', 'Kazuo Ishiguro', 'Literary Fiction', 4.1, 12900, '#F6BD60', 'An artificial friend observes the human world.'),
  ('Normal People', 'Sally Rooney', 'Literary Fiction', 4.2, 26400, '#4C956C', 'Two people circle each other over years.'),
  ('Conversations with Friends', 'Sally Rooney', 'Literary Fiction', 4.0, 15700, '#2F3E46', 'Friendship and desire among four people in Dublin.'),
  ('A Little Life', 'Hanya Yanagihara', 'Literary Fiction', 4.4, 23100, '#3D405B', 'Four friends and a lifetime of consequences.'),
  ('The Kite Runner', 'Khaled Hosseini', 'Literary Fiction', 4.7, 42800, '#BC4749', 'A story of friendship and redemption in Afghanistan.'),
  ('A Thousand Splendid Suns', 'Khaled Hosseini', 'Literary Fiction', 4.8, 38200, '#F4A261', 'Two women bound by war and family.'),
  ('And the Mountains Echoed', 'Khaled Hosseini', 'Literary Fiction', 4.5, 19600, '#606C38', 'A family separated across continents.'),
  ('The Road', 'Cormac McCarthy', 'Literary Fiction', 4.5, 27900, '#495057', 'A father and son cross a ruined America.'),
  ('Blood Meridian', 'Cormac McCarthy', 'Literary Fiction', 4.3, 14200, '#8B2500', 'A brutal vision of the American frontier.'),
  ('One Hundred Years of Solitude', 'Gabriel García Márquez', 'Literary Fiction', 4.5, 31700, '#E9B44C', 'The Buendía family across generations in Macondo.'),
  ('Love in the Time of Cholera', 'Gabriel García Márquez', 'Literary Fiction', 4.3, 18400, '#9E2A2B', 'A love story spanning fifty years.'),
  ('The Handmaid''s Tale', 'Margaret Atwood', 'Science Fiction (Sci-Fi)', 4.5, 42300, '#C1121F', 'A dystopia of theocratic control.'),
  ('Oryx and Crake', 'Margaret Atwood', 'Science Fiction (Sci-Fi)', 4.2, 12600, '#4F772D', 'A post-apocalyptic story of genetic engineering.'),
  ('The Goldfinch', 'Donna Tartt', 'Literary Fiction', 4.1, 24800, '#FFD60A', 'A boy, a bombing, and a stolen painting.'),
  ('The Secret History', 'Donna Tartt', 'Literary Fiction', 4.4, 28600, '#344E41', 'A murder among classics students.'),
  ('Life of Pi', 'Yann Martel', 'Literary Fiction', 4.3, 33400, '#F77F00', 'A boy adrift with a Bengal tiger.'),
  ('The Book Thief', 'Markus Zusak', 'Historical Fiction', 4.7, 47200, '#3A3A3A', 'Death narrates a girl''s life in Nazi Germany.'),
  ('Where the Crawdads Sing', 'Delia Owens', 'Literary Fiction', 4.6, 51900, '#606C38', 'A girl raised alone in the marshes of North Carolina.'),
  ('The Night Circus', 'Erin Morgenstern', 'Fantasy', 4.4, 26700, '#1D1D1D', 'A magical competition inside a mysterious circus.'),
  ('Circe', 'Madeline Miller', 'Fantasy', 4.6, 34200, '#E76F51', 'The witch of Aiaia tells her own story.'),
  ('The Song of Achilles', 'Madeline Miller', 'Historical Fiction', 4.7, 41800, '#D4AF37', 'The Iliad retold as a love story.'),
  ('Pachinko', 'Min Jin Lee', 'Historical Fiction', 4.6, 22400, '#7F5539', 'Four generations of a Korean family in Japan.'),
  ('Homegoing', 'Yaa Gyasi', 'Historical Fiction', 4.7, 19800, '#B56576', 'Two half-sisters and three hundred years of consequence.'),
  ('The Vanishing Half', 'Brit Bennett', 'Literary Fiction', 4.3, 27600, '#E5B769', 'Twin sisters choose different racial identities.'),
  ('Turtles All the Way Down', 'John Green', 'Literary Fiction', 4.2, 24300, '#F26419', 'A teenager navigates anxiety and a missing billionaire.'),
  ('The Fault in Our Stars', 'John Green', 'Literary Fiction', 4.5, 56100, '#4361EE', 'Two teenagers meet at a cancer support group.'),
  ('Looking for Alaska', 'John Green', 'Literary Fiction', 4.2, 32800, '#212529', 'A boy seeks the Great Perhaps at boarding school.'),
  ('Little Fires Everywhere', 'Celeste Ng', 'Literary Fiction', 4.3, 29100, '#D00000', 'Two families collide in a orderly Ohio suburb.'),
  ('Everything I Never Told You', 'Celeste Ng', 'Literary Fiction', 4.1, 16400, '#0077B6', 'A family unravels after a daughter''s death.'),
  ('The Namesake', 'Jhumpa Lahiri', 'Literary Fiction', 4.2, 14700, '#BC6C25', 'An Indian-American son and his inherited name.'),
  ('Interpreter of Maladies', 'Jhumpa Lahiri', 'Literary Fiction', 4.3, 11200, '#DDA15E', 'Stories of Indian and Indian-American lives.'),
  ('Half of a Yellow Sun', 'Chimamanda Ngozi Adichie', 'Historical Fiction', 4.6, 17300, '#FFBA08', 'Biafra''s war through intertwined lives.'),
  ('Americanah', 'Chimamanda Ngozi Adichie', 'Literary Fiction', 4.5, 24900, '#9D0208', 'A Nigerian woman''s years in America and return home.'),
  ('Purple Hibiscus', 'Chimamanda Ngozi Adichie', 'Literary Fiction', 4.4, 12800, '#7B2CBF', 'A girl comes of age under a devout, violent father.'),
  ('Things Fall Apart', 'Chinua Achebe', 'Classics', 4.4, 28700, '#8B4513', 'A Nigerian leader confronts colonialism.'),
  ('Lincoln in the Bardo', 'George Saunders', 'Historical Fiction', 3.9, 11600, '#495057', 'Willie Lincoln''s ghost, and a chorus of the dead.'),
  ('The Overstory', 'Richard Powers', 'Literary Fiction', 4.2, 16900, '#2D6A4F', 'Nine strangers drawn together by trees.'),
  ('Cloud Atlas', 'David Mitchell', 'Science Fiction (Sci-Fi)', 4.3, 21400, '#3A506B', 'Six nested stories across centuries.'),
  ('Middlesex', 'Jeffrey Eugenides', 'Literary Fiction', 4.4, 19200, '#9C6644', 'Three generations and a Greek-American secret.'),
  ('The Virgin Suicides', 'Jeffrey Eugenides', 'Literary Fiction', 4.0, 14100, '#F4ACB7', 'Neighborhood boys recall the Lisbon sisters.'),
  ('White Teeth', 'Zadie Smith', 'Literary Fiction', 4.0, 12300, '#EF476F', 'Two wartime friends and their families in London.'),
  ('On Beauty', 'Zadie Smith', 'Literary Fiction', 3.9, 8700, '#118AB2', 'Two rival academic families collide.'),
  ('Exit West', 'Mohsin Hamid', 'Literary Fiction', 4.0, 13800, '#073B4C', 'Two lovers flee through doors that cross the world.'),
  ('The Sympathizer', 'Viet Thanh Nguyen', 'Historical Fiction', 4.1, 12400, '#D62828', 'A double agent after the fall of Saigon.'),

  -- ---------- Mystery & Thriller ----------
  ('Gone Girl', 'Gillian Flynn', 'Mystery & Thriller', 4.3, 48600, '#1B1B1E', 'A wife disappears and a husband becomes a suspect.'),
  ('Sharp Objects', 'Gillian Flynn', 'Mystery & Thriller', 4.1, 24700, '#6A040F', 'A reporter returns home to cover child murders.'),
  ('Dark Places', 'Gillian Flynn', 'Mystery & Thriller', 4.0, 19300, '#212529', 'The survivor of a massacre revisits the night.'),
  ('The Girl with the Dragon Tattoo', 'Stieg Larsson', 'Mystery & Thriller', 4.4, 43800, '#0D1B2A', 'A journalist and a hacker investigate a disappearance.'),
  ('The Silent Patient', 'Alex Michaelides', 'Mystery & Thriller', 4.3, 39200, '#003049', 'A woman shoots her husband and never speaks again.'),
  ('The Da Vinci Code', 'Dan Brown', 'Mystery & Thriller', 4.1, 52400, '#8D0801', 'A symbologist unravels a religious conspiracy.'),
  ('Angels & Demons', 'Dan Brown', 'Mystery & Thriller', 4.2, 38700, '#3C1518', 'A secret brotherhood threatens the Vatican.'),
  ('The Girl on the Train', 'Paula Hawkins', 'Mystery & Thriller', 4.0, 41300, '#2F3E46', 'A commuter witnesses something from the train.'),
  ('Big Little Lies', 'Liane Moriarty', 'Mystery & Thriller', 4.4, 33900, '#E29578', 'Three mothers, one death at a school trivia night.'),
  ('And Then There Were None', 'Agatha Christie', 'Mystery & Thriller', 4.6, 36200, '#22333B', 'Ten strangers die one by one on an island.'),
  ('Murder on the Orient Express', 'Agatha Christie', 'Mystery & Thriller', 4.5, 31800, '#780000', 'Poirot investigates a murder on a stranded train.'),
  ('The Murder of Roger Ackroyd', 'Agatha Christie', 'Mystery & Thriller', 4.5, 18600, '#3E5C76', 'A Poirot mystery with a famous twist.'),
  ('In the Woods', 'Tana French', 'Mystery & Thriller', 4.0, 16400, '#344E41', 'A detective returns to the site of his own trauma.'),
  ('The Thursday Murder Club', 'Richard Osman', 'Mystery & Thriller', 4.3, 28700, '#8ECAE6', 'Four retirees investigate cold cases.'),
  ('The Hound of the Baskervilles', 'Arthur Conan Doyle', 'Mystery & Thriller', 4.5, 24300, '#432818', 'Holmes faces a legendary moorland beast.'),
  ('A Study in Scarlet', 'Arthur Conan Doyle', 'Mystery & Thriller', 4.3, 18900, '#7F1D1D', 'The first meeting of Holmes and Watson.'),
  ('The Talented Mr. Ripley', 'Patricia Highsmith', 'Mystery & Thriller', 4.2, 14700, '#606C38', 'A charming young man assumes another life.'),
  ('Rebecca', 'Daphne du Maurier', 'Mystery & Thriller', 4.5, 27100, '#22223B', 'A new wife haunted by her predecessor.'),
  ('The Guest List', 'Lucy Foley', 'Mystery & Thriller', 3.9, 22400, '#1D3557', 'A wedding on a remote island turns deadly.'),
  ('I Am Pilgrim', 'Terry Hayes', 'Mystery & Thriller', 4.5, 19800, '#0B132B', 'A retired agent hunts a lone terrorist.'),

  -- ---------- Fantasy ----------
  ('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 4.7, 61200, '#2D6A4F', 'Bilbo Baggins joins a quest for a dragon''s hoard.'),
  ('The Fellowship of the Ring', 'J.R.R. Tolkien', 'Fantasy', 4.8, 54900, '#1B4332', 'The Ring leaves the Shire.'),
  ('The Two Towers', 'J.R.R. Tolkien', 'Fantasy', 4.8, 42700, '#2D3A2E', 'The Fellowship broken, the war begins.'),
  ('The Return of the King', 'J.R.R. Tolkien', 'Fantasy', 4.9, 44100, '#D4AF37', 'The final battle for Middle-earth.'),
  ('The Silmarillion', 'J.R.R. Tolkien', 'Fantasy', 4.4, 21300, '#14213D', 'The mythology behind Middle-earth.'),
  ('A Game of Thrones', 'George R.R. Martin', 'Fantasy', 4.6, 58400, '#2B2D42', 'Noble houses vie for the Iron Throne.'),
  ('A Clash of Kings', 'George R.R. Martin', 'Fantasy', 4.6, 41200, '#3D5A80', 'Five kings war for Westeros.'),
  ('A Storm of Swords', 'George R.R. Martin', 'Fantasy', 4.7, 39800, '#780000', 'The war reaches its bloodiest turns.'),
  ('The Name of the Wind', 'Patrick Rothfuss', 'Fantasy', 4.6, 47300, '#5C4033', 'Kvothe recounts how he became a legend.'),
  ('The Wise Man''s Fear', 'Patrick Rothfuss', 'Fantasy', 4.6, 33900, '#3E2723', 'Kvothe''s story continues beyond the University.'),
  ('Mistborn: The Final Empire', 'Brandon Sanderson', 'Fantasy', 4.7, 42600, '#212529', 'A thief crew plots to overthrow a god-emperor.'),
  ('The Way of Kings', 'Brandon Sanderson', 'Fantasy', 4.8, 38400, '#0077B6', 'War on the Shattered Plains.'),
  ('Words of Radiance', 'Brandon Sanderson', 'Fantasy', 4.8, 31200, '#023E8A', 'The second Stormlight Archive volume.'),
  ('Elantris', 'Brandon Sanderson', 'Fantasy', 4.3, 16800, '#7209B7', 'A cursed city and a prince transformed.'),
  ('American Gods', 'Neil Gaiman', 'Fantasy', 4.2, 34700, '#22223B', 'Old gods and new clash across America.'),
  ('Neverwhere', 'Neil Gaiman', 'Fantasy', 4.3, 21400, '#3A0CA3', 'A hidden London beneath the city.'),
  ('Good Omens', 'Neil Gaiman', 'Fantasy', 4.5, 32800, '#E63946', 'An angel and a demon avert the apocalypse.'),
  ('Coraline', 'Neil Gaiman', 'Children''s Fiction', 4.3, 27600, '#264653', 'A girl finds a sinister other version of home.'),
  ('The Ocean at the End of the Lane', 'Neil Gaiman', 'Fantasy', 4.3, 24100, '#1D3557', 'A man remembers a childhood of strange magic.'),
  ('The Lion, the Witch and the Wardrobe', 'C.S. Lewis', 'Children''s Fiction', 4.6, 46200, '#B7791F', 'Four children discover Narnia.'),
  ('The Priory of the Orange Tree', 'Samantha Shannon', 'Fantasy', 4.1, 18300, '#E76F51', 'Dragons, queens, and an ancient threat.'),
  ('A Day of Fallen Night', 'Samantha Shannon', 'Fantasy', 4.4, 9200, '#E9A94F', 'A prequel to the Priory of the Orange Tree.'),
  ('The Bone Season', 'Samantha Shannon', 'Fantasy', 3.9, 11700, '#5F0F40', 'A clairvoyant in a dystopian London.'),
  ('Ninth House', 'Leigh Bardugo', 'Fantasy', 4.1, 22800, '#111111', 'Secret societies and occult murder at Yale.'),
  ('Six of Crows', 'Leigh Bardugo', 'Fantasy', 4.6, 39400, '#1B263B', 'Six outcasts attempt an impossible heist.'),
  ('Shadow and Bone', 'Leigh Bardugo', 'Fantasy', 4.0, 33200, '#0D1B2A', 'A soldier discovers a rare power.'),
  ('The Hundred Thousand Kingdoms', 'N.K. Jemisin', 'Fantasy', 4.1, 12600, '#7B2CBF', 'A mortal heir among enslaved gods.'),
  ('The Fifth Season', 'N.K. Jemisin', 'Fantasy', 4.4, 24700, '#6A040F', 'A world that ends, again and again.'),
  ('Uprooted', 'Naomi Novik', 'Fantasy', 4.3, 21900, '#606C38', 'A village girl taken by a wizard called the Dragon.'),
  ('Spinning Silver', 'Naomi Novik', 'Fantasy', 4.4, 17300, '#B8B8D1', 'A moneylender''s daughter turns silver into gold.'),
  ('Piranesi', 'Susanna Clarke', 'Fantasy', 4.3, 19600, '#A8DADC', 'A man lives in an infinite house of statues.'),
  ('Jonathan Strange & Mr Norrell', 'Susanna Clarke', 'Fantasy', 4.0, 16200, '#22333B', 'Two magicians revive English magic.'),
  ('The Ten Thousand Doors of January', 'Alix E. Harrow', 'Fantasy', 4.1, 13800, '#BC6C25', 'A girl finds doors to other worlds.'),
  ('The House in the Cerulean Sea', 'TJ Klune', 'Fantasy', 4.5, 31700, '#8ECAE6', 'A caseworker visits an orphanage of magical children.'),

  -- ---------- Science Fiction ----------
  ('Dune', 'Frank Herbert', 'Science Fiction (Sci-Fi)', 4.6, 52700, '#C77D3A', 'Paul Atreides and the desert planet Arrakis.'),
  ('Dune Messiah', 'Frank Herbert', 'Science Fiction (Sci-Fi)', 4.2, 24100, '#8B5A2B', 'The cost of Paul''s empire.'),
  ('Children of Dune', 'Frank Herbert', 'Science Fiction (Sci-Fi)', 4.1, 18600, '#A0522D', 'The Atreides twins come of age.'),
  ('Ender''s Game', 'Orson Scott Card', 'Science Fiction (Sci-Fi)', 4.5, 44300, '#0B132B', 'A boy trains to command Earth''s fleet.'),
  ('Foundation', 'Isaac Asimov', 'Science Fiction (Sci-Fi)', 4.4, 32800, '#3A506B', 'Psychohistory predicts an empire''s fall.'),
  ('I, Robot', 'Isaac Asimov', 'Science Fiction (Sci-Fi)', 4.3, 28400, '#5C677D', 'Nine stories about the Three Laws.'),
  ('1984', 'George Orwell', 'Classics', 4.7, 68200, '#B71C1C', 'A totalitarian state watches everything.'),
  ('Animal Farm', 'George Orwell', 'Classics', 4.4, 51600, '#2E7D32', 'Farm animals overthrow their farmer.'),
  ('Brave New World', 'Aldous Huxley', 'Classics', 4.3, 44700, '#00695C', 'A society engineered for happiness.'),
  ('Fahrenheit 451', 'Ray Bradbury', 'Classics', 4.4, 47100, '#D62828', 'A fireman who burns books begins to read.'),
  ('The Martian Chronicles', 'Ray Bradbury', 'Science Fiction (Sci-Fi)', 4.3, 19800, '#AE2012', 'Humanity colonizes Mars.'),
  ('The Martian', 'Andy Weir', 'Science Fiction (Sci-Fi)', 4.7, 46300, '#BB3E03', 'An astronaut stranded on Mars.'),
  ('Project Hail Mary', 'Andy Weir', 'Science Fiction (Sci-Fi)', 4.8, 41900, '#0077B6', 'A lone astronaut must save the sun.'),
  ('Artemis', 'Andy Weir', 'Science Fiction (Sci-Fi)', 3.8, 14200, '#495057', 'A smuggler on the moon takes a risky job.'),
  ('Snow Crash', 'Neal Stephenson', 'Science Fiction (Sci-Fi)', 4.1, 21600, '#3A0CA3', 'A hacker-samurai in the Metaverse.'),
  ('Neuromancer', 'William Gibson', 'Science Fiction (Sci-Fi)', 4.0, 24800, '#10002B', 'A washed-up hacker takes one last job.'),
  ('The Left Hand of Darkness', 'Ursula K. Le Guin', 'Science Fiction (Sci-Fi)', 4.2, 18300, '#457B9D', 'An envoy on a world without fixed gender.'),
  ('A Wizard of Earthsea', 'Ursula K. Le Guin', 'Fantasy', 4.3, 22400, '#014F86', 'A young mage confronts the shadow he loosed.'),
  ('The Dispossessed', 'Ursula K. Le Guin', 'Science Fiction (Sci-Fi)', 4.3, 14700, '#6C757D', 'A physicist between two opposed worlds.'),
  ('Hyperion', 'Dan Simmons', 'Science Fiction (Sci-Fi)', 4.4, 22900, '#4A4E69', 'Seven pilgrims journey to the Time Tombs.'),
  ('The Three-Body Problem', 'Cixin Liu', 'Science Fiction (Sci-Fi)', 4.1, 33600, '#780000', 'First contact begins during the Cultural Revolution.'),
  ('The Dark Forest', 'Cixin Liu', 'Science Fiction (Sci-Fi)', 4.5, 24800, '#1B263B', 'Humanity prepares for an alien fleet.'),
  ('Death''s End', 'Cixin Liu', 'Science Fiction (Sci-Fi)', 4.5, 19700, '#0B0B0B', 'The final act of the Three-Body trilogy.'),
  ('Station Eleven', 'Emily St. John Mandel', 'Science Fiction (Sci-Fi)', 4.1, 28300, '#2F3E46', 'A troupe performs Shakespeare after a pandemic.'),
  ('Sea of Tranquility', 'Emily St. John Mandel', 'Science Fiction (Sci-Fi)', 4.3, 18900, '#A8DADC', 'Time travel across five centuries.'),
  ('Recursion', 'Blake Crouch', 'Science Fiction (Sci-Fi)', 4.5, 22700, '#003049', 'A memory disease that rewrites reality.'),
  ('Dark Matter', 'Blake Crouch', 'Science Fiction (Sci-Fi)', 4.5, 34100, '#0A0A0A', 'A physicist wakes in a life that is not his.'),
  ('The Handmaid''s Tale: The Testaments', 'Margaret Atwood', 'Science Fiction (Sci-Fi)', 4.3, 21400, '#588157', 'Three women inside and against Gilead.'),
  ('Kindred', 'Octavia E. Butler', 'Science Fiction (Sci-Fi)', 4.5, 26800, '#6A040F', 'A Black woman pulled back to an antebellum plantation.'),
  ('Parable of the Sower', 'Octavia E. Butler', 'Science Fiction (Sci-Fi)', 4.3, 22100, '#BB8588', 'A young empath builds a faith amid collapse.'),

  -- ---------- Horror ----------
  ('The Shining', 'Stephen King', 'Horror', 4.5, 44700, '#7F1D1D', 'A caretaker family alone in the Overlook Hotel.'),
  ('It', 'Stephen King', 'Horror', 4.6, 41300, '#C1121F', 'Seven friends face a shape-shifting evil.'),
  ('Misery', 'Stephen King', 'Horror', 4.5, 32800, '#4A4E69', 'A writer held captive by his number one fan.'),
  ('Pet Sematary', 'Stephen King', 'Horror', 4.3, 28600, '#2D3A2E', 'A burial ground that gives back what it takes.'),
  ('Salem''s Lot', 'Stephen King', 'Horror', 4.4, 24200, '#22223B', 'A small Maine town turns to vampires.'),
  ('11/22/63', 'Stephen King', 'Historical Fiction', 4.6, 31700, '#3D405B', 'A teacher travels back to stop the Kennedy assassination.'),
  ('The Stand', 'Stephen King', 'Horror', 4.5, 33900, '#495057', 'A plague, and the survivors who must choose sides.'),
  ('Dracula', 'Bram Stoker', 'Classics', 4.3, 34600, '#3C1518', 'The original vampire novel.'),
  ('Frankenstein', 'Mary Shelley', 'Classics', 4.2, 39100, '#344E41', 'A scientist creates life and abandons it.'),
  ('The Haunting of Hill House', 'Shirley Jackson', 'Horror', 4.1, 21800, '#2B2D42', 'Four people investigate a house that is not sane.'),
  ('We Have Always Lived in the Castle', 'Shirley Jackson', 'Horror', 4.2, 16400, '#606C38', 'Two sisters isolated after a family poisoning.'),
  ('Mexican Gothic', 'Silvia Moreno-Garcia', 'Horror', 4.0, 26300, '#7A0C0C', 'A socialite investigates a decaying manor.'),
  ('The Exorcist', 'William Peter Blatty', 'Horror', 4.4, 18900, '#0B0B0B', 'A mother seeks help for her possessed daughter.'),
  ('Bird Box', 'Josh Malerman', 'Horror', 3.9, 22700, '#1B1B1E', 'A mother and children navigate blindfolded.'),

  -- ---------- Romance ----------
  ('Pride and Prejudice', 'Jane Austen', 'Classics', 4.6, 62400, '#8ECAE6', 'Elizabeth Bennet and Mr. Darcy.'),
  ('Sense and Sensibility', 'Jane Austen', 'Classics', 4.3, 28700, '#B5838D', 'The Dashwood sisters and their prospects.'),
  ('Emma', 'Jane Austen', 'Classics', 4.2, 24100, '#F4ACB7', 'A matchmaker who misreads everyone.'),
  ('Persuasion', 'Jane Austen', 'Classics', 4.4, 21600, '#DDBEA9', 'A second chance at a rejected love.'),
  ('Jane Eyre', 'Charlotte Brontë', 'Classics', 4.5, 44200, '#432818', 'A governess and the secrets of Thornfield Hall.'),
  ('Wuthering Heights', 'Emily Brontë', 'Classics', 4.0, 36800, '#3A3A3A', 'Heathcliff and Catherine on the moors.'),
  ('Outlander', 'Diana Gabaldon', 'Romance', 4.4, 38900, '#40916C', 'A WWII nurse falls through time to 1743 Scotland.'),
  ('Me Before You', 'Jojo Moyes', 'Romance', 4.5, 42300, '#FFB4A2', 'A caregiver and a man who cannot accept his new life.'),
  ('The Notebook', 'Nicholas Sparks', 'Romance', 4.4, 39600, '#E29578', 'A love story remembered across decades.'),
  ('It Ends with Us', 'Colleen Hoover', 'Romance', 4.3, 58400, '#B5E48C', 'A woman confronts a cycle she swore to break.'),
  ('Verity', 'Colleen Hoover', 'Mystery & Thriller', 4.3, 46200, '#6A040F', 'A ghostwriter finds a disturbing manuscript.'),
  ('The Seven Husbands of Evelyn Hugo', 'Taylor Jenkins Reid', 'Historical Fiction', 4.7, 61300, '#D00000', 'An aging film icon finally tells the truth.'),
  ('Daisy Jones & The Six', 'Taylor Jenkins Reid', 'Historical Fiction', 4.4, 42700, '#F4A261', 'An oral history of a band that fell apart.'),
  ('Beach Read', 'Emily Henry', 'Romance', 4.2, 31800, '#FFD166', 'Two rival writers swap genres for a summer.'),
  ('People We Meet on Vacation', 'Emily Henry', 'Romance', 4.3, 34600, '#06D6A0', 'Best friends, ten summers, one falling out.'),
  ('Red, White & Royal Blue', 'Casey McQuiston', 'Romance', 4.4, 33200, '#EF476F', 'The First Son and a British prince.'),
  ('The Hating Game', 'Sally Thorne', 'Romance', 4.2, 27400, '#F72585', 'Two office rivals compete for one promotion.'),

  -- ---------- Historical Fiction ----------
  ('All the Light We Cannot See', 'Anthony Doerr', 'Historical Fiction', 4.6, 47800, '#457B9D', 'A blind French girl and a German boy in WWII.'),
  ('The Nightingale', 'Kristin Hannah', 'Historical Fiction', 4.8, 52100, '#606C38', 'Two sisters resist the occupation of France.'),
  ('The Four Winds', 'Kristin Hannah', 'Historical Fiction', 4.6, 33700, '#BC6C25', 'A mother in the Dust Bowl heads west.'),
  ('The Tattooist of Auschwitz', 'Heather Morris', 'Historical Fiction', 4.5, 38200, '#22333B', 'A prisoner tasked with tattooing arrivals.'),
  ('The Pillars of the Earth', 'Ken Follett', 'Historical Fiction', 4.7, 41600, '#5C4033', 'The building of a cathedral in 12th-century England.'),
  ('Wolf Hall', 'Hilary Mantel', 'Historical Fiction', 4.1, 21300, '#2B2D42', 'Thomas Cromwell rises in Henry VIII''s court.'),
  ('The Help', 'Kathryn Stockett', 'Historical Fiction', 4.7, 49300, '#E9C46A', 'Black maids in 1960s Mississippi tell their stories.'),
  ('Memoirs of a Geisha', 'Arthur Golden', 'Historical Fiction', 4.4, 37800, '#C1121F', 'A fishing village girl becomes a famed geisha.'),
  ('The Nickel Boys', 'Colson Whitehead', 'Historical Fiction', 4.3, 18700, '#344E41', 'Two boys at a brutal Florida reform school.'),
  ('The Underground Railroad', 'Colson Whitehead', 'Historical Fiction', 4.1, 26400, '#3C1518', 'An escape route reimagined as a literal railway.'),

  -- ---------- Children''s Fiction ----------
  ('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 'Children''s Fiction', 4.8, 78200, '#7F1D1D', 'A boy discovers he is a wizard.'),
  ('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 'Children''s Fiction', 4.7, 61400, '#2D6A4F', 'A monster stalks Hogwarts.'),
  ('Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', 'Children''s Fiction', 4.8, 63900, '#3A0CA3', 'An escaped prisoner and a hidden truth.'),
  ('Matilda', 'Roald Dahl', 'Children''s Fiction', 4.7, 42300, '#E63946', 'A gifted girl against a tyrannical headmistress.'),
  ('Charlie and the Chocolate Factory', 'Roald Dahl', 'Children''s Fiction', 4.6, 44700, '#7209B7', 'Five children tour Wonka''s factory.'),
  ('The BFG', 'Roald Dahl', 'Children''s Fiction', 4.6, 31200, '#0077B6', 'A girl and a Big Friendly Giant.'),
  ('The Little Prince', 'Antoine de Saint-Exupéry', 'Children''s Fiction', 4.7, 52800, '#FFD166', 'A pilot meets a boy from another planet.'),
  ('Charlotte''s Web', 'E.B. White', 'Children''s Fiction', 4.7, 38400, '#F4A261', 'A spider saves a pig with words.'),
  ('The Giver', 'Lois Lowry', 'Children''s Fiction', 4.3, 41200, '#6C757D', 'A boy learns the cost of a painless society.'),
  ('Where the Wild Things Are', 'Maurice Sendak', 'Children''s Fiction', 4.6, 29700, '#606C38', 'Max sails to where the wild things are.'),
  ('Wonder', 'R.J. Palacio', 'Children''s Fiction', 4.8, 46300, '#8ECAE6', 'A boy with a facial difference starts school.'),
  ('Percy Jackson & the Olympians: The Lightning Thief', 'Rick Riordan', 'Children''s Fiction', 4.6, 44100, '#023E8A', 'A demigod is accused of stealing Zeus''s bolt.'),
  ('The Hunger Games', 'Suzanne Collins', 'Children''s Fiction', 4.6, 67300, '#212529', 'A girl volunteers for a televised death match.'),
  ('Catching Fire', 'Suzanne Collins', 'Children''s Fiction', 4.7, 51800, '#D62828', 'The victors return to the arena.'),
  ('Mockingjay', 'Suzanne Collins', 'Children''s Fiction', 4.4, 47200, '#495057', 'The districts rise against the Capitol.'),

  -- ---------- Adventure ----------
  ('The Count of Monte Cristo', 'Alexandre Dumas', 'Adventure', 4.7, 38900, '#14213D', 'A wrongly imprisoned man returns for revenge.'),
  ('The Three Musketeers', 'Alexandre Dumas', 'Adventure', 4.4, 27300, '#780000', 'D''Artagnan joins the king''s musketeers.'),
  ('Treasure Island', 'Robert Louis Stevenson', 'Adventure', 4.3, 24800, '#7F5539', 'A boy, a map, and Long John Silver.'),
  ('Moby-Dick', 'Herman Melville', 'Classics', 3.9, 28600, '#22333B', 'Ahab hunts the white whale.'),
  ('The Old Man and the Sea', 'Ernest Hemingway', 'Classics', 4.2, 32400, '#0077B6', 'An old fisherman battles a great marlin.'),
  ('Into the Wild', 'Jon Krakauer', 'Biography & Memoir', 4.2, 29700, '#40916C', 'Chris McCandless walks into the Alaskan wild.'),
  ('Into Thin Air', 'Jon Krakauer', 'Biography & Memoir', 4.5, 26100, '#A8DADC', 'A survivor''s account of the 1996 Everest disaster.'),
  ('Around the World in Eighty Days', 'Jules Verne', 'Adventure', 4.3, 21400, '#E9C46A', 'Phileas Fogg''s wager against the clock.'),
  ('Twenty Thousand Leagues Under the Sea', 'Jules Verne', 'Adventure', 4.1, 19800, '#023E8A', 'Captain Nemo and the Nautilus.'),
  ('Robinson Crusoe', 'Daniel Defoe', 'Classics', 3.9, 17300, '#BC6C25', 'A castaway survives twenty-eight years.'),

  -- ---------- History / Science / Philosophy ----------
  ('Sapiens', 'Yuval Noah Harari', 'History', 4.6, 58700, '#F4F1EA', 'A brief history of humankind.'),
  ('Homo Deus', 'Yuval Noah Harari', 'History', 4.4, 31200, '#264653', 'A brief history of tomorrow.'),
  ('21 Lessons for the 21st Century', 'Yuval Noah Harari', 'History', 4.3, 24600, '#E76F51', 'Confronting the questions of the present.'),
  ('Guns, Germs, and Steel', 'Jared Diamond', 'History', 4.2, 27800, '#606C38', 'The fates of human societies.'),
  ('A Short History of Nearly Everything', 'Bill Bryson', 'Science', 4.6, 34100, '#0077B6', 'A tour of science for the curious.'),
  ('Thinking, Fast and Slow', 'Daniel Kahneman', 'Science', 4.4, 41700, '#FFFFFF', 'The two systems that drive how we think.'),
  ('Outliers', 'Malcolm Gladwell', 'Science', 4.4, 38200, '#212529', 'The story of success.'),
  ('The Tipping Point', 'Malcolm Gladwell', 'Science', 4.3, 31400, '#F77F00', 'How little things make a big difference.'),
  ('Blink', 'Malcolm Gladwell', 'Science', 4.2, 28900, '#000000', 'The power of thinking without thinking.'),
  ('A Brief History of Time', 'Stephen Hawking', 'Science', 4.5, 42800, '#0B0B0B', 'From the Big Bang to black holes.'),
  ('Cosmos', 'Carl Sagan', 'Science', 4.7, 29300, '#10002B', 'A personal voyage through the universe.'),
  ('The Selfish Gene', 'Richard Dawkins', 'Science', 4.3, 22600, '#D62828', 'Evolution from the gene''s point of view.'),
  ('The Immortal Life of Henrietta Lacks', 'Rebecca Skloot', 'Science', 4.5, 27100, '#3D405B', 'The woman behind the HeLa cell line.'),
  ('Educated', 'Tara Westover', 'Biography & Memoir', 4.7, 54300, '#8ECAE6', 'A woman leaves a survivalist family for university.'),
  ('Becoming', 'Michelle Obama', 'Biography & Memoir', 4.8, 61200, '#F4A261', 'The former First Lady''s memoir.'),
  ('The Diary of a Young Girl', 'Anne Frank', 'Biography & Memoir', 4.6, 48700, '#B5838D', 'A girl''s diary from hiding in Amsterdam.'),
  ('Steve Jobs', 'Walter Isaacson', 'Biography & Memoir', 4.6, 39400, '#1B1B1E', 'The authorized biography.'),
  ('When Breath Becomes Air', 'Paul Kalanithi', 'Biography & Memoir', 4.8, 42100, '#F2F2F2', 'A neurosurgeon confronts his own terminal diagnosis.'),
  ('Meditations', 'Marcus Aurelius', 'Philosophy', 4.6, 38200, '#5C677D', 'The private notes of a Roman emperor.'),
  ('The Republic', 'Plato', 'Philosophy', 4.2, 24800, '#22333B', 'Justice, the ideal city, and the soul.'),
  ('Beyond Good and Evil', 'Friedrich Nietzsche', 'Philosophy', 4.2, 18600, '#0B0B0B', 'A prelude to a philosophy of the future.'),
  ('Thus Spoke Zarathustra', 'Friedrich Nietzsche', 'Philosophy', 4.1, 21300, '#3A3A3A', 'Zarathustra descends to teach the Übermensch.'),
  ('The Art of War', 'Sun Tzu', 'Philosophy', 4.4, 42600, '#780000', 'The classic treatise on strategy.'),
  ('Letters from a Stoic', 'Seneca', 'Philosophy', 4.6, 19400, '#606C38', 'Practical Stoic advice in letter form.'),
  ('The Prince', 'Niccolò Machiavelli', 'Philosophy', 4.0, 26700, '#3C1518', 'On acquiring and holding political power.'),

  -- ---------- Poetry ----------
  ('Milk and Honey', 'Rupi Kaur', 'Poetry', 4.0, 38400, '#F2F2F2', 'Poems on survival, love, and healing.'),
  ('The Sun and Her Flowers', 'Rupi Kaur', 'Poetry', 4.2, 26800, '#FFD166', 'A collection on growth and rooting.'),
  ('Leaves of Grass', 'Walt Whitman', 'Poetry', 4.3, 18200, '#40916C', 'The expansive American poetic collection.'),
  ('The Waste Land and Other Poems', 'T.S. Eliot', 'Poetry', 4.2, 14700, '#5C677D', 'Modernist poems of fragmentation and myth.'),
  ('Ariel', 'Sylvia Plath', 'Poetry', 4.3, 16300, '#B71C1C', 'The late, fierce poems of Sylvia Plath.'),
  ('The Bell Jar', 'Sylvia Plath', 'Literary Fiction', 4.2, 34600, '#E5989B', 'A young woman''s descent and treatment.'),
  ('Devotions', 'Mary Oliver', 'Poetry', 4.8, 21400, '#606C38', 'Selected poems on nature and attention.')
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
-- Feature one title on the home screen's "Book of the week".
-- ============================================================
update public.books set is_book_of_week = false where is_book_of_week;

update public.books
set is_book_of_week = true
where title = 'Rich Dad Poor Dad' and author_name = 'Robert T. Kiyosaki';

-- ============================================================
-- Sanity check: how many books landed, and did any miss a genre?
-- ============================================================
-- select count(*) as total_books from public.books;
-- select title, author_name from public.books where genre_id is null;
