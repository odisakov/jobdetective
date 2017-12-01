require 'csv'
require 'faker'
require 'open-uri'
require 'nokogiri'
require 'clearbit'
Clearbit.key = ENV['CLEARBIT']


# Load Companies from CSV & Add Users from Clearbit

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
csv_text = File.read(Rails.root.join('lib', 'seeds', 'crunch.csv'))

csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  #Create Company
  c = Company.new
  c.name = row['name']
  c.city = row['location_city']
  c.country = row['location_country_code']
  c.short_description = row['short_description']
  c.logo_url = row['profile_image_url']
  c.homepage_url = row['homepage_url']
  c.homepage_domain = row['homepage_domain']
  c.save
  p "Created Company #{c.name}"

  # Fetch clearbit data
  p "Fetching clearbit employees for #{c.homepage_domain}"
  people = Clearbit::Prospector.search(domain: c.homepage_domain)

  people.each do |user|
    # Create Users from Clearbit data
    u = User.create!(
     company: c,
     email: user["email"],
     password: Faker::Crypto.md5,
     linkedin_pic_url: "https://dizivizi.com/mbb/imgs/site/default_user.png",
     first_name: user["name"]["givenName"],
     last_name: user["name"]["familyName"],
     employment_role: user["role"],
     title: user["title"],
     seniority: user["seniority"]
     )
    p "Created User #{u.first_name} #{u.last_name}"
  end
end







# Clearbit example
# company = Clearbit::Enrichment::Company.find(domain: 'babbel.com') #returns company

# people = Clearbit::Prospector.search(domain: 'babbel.com')

# people.each do |person|
#   puts [person.name.full_name, person.title].join(' - ')
# end

# Clearbit People Search results => Array
# [
# {"id"=>"e_c8ada464-06e5-4f61-9697-a33a42e8b029", "name"=>{"fullName"=>"Boris Diebold", "givenName"=>"Boris", "familyName"=>"Diebold"}, "title"=>"CTO", "role"=>"engineering", "seniority"=>"executive", "email"=>"bdiebold@babbel.com", "verified"=>true}
# {"id"=>"e_53880e74-0029-4567-9c85-46453dc63378", "name"=>{"fullName"=>"Markus Witte", "givenName"=>"Markus", "familyName"=>"Witte"}, "title"=>"CEO", "role"=>"ceo", "seniority"=>"executive", "email"=>"mwitte@babbel.com", "verified"=>true}
# {"id"=>"e_173074bf-fb92-457f-a100-562f46559a4d", "name"=>{"fullName"=>"Deepa Miglani", "givenName"=>"Deepa", "familyName"=>"Miglani"}, "title"=>"SVP, Marketing", "role"=>"marketing", "seniority"=>"executive", "email"=>"dmiglani@babbel.com", "verified"=>true}
# {"id"=>"e_82caeebe-b8eb-43eb-8ed4-21fbc75faf86", "name"=>{"fullName"=>"Scott Weiss", "givenName"=>"Scott", "familyName"=>"Weiss"}, "title"=>"VP Product Design", "role"=>"product", "seniority"=>"executive", "email"=>"sweiss@babbel.com", "verified"=>true}
# {"id"=>"e_7910a985-570c-4d73-bea8-5bfb3db0c07a", "name"=>{"fullName"=>"Julie Hansen", "givenName"=>"Julie", "familyName"=>"Hansen"}, "title"=>"CEO, US", "role"=>"ceo", "seniority"=>"executive", "email"=>"jhansen@babbel.com", "verified"=>true}
# ]

# User from Clearbit
# company = "Babbel"
# user = {"id"=>"e_c8ada464-06e5-4f61-9697-a33a42e8b029", "name"=>{"fullName"=>"Boris Diebold", "givenName"=>"Boris", "familyName"=>"Diebold"}, "title"=>"CTO", "role"=>"engineering", "seniority"=>"executive", "email"=>"bdiebold@babbel.com", "verified"=>true}

# u = User.create!(
#     company: Company.find_by_name(company),
#     email: user["email"],
#     password: Faker::Crypto.md5,
#     linkedin_pic_url: "https://dizivizi.com/mbb/imgs/site/default_user.png",
#     first_name: user["name"]["givenName"],
#     last_name: user["name"]["familyName"],
#     employment_role: user["role"],
#     title: user["title"],
#     seniority: user["seniority"]
#     )
# u.each do |e|
#   puts e
# end



# builtwith = "https://builtwith.com/"

# # file = "/Users/daniel/Downloads/built.html"
# # doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

# # doc.search('.techItem > h3').each_with_index do |element, index|
# #   puts "#{index + 1}. #{element.text.strip}"
# # end

# csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'crunch.csv'))

# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   #Create Company
#   c = Company.new
#   c.name = row['name']
#   c.city = row['location_city']
#   c.country = row['location_country_code']
#   c.short_description = row['short_description']
#   c.logo_url = row['profile_image_url']
#   c.homepage_url = row['homepage_url']
#   c.homepage_domain = row['homepage_domain']
#   c.save

#   # p "Created Company #{c.name}"


#   # Scraping Techs for Company
#   bw_url = "#{builtwith}#{c.homepage_domain}"
#   p "Start scraping #{bw_url}"
#   doc = Nokogiri::HTML(open(bw_url), nil, 'utf-8')
#   bw_tools = []
#   doc.search('.techItem > h3').each do |element|
#     bw_tools << element.text.strip
#   end
#   # p "Scraping complete"

#   # for each tool check if exits
#   bw_tools.each do |tool|
#     exist = Tool.find_by_name(tool)
#     if exist
#       p "#{tool} found in DB."
#       ct = CompanyTool.create!(
#         company: c,
#         tool: exist
#         )
#       ct.save
#       p "CompanyTool created"
#     else
#       p "#{tool} NOT found. Creating.."
#       new_tool = Tool.new
#       new_tool.name = tool
#       new_tool.save
#       ct = CompanyTool.create!(
#         company: c,
#         tool: new_tool
#         )
#       ct.save
#       p "CompanyTool created"

#     end
#   end
# end



# # tools = %w(rails php asp python facebook adwords git css html javascript)
# # role = %w(ceo engineering sales)

# # tools.each do |technology|
# #   t = Tool.create!(
# #     name: technology
# #     )
# # end



# # 100.times do
# #   u = User.create!(
# #     # name: Faker::Name.name,
# #     company: Company.order("RANDOM()").first,
# #     email: Faker::Internet.email,
# #     password: Faker::Crypto.md5,
# #     linkedin_pic_url: "https://dizivizi.com/mbb/imgs/site/default_user.png",
# #     first_name: Faker::Name.first_name,
# #     last_name: Faker::Name.last_name,
# #     employment_role: role.sample
# #     )
# # end

# # 10.times do
# #   ct = CompanyTool.create!(
# #     company_id: rand(1..10),
# #     tool_id: rand(1..10)
# #     )
# # end


# # 10.times do
# #   ct = UserTool.create!(
# #     user_id: rand(1..10),
# #     tool_id: rand(1..10)
# #     )
# # end
