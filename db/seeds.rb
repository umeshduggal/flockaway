# coding: utf-8

puts 'Seeding the database...'

[
  # { pt: 'Arte', en: 'Art', fr: 'Art'},
  # { pt: 'Artes plásticas', en: 'Visual Arts', fr: 'Art plastique' },
  # { pt: 'Circo', en: 'Circus', fr: 'Cirque' },
  # { pt: 'Comunidade', en: 'Community', fr: 'Comunauté' },
  # { pt: 'Humor', en: 'Humor', fr: 'Humour' },
  # { pt: 'Quadrinhos', en: 'Comicbooks', fr: 'bd' },
  # { pt: 'Dança', en: 'Dance', fr: 'Dance' },
  # { pt: 'Design', en: 'Design', fr: 'Design' },
  # { pt: 'Eventos', en: 'Events', fr: 'Événementiel' },
  # { pt: 'Moda', en: 'Fashion', fr: 'Mode' },
  # { pt: 'Gastronomia', en: 'Gastronomy', fr: 'Gastronomie' },
  # { pt: 'Cinema e Vídeo', en: 'Film & Video', fr: 'Cinéma' },
  # { pt: 'Jogos', en: 'Games', fr: 'Jeux' },
  # { pt: 'Jornalismo', en: 'Journalism', fr: 'Journalisme' },
  # { pt: 'Música', en: 'Music', fr: 'Musique' },
  # { pt: 'Fotografia', en: 'Photography', fr: 'Photographie' },
  # { pt: 'Ciência e Tecnologia', en: 'Science & Technology', fr: 'Sciences et technologies' },
  # { pt: 'Teatro', en: 'Theatre', fr: 'Théatre' },
  # { pt: 'Esporte', en: 'Sport', fr: 'Sport' },
  # { pt: 'Web', en: 'Web', fr: 'Web' },
  # { pt: 'Carnaval', en: 'Carnival', fr: 'Carnaval' },
  # { pt: 'Arquitetura e Urbanismo', en: 'Architecture & Urbanism', fr: 'Architecture et Urbanisme' },
  # { pt: 'Literatura', en: 'Literature', fr: 'Literature' },
  # { pt: 'Mobilidade e Transporte', en: 'Mobility & Transportation', fr: 'Transport et Mobilité' },
  # { pt: 'Meio Ambiente', en: 'Environment', fr: 'Environement' },
  # { pt: 'Negócios Sociais', en: 'Social Business', fr: 'Social' },
  # { pt: 'Educação', en: 'Education', fr: 'Éducation' },
  # { pt: 'Filmes de Ficção', en: 'Fiction Films' , fr: 'Films de fiction'},
  # { pt: 'Filmes Documentários', en: 'Documentary Films', fr: 'Films documentaire' },
  # { pt: 'Filmes Universitários', en: 'Experimental Films' },
  # { pt: 'Saúde', en: 'Health', fr: 'Santé' }
{ pt: 'Mumbai', en: 'Mumbai', fr: 'Art'},
  { pt: 'Delhi', en: 'Delhi', fr: 'Art plastique' },
  { pt: 'Bangalore', en: 'Bangalore', fr: 'Cirque' },
  { pt: 'Chennai', en: 'Chennai', fr: 'Comunauté' },
  { pt: 'Hyderabad', en: 'Hyderabad', fr: 'Humour' },
  { pt: 'Ahmedabad', en: 'Ahmedabad', fr: 'bd' },
  { pt: 'Kolkata', en: 'Kolkata', fr: 'Dance' },
  { pt: 'Surat', en: 'Surat', fr: 'Design' },
  { pt: 'Pune', en: 'Pune', fr: 'Événementiel' },
  { pt: 'Jaipur', en: 'Jaipur', fr: 'Mode' },
  { pt: 'Lucknow', en: 'Lucknow', fr: 'Gastronomie' },
  { pt: 'Kanpur', en: 'Kanpur', fr: 'Cinéma' },
  { pt: 'Nagpur', en: 'Nagpur', fr: 'Jeux' },
  { pt: 'Visakhapatnam', en: 'Visakhapatnam', fr: 'Journalisme' },
  { pt: 'Indore', en: 'Indore', fr: 'Musique' },
  { pt: 'Thane', en: 'Thane', fr: 'Photographie' },
  { pt: 'Bhopal', en: 'Bhopal', fr: 'Sciences et technologies' },
  { pt: 'Patna', en: 'Patna', fr: 'Théatre' },
  { pt: 'Ludhiana', en: 'Ludhiana', fr: 'Sport' },
  { pt: 'Agra', en: 'Agra', fr: 'Web' },
  { pt: 'Srinagar', en: 'Srinagar', fr: 'Carnaval' },
  { pt: 'Amritsar', en: 'Amritsar', fr: 'Architecture et Urbanisme' },
  { pt: 'Thiruvananthapuram', en: 'Thiruvananthapuram', fr: 'Literature' },
  { pt: 'Chandigarh', en: 'Chandigarh', fr: 'Transport et Mobilité' },
  { pt: 'Solapur', en: 'Solapur', fr: 'Environement' },
  { pt: 'Ranchi', en: 'Ranchi', fr: 'Social' },
  { pt: 'Jodhpur', en: 'Jodhpur', fr: 'Éducation' },
  { pt: 'Guwahati', en: 'Guwahati' , fr: 'Films de fiction'},
  { pt: 'Gwalior', en: 'Gwalior', fr: 'Films documentaire' },
  { pt: 'Varanasi', en: 'Varanasi',fr: 'Varanasi' },
  { pt: 'Kota', en: 'Kota', fr: 'Santé' }

].each do |name|
   category = Category.find_or_initialize_by(name_pt: name[:pt])
   category.update_attributes({
     name_en: name[:en]
   })
   category.update_attributes({
     name_fr: name[:fr]
   })
 end


