require 'csv'
require 'faker'
require 'open-uri'
require 'nokogiri'

file = "/Users/daniel/Downloads/built.html"
doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

# doc.search('.techItem > h3').each_with_index do |element, index|
#   puts "#{index + 1}. #{element.text.strip}"
# end

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
csv_text = File.read(Rails.root.join('lib', 'seeds', 'crunch.csv'))

csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  c = Company.new
  c.name = row['name']
  c.city = row['location_city']
  c.country = row['location_country_code']
  c.short_description = row['short_description']
  c.logo_url = row['profile_image_url']
  c.save
end




# tools = %w(rails php asp python facebook adwords git css html javascript)
# role = %w(ceo engineering sales)

# tools.each do |technology|
#   t = Tool.create!(
#     name: technology
#     )
# end



# 100.times do
#   u = User.create!(
#     # name: Faker::Name.name,
#     company: Company.order("RANDOM()").first,
#     email: Faker::Internet.email,
#     password: Faker::Crypto.md5,
#     linkedin_pic_url: "https://dizivizi.com/mbb/imgs/site/default_user.png",
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     employment_role: role.sample
#     )
# end

# 10.times do
#   ct = CompanyTool.create!(
#     company_id: rand(1..10),
#     tool_id: rand(1..10)
#     )
# end


# 10.times do
#   ct = UserTool.create!(
#     user_id: rand(1..10),
#     tool_id: rand(1..10)
#     )
# end