{
  company_name: 'Flockaway',
  company_logo: 'http://catarse.me/assets/catarse_bootstrap/logo_icon_catarse.png',
  host: 'flockaway.to',
  base_url: "http://flockaway.to",

  email_contact: 'contact@flockaway.to',
  email_payments: 'financial@flockaway.to',
  email_projects: 'projects@flockaway.to',
  email_system: 'system@flockaway.to',
  email_no_reply: 'no-reply@flockaway.to',
  facebook_url: "http://facebook.com/catarse.me",
  facebook_app_id: '173747042661491',
  twitter_url: 'http://twitter.com/flockaway',
  twitter_username: "flockaway",
  mailchimp_url: "http://catarse.us5.list-manage.com/subscribe/post?u=ebfcd0d16dbb0001a0bea3639&amp;id=149c39709e",
  catarse_fee: '0.13',
  support_forum: 'http://suporte.catarse.me/',
  base_domain: 'flockaway.to',
  uservoice_secret_gadget: 'change_this',
  uservoice_key: 'uservoice_key',
  faq_url: 'http://suporte.catarse.me/',
  feedback_url: 'http://suporte.catarse.me/forums/103171-catarse-ideias-gerais',
  terms_url: 'http://suporte.catarse.me/knowledgebase/articles/161100-termos-de-uso',
  privacy_url: 'http://suporte.catarse.me/knowledgebase/articles/161103-pol%C3%ADtica-de-privacidade',
  about_channel_url: 'http://blog.catarse.me/conheca-os-canais-do-catarse/',
  instagram_url: 'http://instagram.com/flockaway_',
  blog_url: "http://blog.catarse.me",
  github_url: 'http://github.com/umeshduggal',
  contato_url: 'http://suporte.catarse.me/'
}.each do |name, value|
   conf = CatarseSettings.find_or_initialize_by(name: name)
   conf.update_attributes({
     value: value
   }) if conf.new_record?
end

OauthProvider.find_or_create_by!(name: 'facebook') do |o|
  o.key = 'your_facebook_app_key'
  o.secret = 'your_facebook_app_secret'
  o.path = 'facebook'
end

puts
puts '============================================='
puts ' Showing all Authentication Providers'
puts '---------------------------------------------'

OauthProvider.all.each do |conf|
  a = conf.attributes
  puts "  name #{a['name']}"
  puts "     key: #{a['key']}"
  puts "     secret: #{a['secret']}"
  puts "     path: #{a['path']}"
  puts
end


puts
puts '============================================='
puts ' Showing all entries in Configuration Table...'
puts '---------------------------------------------'

CatarseSettings.all.each do |conf|
  a = conf.attributes
  puts "  #{a['name']}: #{a['value']}"
end

Rails.cache.clear

puts '---------------------------------------------'
puts 'Done!'
